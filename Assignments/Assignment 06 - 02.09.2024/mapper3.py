#!/usr/bin/python3
"""mapper3.py"""

import sys

for line in sys.stdin:
    line = line.strip()
    if line:
        columns = line.split(',')
        if columns:
            transport_issue_l1y = columns[7].strip()
            product_wg_ton = columns[23].strip()
            print('%s,%s' % (transport_issue_l1y, product_wg_ton))
