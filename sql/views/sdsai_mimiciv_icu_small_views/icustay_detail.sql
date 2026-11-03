-- One row per ICU stay for the cohort, with the patient and admission fields the derived tables join on.
SELECT *
FROM `physionet-data.mimiciv_3_1_derived.icustay_detail`
WHERE hadm_id IN (SELECT hadm_id FROM `bowyerlab-mimic-teaching.sdsai_mimiciv_icu_small_views.cohort`)
