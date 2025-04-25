# Project: ## Credit Risk Profiling: Unlocking Loan Default Patterns

## 🛠️ Technologies Used
	• 	Python: Pandas, NumPy, Matplotlib, Seaborn, Scikit-learn
	• 	SQL: MySQL Workbench
	• 	Power BI: Report development, DAX, KPI visuals
 	• 	Excel
      
 

⸻

## 🎯 Objective

To analyze patterns leading to loan defaults and prepare the dataset for machine learning modeling, with a focus on clean reporting and stakeholder insights using Python, SQL, and Power BI.

⸻

## 📁 Dataset Description
	•	Source: Open Loan Default Dataset (publicly available)
	•	Size: ~10,000 records
	•	Features: 20+ (including LoanAmount, CreditScore, EducationType, EmploymentType, LoanStatus, etc.)

⸻

## 🔄 Data Preprocessing Workflow

### ✅ Step 1: Data Cleaning
	•	Removed nulls and duplicates from key columns like CreditScore, LoanAmount, and LoanStatus.
	•	Dropped the non-informative LoanID column.
	•	Standardized all column names to lowercase with snake_case for consistency.

### ✅ Step 2: Data Type Fixing
	•	Converted object types to categorical (e.g., EmploymentType, EducationType).
	•	Transformed Yes/No columns into binary integers (0/1).

### ✅ Step 3: Exploratory Data Analysis (SQL + Python)
	•	Ran 15+ custom SQL queries to explore borrower behavior by credit tier, loan amount, and status.
	•	Key findings:
	•	‘Poor’ credit score borrowers defaulted at 3.2× higher rates.
	•	Unemployed applicants showed a 2.5× higher default risk.
	•	Secondary education holders had an 18% higher default rate compared to graduates.

### ✅ Step 4: Encoding Categorical Features
	•	Applied:
	•	Label Encoding for binary and ordinal categories (e.g., LoanStatus, Gender)
	•	One-Hot Encoding for nominal multi-class fields (EmploymentType, EducationType, PropertyType)
	•	Ensured encoding was done before scaling and aligned with model requirements.

### ✅ Step 5: Power BI Visualization
	•	Developed a 5-page interactive Power BI dashboard with filters, KPIs, and slicers.
	•	Created visuals to monitor:
	•	Default rates by Credit Score Group and Loan Term
	•	Revenue impact from defaults
	•	Distribution of borrowers by Education and Employment

### ✅ Step 6: Min-Max Standardization
	•	Scaled key numerical features to 0–1 using MinMaxScaler:
	•	LoanAmount, CreditScore, AnnualIncome, Age
	•	Ensured compatibility with ML algorithms that are sensitive to scale (e.g., KNN, Logistic Regression).
