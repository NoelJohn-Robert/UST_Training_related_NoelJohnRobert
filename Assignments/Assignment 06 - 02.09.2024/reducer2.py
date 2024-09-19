#!/usr/bin/python3
"""reducer2.py"""

import sys
import numpy as np

data_dict = {}
count_dict = {}
for line in sys.stdin:
    line = line.strip()
    wh_capacity_size, num_refill_req = line.split(',', 1)

    try:
        num_refill_req = int(num_refill_req)
    except ValueError:
        continue

    wh_capacity_value = 1 if wh_capacity_size=='Small' else 2 if wh_capacity_size=='Mid' else 3 if wh_capacity_size=='Large' else 4
#    wh_capacity_value_list.append(wh_capacity_value)
#    num_refill_req_list.append(num_refill_req)
    if wh_capacity_value in data_dict:
        data_dict[wh_capacity_value] += num_refill_req
        count_dict[wh_capacity_value] += 1
    else:
        data_dict[wh_capacity_value] = num_refill_req
        count_dict[wh_capacity_value] = 1


for key in data_dict.keys():
    data_dict[key] = data_dict[key]/count_dict[key]

wh_capacity_value_list = []
num_refill_req_list = []

correlation_value = np.corrcoef(list(data_dict.keys()), list(data_dict.values()))[0,1]
print(f"Correelation between warehouse capacity and number of refills is: {round(correlation_value, 5)}")
