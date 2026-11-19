-- Diagnoses from the cohort's earlier admissions only. Codes for the surgical admission are assigned at
-- discharge, after both prediction times, so they are left out.
WITH index_times AS (
  -- each cohort patient's latest cohort ICU admission; nothing after it is included
  SELECT c.subject_id, MAX(i.intime) AS index_intime
  FROM `bowyerlab-mimic-teaching.sdsai_mimiciv_cardiac_surgery_views.cohort_stays` AS c
  JOIN `physionet-data.mimiciv_3_1_icu.icustays` AS i USING (stay_id)
  GROUP BY c.subject_id
)
SELECT d.*
FROM `physionet-data.mimiciv_3_1_hosp.diagnoses_icd` AS d
JOIN `physionet-data.mimiciv_3_1_hosp.admissions` AS a USING (hadm_id)
JOIN index_times AS t ON t.subject_id = a.subject_id
WHERE a.admittime < t.index_intime
  AND d.hadm_id NOT IN (SELECT hadm_id FROM `bowyerlab-mimic-teaching.sdsai_mimiciv_cardiac_surgery_views.cohort_stays`)
