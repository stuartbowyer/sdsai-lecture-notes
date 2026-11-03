-- Laboratory results summarised over the first 24 hours of each of the cohort's ICU stays.
SELECT *
FROM `physionet-data.mimiciv_3_1_derived.first_day_lab`
WHERE stay_id IN (SELECT stay_id FROM `bowyerlab-mimic-teaching.sdsai_mimiciv_icu_small_views.icustays`)
