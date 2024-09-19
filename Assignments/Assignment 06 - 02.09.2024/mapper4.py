#!/usr/bin/python3
"""mapper4.py"""

import sys

for line in sys.stdin:
    line = line.strip()
    if line:
        columns = line.split(',')
        if columns:
            storage_issues_reported = columns[18].strip()
            product_wg_ton = columns[23].strip()
            print('%s,%s' % (storage_issues_reported, product_wg_ton))
