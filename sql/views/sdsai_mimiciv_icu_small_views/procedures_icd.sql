-- Procedures coded for the cohort's ICU admissions (ICD-9 or ICD-10-PCS), dated but not timed.
SELECT *
FROM `physionet-data.mimiciv_3_1_hosp.procedures_icd`
WHERE hadm_id IN (SELECT hadm_id FROM `bowyerlab-mimic-teaching.sdsai_mimiciv_icu_small_views.cohort`)
