-- Heart rate readings (itemid 220045) for the cohort's ICU admissions.
-- Few columns because each query scans every row of chartevents for the columns it reads.
SELECT hadm_id, charttime, itemid, valuenum
FROM `physionet-data.mimiciv_3_1_icu.chartevents`
WHERE itemid = 220045
  AND hadm_id IN (SELECT hadm_id FROM `bowyerlab-mimic-teaching.sdsai_mimiciv_icu_small_views.cohort`)
