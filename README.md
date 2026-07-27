# Brazilian E-Commerce SQL Analysis(SQL Server)

## 📌 Project Overview

This project analyzes the Brazilian E-Commerce Public Dataset by Olist using SQL Server (T-SQL) and Excel-based visual analytics. The objective was to uncover meaningful business insights related to revenue growth, customer purchasing behavior, product category performance, operational delivery efficiency, and customer satisfaction.

The analysis focuses on solving real business questions rather than building dashboard-heavy visuals, making the project more aligned with practical business analytics and decision-making.

---

## 🛠 Tools Used

- SQL Server (T-SQL)
- SQL Server Management Studio (SSMS)
- Microsoft Excel
  
---

# 📊 Business Analysis Sections

---

## 🧾 1. Revenue & Customer Demand

### Business Questions
- What is total revenue and how has it grown month-over-month?
- Which months have peak sales and why?
- What is Average Order Value (AOV) over time?

### Key Findings
- Revenue increased significantly throughout 2017 and stabilized at higher levels during 2018.
- Peak sales in May and August were primarily driven by increased order volume rather than higher-value purchases.
- Health & Beauty and Bed Bath & Table emerged as the strongest demand-driving categories.
- Average Order Value remained relatively stable despite fluctuations in order volume.

---

## 🛍️ 2. Product & Category Intelligence

### Business Questions
- Which product categories generate the highest order volume?
- Which categories have high sales but low customer ratings?
- Which categories generate the highest Average Order Value (AOV)?

### Key Findings
- Furniture and home-related categories consistently showed strong sales activity.
- Office Furniture displayed relatively lower customer satisfaction despite meaningful order volume.
- Premium spending behavior was concentrated in categories such as Computers, Home Appliances, and Air Conditioning.
- The marketplace demonstrated both mass-market purchasing behavior and premium-category spending patterns.

---

## 🚚 3. Delivery & Customer Experience

### Business Questions
- What is the average delivery variance between actual and estimated delivery dates?
- Does delivery performance impact customer review scores?
- Which sellers show weaker delivery performance among high-volume sellers?

### Key Findings
- Orders were delivered approximately 11 days earlier than estimated on average.
- Higher customer ratings were strongly associated with earlier-than-expected deliveries.
- Even the weakest-performing high-volume sellers generally delivered orders ahead of schedule, indicating strong operational efficiency across the marketplace.
- Delivery performance showed a clear relationship with customer satisfaction.

---

## ⭐ 4. Customer Behavior

### Business Questions
- Are customers primarily repeat buyers or one-time purchasers?

### Key Findings
- The marketplace was heavily dependent on one-time buyers.
- Repeat customers represented only a small portion of the customer base.
- The analysis suggests strong customer acquisition activity but comparatively weaker customer retention behavior.

---

# 📈 Sample Visuals

## Revenue Trend
![Revenue Trend](Visuals/revenue_trend.png)

## Delivery Performance vs Customer Ratings
![Delivery vs Ratings](Visuals/delivery_vs_rating.png)

## Repeat vs One-Time Customers
![Customer Distribution](Visuals/customer_distribution.png)

---

# 🧠 Key Business Insights

- Revenue growth accelerated rapidly during 2017 before stabilizing in 2018.
- Sales spikes were largely volume-driven rather than driven by higher-value purchases.
- Product demand was concentrated in home, furniture, and beauty-related categories.
- Premium product categories generated higher Average Order Value (AOV) despite lower transaction volume.
- Faster delivery performance positively influenced customer review scores.
- The marketplace demonstrated strong operational delivery efficiency overall.
- Customer retention remains a potential growth opportunity for the business.

---

# 📂 Project Structure

```plaintext
Brazilian-Ecommerce-SQL-Analysis/
│
├── README.md
│
├── SQL Queries/
│   ├── 01_revenue_growth.sql
│   ├── 02_peak_sales_analysis.sql
│   ├── 03_aov_trend.sql
│   ├── 04_category_insights.sql
│   ├── 05_delivery_analysis.sql
│   └── 06_customer_behavior.sql
│
├── Visuals/
│   ├── revenue_trend.png
│   ├── peak_sales_distribution.png
│   ├── category_sales_spike.png
│   ├── aov_trend.png
│   ├── delivery_vs_rating.png
│   └── customer_distribution.png
│
└── Dataset/
    └── Kaggle
---

# 📌 Dataset Source

Brazilian E-Commerce Public Dataset by Olist (Kaggle)
