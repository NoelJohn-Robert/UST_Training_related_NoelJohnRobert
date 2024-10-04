#!/usr/bin/python3
"""mapper6.py"""
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
        if columns[10] != 'Date' and columns[9] != 'Total':
            # Get Branch using Index=1 and GrossIncome using Index=15
            date = columns[10].strip()
            total = columns[9].strip()
            day_of_week = datetime.strptime(date, "%m/%d/%Y").strftime("%A")
            print('%s,%s' % (day_of_week, total))
