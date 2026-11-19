-- Lab results for the cohort, from a year before the cohort ICU admission to 24 hours after it.
-- Numeric columns only: each query scans every row of labevents for the columns it reads.
WITH index_times AS (
  -- each cohort patient's latest cohort ICU admission; nothing after it is included
  SELECT c.subject_id, MAX(i.intime) AS index_intime
  FROM `bowyerlab-mimic-teaching.sdsai_mimiciv_cardiac_surgery_views.cohort_stays` AS c
  JOIN `physionet-data.mimiciv_3_1_icu.icustays` AS i USING (stay_id)
  GROUP BY c.subject_id
)
SELECT l.subject_id, l.hadm_id, l.itemid, l.charttime, l.valuenum, l.valueuom
FROM `physionet-data.mimiciv_3_1_hosp.labevents` AS l
JOIN index_times AS t USING (subject_id)
WHERE l.charttime >= TIMESTAMP_SUB(t.index_intime, INTERVAL 365 DAY)
  AND l.charttime <= TIMESTAMP_ADD(t.index_intime, INTERVAL 24 HOUR)
