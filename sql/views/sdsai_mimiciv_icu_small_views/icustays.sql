-- The cohort's ICU stays: stay_id links the derived first-day tables to an admission.
SELECT *
FROM `physionet-data.mimiciv_3_1_icu.icustays`
WHERE hadm_id IN (SELECT hadm_id FROM `bowyerlab-mimic-teaching.sdsai_mimiciv_icu_small_views.cohort`)
