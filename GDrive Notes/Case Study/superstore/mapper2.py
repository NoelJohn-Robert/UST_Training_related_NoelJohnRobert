#!/usr/bin/python3
"""mapper2.py"""
import sys
# input comes from standard input
for line in sys.stdin:
    # remove leading and trailing whitespace
    line = line.strip()
    # If the line is not empty
    if line:
        columns = line.split(',')
        if columns:
            try:
                # Get Branch using Index=1 and GrossIncome using Index=15
                product = columns[5].strip()
                ratings = float(columns[-1].strip())
            except:
                continue
            print(f"{product},{ratings}")
