# Bank Portfolio Risk & Customer Segmentation
**Analyst:** Christopher Oroo | **Project Status:** Production Ready | **Stack:** Google BigQuery (SQL), Python, Excel

---

## I. Executive Summary: The Bottom Line
**Problem:** The bank was operating with an **18% capital charge** and losing money on **100% of its Tier 3 Renter segments**. The legacy credit grading system failed to account for **Debt Capacity**, leading to severe under-pricing of risk.

**Strategy:** I architected a tri-tier risk framework in BigQuery, implementing a **Governed View Layer** that handles data imputation (**9.56% gap**) and engineers high-signal risk metrics like **LTI Ratios**.

**Impact:**
*   **Identified $12.5M in "Toxic Exposure":** Confirmed 100% default correlation for high-LTI Renters.
*   **Capital Release:** Proposed a 0.30 LTI Cap to trigger a **$50M+ Long-term Capital Release** as toxic stock runs off the balance sheet.
*   **NIM Restoration:** Recommended a **14.5% interest floor** for Prime Renters to flip a negative Net Risk Margin into profitability.

---

## II. Analytical Infrastructure & Governance
### **1. Cloud-Native Environment**
*   **Platform:** Google BigQuery (Simulating a multi-million row enterprise environment).
*   **Security:** Successfully architected a **Python-to-BigQuery bridge** using tokenized OAuth 2.0.
*   **Cost Control:** I have implemented a **50MB Safety Guardrail** and mandatory **Dry Run Audits** to ensure analytical cost-efficiency.

### **2. Data Triage & Hardening**
*   **The 9.56% Gap:** Identified schema auto-detect errors in interest rates and employment length.
*   **The Solution:** Built a **SQL Cleaning Layer (Silver View)** using `SAFE_CAST` and `COALESCE`. 
*   **Validation:** Conducted a **Data Integrity Stress Test** on 3,116 imputed records. Statistical parity in LTI (0.171) and Default Rates (20.67% vs. 21.94%) validates the imputation as a **non-biasing strategy**.

---

## III. Financial Risk Insights
### **1. The "Insolvency Frontier"**
The analysis reveals a **"Hard Wall"** for Renters at **0.40 LTI**. Beyond this point, default is a mathematical certainty (100% PD), making the segment un-priceable regardless of interest rates.

### **2. The Grade-LTI Override**
**Systemic Weakness:** I discovered that **Grade 'A' borrowers** with High-LTI ratios are **18x riskier** than Grade 'A' borrowers with low debt. This proves that credit history is secondary to current **Debt Capacity**.

---

## IV. Strategic Recommendations
### **1. Underwriting Policy Shift**
*   **Recommend implementing a Hard LTI Cap of 0.30 for Renters** to protect bank solvency.
*   **Mandate a "Hard Stop" Override:** Regardless of Credit Grade, any applicant with an **LTI > 0.40** must be auto-rejected.

### **2. Capital Provisioning (IFRS 9)**
*   **Action:** Increase **Expected Credit Loss (ECL) provisions** for the Tier 2 Renter segment immediately. The $90M exposure in this segment is the bank's single largest "Hidden Fire."

---

## V. Repository Structure & Reproducibility
The project is organized to follow the **Data Medallion Architecture**:
*   `scripts/sql/`: Pure logic for data hardening, segmentation, and provisioning.
*   `scripts/python/`: The automation engine, configuration, and cost-control gateway.
*   `notebook/`: The full analytical narrative and "Head-to-Tail" execution.

**To Reproduce Results:**
1. Configure `scripts/python/config.py` with your GCP Project ID.
2. Execute `notebook/Risk_Pipeline.ipynb` to deploy the **Governed View Layer** and generate the financial reports.
