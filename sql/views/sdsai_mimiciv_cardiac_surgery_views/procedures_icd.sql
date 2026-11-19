-- Procedures from the cohort's earlier admissions, and from the surgical admission up to the day of ICU
-- admission (the operation itself). Later procedures in the surgical admission are left out.
WITH index_admissions AS (
  SELECT c.subject_id, c.hadm_id, DATE(i.intime) AS index_date, i.intime
  FROM `bowyerlab-mimic-teaching.sdsai_mimiciv_cardiac_surgery_views.cohort_stays` AS c
  JOIN `physionet-data.mimiciv_3_1_icu.icustays` AS i USING (stay_id)
),
index_times AS (
  SELECT subject_id, MAX(intime) AS index_intime FROM index_admissions GROUP BY subject_id
)
SELECT p.*
FROM `physionet-data.mimiciv_3_1_hosp.procedures_icd` AS p
JOIN index_times AS t USING (subject_id)
LEFT JOIN index_admissions AS ia USING (hadm_id)
WHERE (ia.hadm_id IS NULL AND p.chartdate < DATE(t.index_intime))
   OR (ia.hadm_id IS NOT NULL AND p.chartdate <= ia.index_date)
