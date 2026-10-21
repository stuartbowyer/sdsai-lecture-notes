-- The patients in the cohort.
SELECT *
FROM `physionet-data.mimiciv_3_1_hosp.patients`
WHERE subject_id IN (SELECT subject_id FROM `bowyerlab-mimic-teaching.sdsai_mimiciv_icu_small_views.cohort`)
