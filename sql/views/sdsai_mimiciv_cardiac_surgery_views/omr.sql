-- Outpatient measurements (weight, BMI, blood pressure) for the cohort, up to the day of ICU admission.
WITH index_times AS (
  -- each cohort patient's latest cohort ICU admission; nothing after it is included
  SELECT c.subject_id, MAX(i.intime) AS index_intime
  FROM `bowyerlab-mimic-teaching.sdsai_mimiciv_cardiac_surgery_views.cohort_stays` AS c
  JOIN `physionet-data.mimiciv_3_1_icu.icustays` AS i USING (stay_id)
  GROUP BY c.subject_id
)
SELECT o.*
FROM `physionet-data.mimiciv_3_1_hosp.omr` AS o
JOIN index_times AS t USING (subject_id)
WHERE o.chartdate <= DATE(t.index_intime)
