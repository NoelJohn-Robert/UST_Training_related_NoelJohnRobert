#!/usr/bin/python3
"""mapper9.py"""
import sys
# input comes from standard input
for line in sys.stdin:
    # remove leading and trailing whitespace
    line = line.strip()
    # If the line is not empty
    if line:
        columns = line.split(',')
        if columns:
            # Get Branch using Index=1 and GrossIncome using Index=15
            income = columns[15].strip()
            ratings = columns[-1].strip()
            print('%s,%s' % (income, ratings))
