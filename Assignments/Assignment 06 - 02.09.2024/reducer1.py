#!/usr/bin/python3
"""reducer1.py"""

import sys

data_dict = {}
#count_dict = {}
for line in sys.stdin:
    line = line.strip()
    zone, WH_regional_zone, product_wg_ton = line.split(',', 2)

    try:
        product_wg_ton = float(product_wg_ton)
    except ValueError:
        continue

    key = (zone, WH_regional_zone)
    if key in data_dict:
        data_dict[key] += product_wg_ton
#        count_dict[key] += 1
    else:
        data_dict[key] = product_wg_ton
#        count_dict[key] = 1

#for key in data_dict.keys():
#    data_dict[key] = data_dict[key]/count_dict[key]

for key, value in data_dict.items():
    print(f'Zone: {key[0]}, RegionalZone: {key[1]}, TotalSupply: {value}')
#    print("%s,%s" % (key, value))
