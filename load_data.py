import sqlite3
from pathlib import Path
import pandas as pd

DATA_DIR = Path("data")
DB_PATH = Path("olist.db")

conn = sqlite3.connect(DB_PATH)
for csv_file in sorted(DATA_DIR.glob("*.csv")):
	table = csv_file.stem.replace("olist_", "").replace("_dataset", "")
	df = pd.read_csv(csv_file)
	df.to_sql(table, conn, if_exists="replace", index=False)
	print(f"{table}: {len(df):,} rows")
conn.close()
