#!/usr/bin/python3
"""reducer4.py"""

import sys
import numpy as np

data_dict = {}
count_dict = {}
for line in sys.stdin:
    line = line.strip()
    storage_issues_reported, product_wg_ton = line.split(',', 1)

    try:
        storage_issues_reported = int(storage_issues_reported)
        product_wg_ton = float(product_wg_ton)
    except ValueError:
        continue

    if storage_issues_reported in data_dict:
        data_dict[storage_issues_reported] += [product_wg_ton]
        count_dict[storage_issues_reported] += 1
    else:
        data_dict[storage_issues_reported] = [product_wg_ton]
        count_dict[storage_issues_reported] = 1

#for key in data_dict.keys():
#    data_dict[key] = round(data_dict[key]/count_dict[key], 3)
#
#for key, value in data_dict.items():
#    print("%s,%s" % (key, value))
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
    print(f"Storage Issues: {key}, Total: {total}, Max: {max_value:.3f}, Min: {min_value:.3f}, Average: {average:.3f}, Count: {count}, Std Dev: {std_dev:.3f}, Variance: {variance:.3f}")

