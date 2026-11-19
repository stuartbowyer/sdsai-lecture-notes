-- Outputs (urine, drains) for the cohort ICU stays, up to 24 hours after ICU admission.
WITH index_stays AS (
  SELECT c.stay_id, i.intime
  FROM `bowyerlab-mimic-teaching.sdsai_mimiciv_cardiac_surgery_views.cohort_stays` AS c
  JOIN `physionet-data.mimiciv_3_1_icu.icustays` AS i USING (stay_id)
)
SELECT oe.subject_id, oe.hadm_id, oe.stay_id, oe.itemid, oe.charttime, oe.value, oe.valueuom
FROM `physionet-data.mimiciv_3_1_icu.outputevents` AS oe
JOIN index_stays AS s USING (stay_id)
WHERE oe.charttime <= TIMESTAMP_ADD(s.intime, INTERVAL 24 HOUR)
