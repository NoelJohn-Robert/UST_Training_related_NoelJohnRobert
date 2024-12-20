#!/usr/bin/python3
"""mapper.py"""
import sys
# input comes from standard input
for line in sys.stdin:
    # remove leading and trailing whitespace
    line = line.strip()
    # If the line is not empty
    if line:
        columns = line.split(',')
        if columns:
            country = columns[-1].strip()
            # write the results to strdout(standard output)
            # tab-delimited; the trivial word count is 1
            # Output of Mapper Job is input to Reducer <--
            print('%s,%s' % (country, 1))
