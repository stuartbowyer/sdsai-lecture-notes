-- Prescriptions for the cohort: earlier admissions, and the surgical admission up to 24 hours after ICU admission.
WITH index_times AS (
  -- each cohort patient's latest cohort ICU admission; nothing after it is included
  SELECT c.subject_id, MAX(i.intime) AS index_intime
  FROM `bowyerlab-mimic-teaching.sdsai_mimiciv_cardiac_surgery_views.cohort_stays` AS c
  JOIN `physionet-data.mimiciv_3_1_icu.icustays` AS i USING (stay_id)
  GROUP BY c.subject_id
)
SELECT p.subject_id, p.hadm_id, p.starttime, p.stoptime, p.drug_type, p.drug, p.prod_strength,
  p.dose_val_rx, p.dose_unit_rx, p.route
FROM `physionet-data.mimiciv_3_1_hosp.prescriptions` AS p
JOIN index_times AS t USING (subject_id)
WHERE p.starttime <= TIMESTAMP_ADD(t.index_intime, INTERVAL 24 HOUR)
