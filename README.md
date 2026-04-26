<div align="center">
  <h1>🏦 Bank Portfolio Risk & Customer Segmentation</h1>
  <p><i>Technical Audit of Credit Risk, Basel III Provisioning, and NIM Optimization</i></p>
  
 <img src="reports/charts/00_Executive_Dashboard_Full.png" width="900" alt="Executive Dashboard">

<p>
 <b>Analyst:</b> Christopher Oroo | <b>Status:</b> Production Ready <br>
 <b>Stack:</b> <code>Google BigQuery (SQL)</code> <code>Python</code> <code>Excel</code>
</p>
</div>

---


## I. Executive Summary: The Bottom Line
**Problem:** The bank is currently operating with an **18% capital charge** and realizing a loss on **100% of its Tier 3 Renter segment**. The legacy credit grading system fails to account for **Debt Capacity**, leading to severe under-pricing of portfolio risk and a degraded Net Interest Margin (NIM).

**Strategy:** Architected a tri-tier risk framework in Google BigQuery, deploying a **Governed View Layer** to resolve a 9.56% data documentation gap, and engineered high-signal predictive metrics (e.g., Loan-to-Income [LTI] Ratios).

**Financial Impact:**
*   **Identified $12.5M in "Toxic Exposure":** Confirmed a 100% historical default correlation for high-LTI Renters.
*   **Capital Release:** Proposed a 0.30 LTI Cap to trigger a **$50M+ Long-Term Capital Release** as toxic stock runs off the balance sheet.
*   **NIM Restoration:** Recommended a **14.5% interest rate floor** for Prime Renters to flip a negative Net Risk Margin into profitability.

---

## II. Analytical Infrastructure & Governance
### 1. Cloud-Native Environment
*   **Platform:** Google BigQuery (Simulating a multi-million row enterprise environment).
*   **Security:** Architected a **Python-to-BigQuery bridge** utilizing tokenized OAuth 2.0.
*   **Cost Control:** Implemented a **50MB Safety Guardrail** and mandatory **Dry Run Audits** to ensure query cost-efficiency.

### 2. Data Triage, Hardening & Integrity Audit
Anchored the ETL pipeline against a raw baseline of 32,581 loan records. Successfully audited ETL integrity via a `UNION ALL` reconciliation, establishing a **1:1 row count parity** between Raw and Hardened assets.

**Data Health & Imputation Report:**
| Metric | Total Loans | Null Interest Rows | Null Employment Rows | % Interest Gap |
| :--- | :---: | :---: | :---: | :---: |
| **Volume** | 32,581 | 3,116 | 895 | **9.56%** |

*   **Imputation Integrity:** Conducted a comparative stress test between the Imputed (Gap) and Original (Clean) datasets. Statistical parity in Default Rates (20.67% vs. 21.94%) validates that the missing data is **Missing At Random (MAR)**, confirming grade-level median imputation as a **non-biasing strategy**.
*   **Strategic Recommendation:** Data Operations must investigate the source extraction pipeline. A 9.56% documentation failure rate represents an operational risk that must be remediated at the root.

---

## III. Financial Risk Insights

### 1. Model Failure: The Flaw in Legacy Credit Grades
Testing the bank's traditional Credit Grades (A-G) revealed a massive underwriting blind spot: **Debt beats historical behavior.**
*   **The Flaw:** A "Grade A" applicant with a perfect history but massive new debt (Tier 3 LTI) exhibits a default rate spike to **66.3%**. The legacy system ignores current debt capacity.
*   **The Toxic Tail:** Any loan graded D, E, F, or G has a default rate over 50%. These segments are guaranteed capital drains.

### 2. The "Insolvency Frontier"
![Insolvency Frontier](reports/charts/02_Insolvency_Frontier_Scatter.png)

The analysis reveals a **"Hard Wall"** for Renters at **0.40 LTI**. Beyond this threshold, Probability of Default (PD) becomes a mathematical certainty (100%), making the segment un-priceable regardless of interest yield.

### 3. Multivariate Risk Discovery: The "Collateral Buffer"
By cross-tabulating LTI Risk Tiers against Home Ownership, I isolated severe risk concentrations alongside hyper-stable "Safe Harbors."

| Risk Tier | Ownership | Volume | Default Rate (PD) | Exposure at Default (EAD) |
| :--- | :--- | :---: | :---: | :--- |
| **Tier 3 (Subprime)** | **RENT** | 754 | **100.00%** | **$12.57M** |
| **Tier 2 (Standard)** | **RENT** | 8,040 | **39.91%** | **$90.04M** |
| **Tier 2 (Standard)** | MORTGAGE | 5,309 | 16.12% | $77.84M |
| **Tier 1 (Prime)** | OWN | 1,162 | **0.95%** | $7.28M |

