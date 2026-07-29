SELECT
    m.model_name,
    COUNT(mm.modality_id) AS supported_modalities
FROM Models m
JOIN Model_Modalities mm
ON m.model_id = mm.model_id
GROUP BY m.model_name
ORDER BY supported_modalities DESC;