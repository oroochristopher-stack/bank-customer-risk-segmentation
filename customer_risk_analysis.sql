-- Bank Customer Risk Segmentation Analysis
-- Explicitly setting job location to 'US' to align with the residency of the risk_analysis dataset.
-- if operating with tables from different regions, this innitial client should remain region agnostic i.e not directed to any location since it would operate as a global code location
WITH customer_segments AS (