*   **The Systemic Threat:** Tier 2 Renters are the bank's largest "Hidden Fire," carrying a 39.9% default rate across $90M in exposure.
*   **The Collateral Buffer:** Outright Owners in Tier 1 display an ultra-stable 0.95% PD. Tier 2 Mortgage holders default at less than half the rate of their Renter counterparts (16.1% vs 39.9%).

### 4. Root Cause Analysis: The "Intent" Illusion & Occupancy Fraud
Isolating Tier 3 Renters exposed a systemic failure where debt-stress overrides loan intent. Once an LTI of ~0.47 is reached, mathematical capacity to repay breaks completely.

| Loan Intent | Volume | Default Rate (PD) | Avg. LTI | Status |
| :--- | :---: | :---: | :---: | :--- |
| Medical / Debt Consolidation | 301 | 100.00% | ~0.470 | 🔴 Toxic |
| **Home Improvement** | **75** | **100.00%** | **0.478** | ⚠️ **Potential Fraud** |
| Education / Venture | 254 | 100.00% | 0.472 | 🔴 Toxic |

*   **The Fraud Alert:** 75 "Home Improvement" loans were issued to Renters resulting in total loss. Statistically, tenants do not invest an average of $17,600 into unowned properties. This indicates a severe breakdown in **Verification of Assets (VOA)** and likely occupancy fraud.

### 5. Financial Modeling: Basel III Provisioning & Yield Audit
![NIM Gap](reports/charts/01_NIM_Gap_Chart.png)

**Business Goal:** Quantify capital reserve requirements and identify "Negative Spread" segments by comparing Interest Yield vs. Expected Credit Loss (ECL).

| Risk Tier | Total Exposure | PD % | Required Reserves | Avg. Yield | Loss Intensity |
| :--- | :--- | :---: | :---: | :---: | :---: |
| **Tier 1 (Prime)** | $109M | 11.89% | **$9.07M** | 10.63% | 8.32% |
| **Tier 2 (Standard)**| $182M | 28.84% | **$36.87M** | 11.39% | **20.19%** |
| **Tier 3 (Subprime)**| $20.7M | 74.62% | **$10.82M** | 11.71% | **52.23%** |

*   **The Yield-to-Loss Deficit:** The bank charges an 11.39% yield in Tier 2 but faces a 20.19% Loss Intensity, creating an **8.8% net leak** on every dollar lent.
*   **The Capital Trap:** Tier 2 consumes **$36.8M in Required Reserves**. This "trapped capital" severely depresses the bank's Return on Equity (ROE).

---

## IV. The CRO Action Plan: Strategic Recommendations
To restore the Net Interest Margin (NIM) and protect core capital, I recommend a three-pillar remediation strategy:

**1. Elimination & Provisions (Non-Viable Segments)**
*   **Origination Moratorium:** Immediately halt all lending to Tier 3 Renters. Reclassify the $12.5M exposure from "Expected Loss" to "Realized Loss" (Write-off) to reflect true liquidity.
*   **Forensic Fraud Audit:** Mandate an immediate investigation into the 75 "Home Improvement" Renter loans for misrepresentation at origin.
*   **ECL Adjustment:** Increase IFRS 9 / CECL provisions for the Tier 2 Renter segment ($90M exposure) to account for the discovered 39.9% default rate.

**2. Risk Filtering (Underwriting Migration Control)**
*   **LTI "Circuit Breaker":** Implement an automated Hard LTI Cap of 0.30 for all unsecured Renter applications.
*   **Grade Override:** Regardless of a perfect Credit Grade (A/B), any applicant exhibiting an LTI > 0.40 must be automatically rejected.

**3. Repricing (Margin Correction)**
*   **Collateral-Adjusted Pricing:** Implement a mandatory **15% "Unsecured Surcharge"** for non-homeowners. 
*   **Rate Floors:** Reprice Tier 1 Renters to a minimum **13.24% floor** to achieve a 2% profit buffer above the cost of risk. If a ~30% required yield for Tier 2 Renters is not market-viable, the bank must exit the segment entirely.

---

## V. Repository Structure & Reproducibility
Organized via the **Data Medallion Architecture**:
*   `scripts/sql/`: Pure logic for data hardening, segmentation, and provisioning.
*   `scripts/python/`: The automation engine, configuration, and cost-control gateway.
*   `notebook/`: The full analytical narrative and "Head-to-Tail" execution.
*   `reports/`: Houses the Excel Decision Sandbox and visual risk heatmaps.

**To Reproduce Results:**
1. Configure `scripts/python/config.py` with your GCP Project ID.
2. Execute `notebook/Risk_Pipeline.ipynb` to deploy the **Governed View Layer** and generate financial reports.
