# Enterprise Credit Risk Scoring Engine

**FinTech | Risk Modeling | Financial Analytics**

A comprehensive credit risk assessment platform that utilizes multi-factor SQL scoring engines to classify loan applications and predict default probabilities.

---

## ⚡ Executive Summary
- **Business Challenge:** High default rates in the personal loan portfolio were eroding margins, and manual underwriting was too slow to handle volume.
- **Solution:** Engineered an automated **SQL Scoring Engine** that weights Debt-to-Income (DTI), employment stability, and income coverage to provide real-time risk tiering.
- **Impact:** Enabled a "Fast-Track" approval process for 60% of applications, reducing manual underwriting hours by **50%** while maintaining a sub-5% default rate in the Prime tier.

---

## 🏗️ Analytics Architecture

### 1. Risk Tiering Engine (SQL)
*   **The Model:** Weighted multi-factor algorithm implemented in `sql/scoring_engine.sql`.
*   **KPIs:** DTI Ratios, Loan-to-Income (LTI), and Employment Tenure milestones.
*   **Automation:** Classification into Tier 1 (Prime), Tier 2, and Tier 3 (Auto-Reject).

### 2. BI Dashboard (Power BI)
*   **Portfolio Health:** Real-time monitoring of "Good" vs "Bad" loan distributions.
*   **Geographic Risk:** Identifying high-default zip codes for localized policy adjustments.
*   **Revenue Impact:** Analyzing interest earned vs. write-offs by risk tier.

---

## 💻 Tech Stack
- **Database:** SQL Server / PostgreSQL
- **Analytics:** Advanced SQL (CTEs, Window Functions)
- **BI Tool:** Power BI (DAX modeling)

---

## 📂 Repository Structure
```
├── sql/
│   └── scoring_engine.sql    # Core Risk Weighting Logic
├── data/                     # Sanitized Loan Datasets
├── powerBI/                  # .pbix report files
└── README.md
```

---
*"Standardizing financial risk through automated intelligence."*