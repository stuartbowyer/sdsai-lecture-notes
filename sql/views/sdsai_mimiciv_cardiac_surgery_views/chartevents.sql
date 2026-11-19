-- Bedside charting for the cohort ICU stays, up to 24 hours after ICU admission.
-- Four columns only: each query scans every row of chartevents for the columns it reads (about 11 GiB).
-- Units are in d_items (unitname); link to the patient through icustays.
WITH index_stays AS (
  SELECT c.stay_id, i.intime
  FROM `bowyerlab-mimic-teaching.sdsai_mimiciv_cardiac_surgery_views.cohort_stays` AS c
  JOIN `physionet-data.mimiciv_3_1_icu.icustays` AS i USING (stay_id)
)
SELECT ce.stay_id, ce.itemid, ce.charttime, ce.valuenum
FROM `physionet-data.mimiciv_3_1_icu.chartevents` AS ce
JOIN index_stays AS s USING (stay_id)
WHERE ce.charttime <= TIMESTAMP_ADD(s.intime, INTERVAL 24 HOUR)
  AND ce.valuenum IS NOT NULL
