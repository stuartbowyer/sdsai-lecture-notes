-- Ventilation episodes (invasive, non-invasive, high-flow, oxygen) during the cohort's ICU stays.
SELECT *
FROM `physionet-data.mimiciv_3_1_derived.ventilation`
WHERE stay_id IN (SELECT stay_id FROM `bowyerlab-mimic-teaching.sdsai_mimiciv_icu_small_views.icustays`)
