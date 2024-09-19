#!/usr/bin/python3
"""reducer3.py"""

import sys
import numpy as np

data_dict = {}
##count_dict = {}
for line in sys.stdin:
    line = line.strip()
    transport_issues, product_wg_ton = line.split(',', 1)

    try:
        transport_issues = int(transport_issues)
        product_wg_ton = float(product_wg_ton)
    except ValueError:
        continue

    if transport_issues in data_dict:
        data_dict[transport_issues] += [product_wg_ton]
##        count_dict[transport_issues] += 1
    else:
        data_dict[transport_issues] = [product_wg_ton]
##        count_dict[transport_issues] = 1

#for key in data_dict.keys():
#    data_dict[key] = round(data_dict[key]/count_dict[key], 3)

data_dict = sorted(data_dict.items(), key=lambda x:x[0])
for (key, value) in data_dict:
    value = np.array(value)
    total = np.sum(value)
    max_value = np.max(value)
    min_value = np.min(value)
    average = np.mean(value)
    count = len(value)
    std_dev = np.std(value)
    variance = np.var(value)
    print(f"Storage Issues: {key}, Total: {total}, Max: {max_value:.3f}, Min: {min_value:.3f}, Average: {average:.3f}, Count: {count}, Std Dev: {std_dev:.3f}, Variance: {variance:.3f}\n")


