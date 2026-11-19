-- The cohort's ICU stays without the outcome: the first CVICU stay after each admission's open CABG or
-- valve surgery (a few patients have two). The other views select from this one; the cohort view adds the outcome.
WITH surgery_codes AS (
  SELECT hadm_id, subject_id, chartdate
  FROM `physionet-data.mimiciv_3_1_hosp.procedures_icd`
  WHERE (icd_version = 10 AND REGEXP_CONTAINS(icd_code, r'^(021[0-3]0|02[RQ][FGHJ]0)'))  -- open CABG, valve replacement or repair
     OR (icd_version = 9 AND REGEXP_CONTAINS(icd_code, r'^(361|35[12])'))
),
surgical_admissions AS (
  SELECT hadm_id, ANY_VALUE(subject_id) AS subject_id, MIN(chartdate) AS surgery_date
  FROM surgery_codes
  GROUP BY hadm_id
),
stays AS (
  SELECT s.subject_id, s.hadm_id, i.stay_id, i.intime,
    ROW_NUMBER() OVER (PARTITION BY s.hadm_id ORDER BY i.intime) AS stay_order
  FROM surgical_admissions AS s
  JOIN `physionet-data.mimiciv_3_1_icu.icustays` AS i USING (hadm_id)
  WHERE i.first_careunit LIKE '%CVICU%' AND DATE(i.intime) >= s.surgery_date
),
first_stays AS (
  SELECT subject_id, hadm_id, stay_id, intime FROM stays WHERE stay_order = 1
)
SELECT subject_id, hadm_id, stay_id FROM first_stays
