-- Infusions and other inputs for the cohort ICU stays, started up to 24 hours after ICU admission.
WITH index_stays AS (
  SELECT c.stay_id, i.intime
  FROM `bowyerlab-mimic-teaching.sdsai_mimiciv_cardiac_surgery_views.cohort_stays` AS c
  JOIN `physionet-data.mimiciv_3_1_icu.icustays` AS i USING (stay_id)
)
SELECT ie.subject_id, ie.hadm_id, ie.stay_id, ie.itemid, ie.starttime, ie.endtime, ie.amount, ie.amountuom,
  ie.rate, ie.rateuom, ie.patientweight, ie.ordercategoryname, ie.statusdescription
FROM `physionet-data.mimiciv_3_1_icu.inputevents` AS ie
JOIN index_stays AS s USING (stay_id)
WHERE ie.starttime <= TIMESTAMP_ADD(s.intime, INTERVAL 24 HOUR)
