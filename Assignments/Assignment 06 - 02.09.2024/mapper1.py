#!/usr/bin/python3
"""mapper1.py"""

import sys

for line in sys.stdin:
    line = line.strip()
    if line:
        columns = line.split(',')
        if columns:
            zone = columns[4].strip()
            wh_regional_zone = columns[5].strip()
            product_wg_ton = columns[-1].strip()
            print('%s,%s,%s' % (zone, wh_regional_zone, product_wg_ton))
