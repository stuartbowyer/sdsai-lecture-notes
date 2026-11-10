-- Hospital services (e.g. CSURG, SURG, NSURG) for the cohort's ICU admissions, with the time of each transfer between services.
SELECT *
FROM `physionet-data.mimiciv_3_1_hosp.services`
WHERE hadm_id IN (SELECT hadm_id FROM `bowyerlab-mimic-teaching.sdsai_mimiciv_icu_small_views.cohort`)
