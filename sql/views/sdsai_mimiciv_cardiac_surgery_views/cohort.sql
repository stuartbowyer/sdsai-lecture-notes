-- The coursework cohort: the first CVICU stay after each open CABG or valve operation, one row per stay.
-- aki: postoperative acute kidney injury within 7 days of ICU admission (intime). KDIGO creatinine criteria
--   against the last creatinine in the 30 days before ICU admission: a rise to at least 1.5 times it within
--   7 days, or of at least 0.3 mg/dL within 48 hours; or dialysis started within 7 days.
--   NULL when it cannot be judged: no creatinine in those 30 days, or chronic dialysis before surgery.
-- aki_onset_time: when the first of those criteria was met. Use it only to decide who is still at risk at
--   your prediction time; it is never a feature.
WITH first_stays AS (
  SELECT s.subject_id, s.hadm_id, s.stay_id, i.intime
  FROM `bowyerlab-mimic-teaching.sdsai_mimiciv_cardiac_surgery_views.cohort_stays` AS s
  JOIN `physionet-data.mimiciv_3_1_icu.icustays` AS i USING (stay_id)
),
creatinine AS (
  SELECT subject_id, charttime, valuenum
  FROM `physionet-data.mimiciv_3_1_hosp.labevents`
  WHERE itemid = 50912 AND valuenum IS NOT NULL
    AND subject_id IN (SELECT subject_id FROM first_stays)
),
baseline AS (
  SELECT f.stay_id, ARRAY_AGG(c.valuenum ORDER BY c.charttime DESC LIMIT 1)[OFFSET(0)] AS baseline_creatinine
  FROM first_stays AS f
  JOIN creatinine AS c
    ON c.subject_id = f.subject_id
   AND c.charttime < f.intime
   AND c.charttime >= TIMESTAMP_SUB(f.intime, INTERVAL 30 DAY)
  GROUP BY f.stay_id
),
creatinine_onset AS (
  SELECT f.stay_id, MIN(c.charttime) AS onset
  FROM first_stays AS f
  JOIN baseline AS b USING (stay_id)
  JOIN creatinine AS c
    ON c.subject_id = f.subject_id
   AND c.charttime >= f.intime
   AND c.charttime <= TIMESTAMP_ADD(f.intime, INTERVAL 7 DAY)
  WHERE c.valuenum >= 1.5 * b.baseline_creatinine
     OR (c.valuenum >= b.baseline_creatinine + 0.3 AND c.charttime <= TIMESTAMP_ADD(f.intime, INTERVAL 48 HOUR))
  GROUP BY f.stay_id
),
dialysis_onset AS (
  SELECT f.stay_id, MIN(r.charttime) AS onset
  FROM first_stays AS f
  JOIN `physionet-data.mimiciv_3_1_derived.rrt` AS r
    ON r.stay_id = f.stay_id
   AND r.dialysis_active = 1
   AND r.charttime >= f.intime
   AND r.charttime <= TIMESTAMP_ADD(f.intime, INTERVAL 7 DAY)
  GROUP BY f.stay_id
),
chronic_dialysis AS (
  -- end-stage kidney disease or dialysis dependence, coded in this or an earlier admission
  SELECT DISTINCT f.stay_id
  FROM first_stays AS f
  JOIN `physionet-data.mimiciv_3_1_hosp.admissions` AS a
    ON a.subject_id = f.subject_id AND a.admittime <= f.intime
  JOIN `physionet-data.mimiciv_3_1_hosp.diagnoses_icd` AS d ON d.hadm_id = a.hadm_id
  WHERE (d.icd_version = 10 AND d.icd_code IN ('N186', 'Z992'))
     OR (d.icd_version = 9 AND d.icd_code IN ('5856', 'V4511'))
)
SELECT
  f.subject_id,
  f.hadm_id,
  f.stay_id,
  CASE
    WHEN b.baseline_creatinine IS NULL OR chronic.stay_id IS NOT NULL THEN NULL
    WHEN cre.onset IS NOT NULL OR dia.onset IS NOT NULL THEN 1
    ELSE 0
  END AS aki,
  CASE
    WHEN b.baseline_creatinine IS NULL OR chronic.stay_id IS NOT NULL THEN NULL
    WHEN cre.onset IS NULL THEN dia.onset
    WHEN dia.onset IS NULL THEN cre.onset
    ELSE LEAST(cre.onset, dia.onset)
  END AS aki_onset_time
FROM first_stays AS f
LEFT JOIN baseline AS b USING (stay_id)
LEFT JOIN creatinine_onset AS cre USING (stay_id)
LEFT JOIN dialysis_onset AS dia USING (stay_id)
LEFT JOIN chronic_dialysis AS chronic USING (stay_id)
