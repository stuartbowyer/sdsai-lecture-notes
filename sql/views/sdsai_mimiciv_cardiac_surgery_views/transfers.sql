-- Ward and unit moves for the cohort, up to and including arrival in the cohort ICU stay.
WITH index_times AS (
  -- each cohort patient's latest cohort ICU admission; nothing after it is included
  SELECT c.subject_id, MAX(i.intime) AS index_intime
  FROM `bowyerlab-mimic-teaching.sdsai_mimiciv_cardiac_surgery_views.cohort_stays` AS c
  JOIN `physionet-data.mimiciv_3_1_icu.icustays` AS i USING (stay_id)
  GROUP BY c.subject_id
)
SELECT tr.*
FROM `physionet-data.mimiciv_3_1_hosp.transfers` AS tr
JOIN index_times AS t USING (subject_id)
WHERE tr.intime <= t.index_intime
