#!/usr/bin/python3
"""mapper3.py"""
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
            city = columns[2].strip()
            payment = columns[12].strip()
            # write the results to strdout(standard output)
            # tab-delimited; the trivial word count is 1
            # Output of Mapper Job is input to Reducer <--
            print('%s,%s,%s' % (city, payment, 1))
