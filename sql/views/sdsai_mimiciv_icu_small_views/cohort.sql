-- A fixed 1-in-10 sample of MIMIC-IV patients who had an ICU stay, with their ICU admissions.
-- The hash of subject_id decides who is in, so the sample is the same every time it is run.
SELECT DISTINCT subject_id, hadm_id
FROM `physionet-data.mimiciv_3_1_icu.icustays`
WHERE MOD(ABS(FARM_FINGERPRINT(CAST(subject_id AS STRING))), 10) = 0
