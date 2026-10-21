-- The cohort's ICU admissions.
SELECT *
FROM `physionet-data.mimiciv_3_1_hosp.admissions`
WHERE hadm_id IN (SELECT hadm_id FROM `bowyerlab-mimic-teaching.sdsai_mimiciv_icu_small_views.cohort`)
