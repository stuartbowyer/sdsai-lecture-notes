-- The cohort's hospital admissions: the surgical admission and any earlier ones.
-- Discharge columns of the surgical admission describe its end, after both prediction times.
WITH index_times AS (
  -- each cohort patient's latest cohort ICU admission; nothing after it is included
  SELECT c.subject_id, MAX(i.intime) AS index_intime
  FROM `bowyerlab-mimic-teaching.sdsai_mimiciv_cardiac_surgery_views.cohort_stays` AS c
  JOIN `physionet-data.mimiciv_3_1_icu.icustays` AS i USING (stay_id)
  GROUP BY c.subject_id
)
SELECT a.*
FROM `physionet-data.mimiciv_3_1_hosp.admissions` AS a
JOIN index_times AS t USING (subject_id)
WHERE a.admittime <= t.index_intime
   OR a.hadm_id IN (SELECT hadm_id FROM `bowyerlab-mimic-teaching.sdsai_mimiciv_cardiac_surgery_views.cohort_stays`)  -- a few surgical admissions are timed after ICU admission
