# Olist E-Commerce SQL Analysis

SQL analysis of ~100k orders from a Brazilian online marketplace (2017-2018), answering 10 business questions about revenue, customers, delivery, and sellers.

**Tools:** SQL (SQLite), Python, pandas, Matplotlib, Jupyter

## Data

[Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) on Kaggle. The data is not included in this repo. To reproduce:

1. Download the dataset from the link above and put the CSV files in a `data/` folder.
2. Install dependencies and build the database:

```
pip install -r requirements.txt
python load_data.py
```

## Key findings

- **Revenue grew strongly** from 2017 to mid-2018. February 2017 shows the highest growth rate, but only because January was a very small base.
- **Busiest is not most valuable:** `bed_bath_table` has the most orders, but `health_beauty` earns the most revenue.
- **Retention is the weak spot:** only about 2.2% of customers (2,081 of 93,358) ordered more than once.
- **Slow delivery hurts reviews:** average review score falls from 4.42 (up to 7 days) to 4.31, 4.14, and 3.12 for orders taking over 21 days.
- **Late deliveries concentrate in the northeast:** Alagoas (AL), Maranhão (MA), and Piauí (PI) have the highest late-delivery rates.
- **Payments:** credit cards make up 78.3% of payment value and boleto (bank slip) 17.9%.
- **Sellers are not concentrated:** the top seller is based in São Paulo (SP), and the top 10 sellers together account for about 12% of revenue.
- **Lowest-rated categories:** office furniture, fashion male clothing, and audio.

## Recommendations

1. **Invest in retention.** With ~2% repeat customers, loyalty offers or follow-up emails could add revenue without new acquisition costs.
2. **Fix delivery in the northeast.** Late deliveries drive low reviews, so closer fulfillment or more realistic delivery estimates for AL, MA, and PI would help.
3. **Keep boleto and review the weakest categories.** Nearly a fifth of payment value comes from boleto, and low-rated categories like office furniture may need better packaging or product descriptions.

## Queries

| File | Question |
|---|---|
| `01_monthly_revenue.sql` | Monthly revenue |
| `02_revenue_growth.sql` | Month-over-month growth (`LAG`) |
| `03_top_categories.sql` | Top categories by revenue |
| `04_customer_retention.sql` | Share of repeat customers |
| `05_delivery_vs_reviews.sql` | Delivery time vs. review score |
| `06_late_deliveries_by_state.sql` | Late-delivery rate by state |
| `07_payment_methods.sql` | Payment method split |
| `08_top_sellers.sql` | Top sellers (`RANK`) |
| `09_lowest_rated_categories.sql` | Lowest-rated categories |
| `10_cumulative_revenue.sql` | Running revenue total |

Charts and exploration are in `notebooks/analysis.ipynb`.

## Notes and limitations

- Revenue uses item prices of delivered orders only. Shipping is excluded.
- The first and last months of the dataset are partial, so growth figures use January 2017 to August 2018.
- Groups with fewer than 100 orders are excluded from rankings and rates.
- Reviews are averaged per order, and customers are counted by `customer_unique_id`, since `customer_id` changes with every order.
- Findings show associations, not causes. For example, slow delivery goes with worse reviews, but other factors may also contribute.

## Repo structure

```
queries/      10 SQL files
notebooks/    analysis.ipynb (charts)
load_data.py  loads the CSVs into SQLite
requirements.txt
```