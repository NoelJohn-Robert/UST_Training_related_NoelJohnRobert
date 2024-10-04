#!/usr/bin/python3
"""mapper8.py"""
import sys
from datetime import datetime

# input comes from standard input
for line in sys.stdin:
    # remove leading and trailing whitespace
    line = line.strip()
    # If the line is not empty
    if line:
        columns = line.split(',')
        # Ignore the header names
        if columns[10] != 'Date' and columns[5] != 'Product line' and columns[7] != 'Quantity':
            date = columns[10]
            product_line = columns[5].strip()
            quantity = columns[7].strip()
            day_of_week = datetime.strptime(date, "%m/%d/%Y").strftime("%Y-%U")
            print('%s,%s,%s' % (product_line, day_of_week, quantity))
