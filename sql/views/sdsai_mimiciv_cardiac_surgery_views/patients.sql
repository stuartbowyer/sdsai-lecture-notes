-- The cohort's patients. anchor_age is age in anchor_year; dates are shifted per patient.
SELECT *
FROM `physionet-data.mimiciv_3_1_hosp.patients`
WHERE subject_id IN (SELECT subject_id FROM `bowyerlab-mimic-teaching.sdsai_mimiciv_cardiac_surgery_views.cohort_stays`)
