-- ICU procedures (lines, ventilation, balloon pump) for the cohort ICU stays, started up to 24 hours after ICU admission.
WITH index_stays AS (
  SELECT c.stay_id, i.intime
  FROM `bowyerlab-mimic-teaching.sdsai_mimiciv_cardiac_surgery_views.cohort_stays` AS c
  JOIN `physionet-data.mimiciv_3_1_icu.icustays` AS i USING (stay_id)
)
SELECT pe.subject_id, pe.hadm_id, pe.stay_id, pe.itemid, pe.starttime, pe.endtime, pe.value, pe.valueuom,
  pe.location, pe.ordercategoryname, pe.statusdescription
FROM `physionet-data.mimiciv_3_1_icu.procedureevents` AS pe
JOIN index_stays AS s USING (stay_id)
WHERE pe.starttime <= TIMESTAMP_ADD(s.intime, INTERVAL 24 HOUR)
