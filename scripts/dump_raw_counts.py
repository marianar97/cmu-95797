import duckdb

# Connect to DuckDB (replace 'your_database.duckdb' with your actual database file)
con = duckdb.connect('main.db')

# Query to get all table names
table_query = "SELECT table_name FROM information_schema.tables WHERE table_schema = 'main';"
tables = con.execute(table_query).fetchall()

# Iterate through each table and get the row count
for table in tables:
    table_name = table[0]
    count_query = f"SELECT COUNT(*) FROM {table_name};"
    row_count = con.execute(count_query).fetchone()[0]
    print(f"{table_name:<25} {row_count:,}")

# Close the connection
con.close()
