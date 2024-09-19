#!/usr/bin/python3
"""mapper2.py"""

import sys

for line in sys.stdin:
    line = line.strip()
    if line:
        columns = line.split(',')
        if columns:
            wh_capacity_size = columns[3].strip()
            num_refill_req_l3m = columns[6].strip()
            print('%s,%s' % (wh_capacity_size, num_refill_req_l3m))
