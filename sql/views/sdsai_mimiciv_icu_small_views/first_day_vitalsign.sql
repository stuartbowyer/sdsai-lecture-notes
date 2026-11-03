-- Vital signs summarised over the first 24 hours of each of the cohort's ICU stays.
SELECT *
FROM `physionet-data.mimiciv_3_1_derived.first_day_vitalsign`
WHERE stay_id IN (SELECT stay_id FROM `bowyerlab-mimic-teaching.sdsai_mimiciv_icu_small_views.icustays`)
