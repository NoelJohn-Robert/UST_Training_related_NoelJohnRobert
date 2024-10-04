#!/usr/bin/python3
"""reducer2.py"""
import sys

current_product = None
current_rating = 0.0
product = None
product_count = 0

records = []
# input comes from STDIN
for line in sys.stdin:
    line = line.strip()
    # parse the input we got from mapper.py
    # word & count are seperated by <tab> delimited
    product, rating = line.split(",")
    # this IF-switch only works because Hadoop sorts map output
    # by key (here key is word) before it is passed to the reducer
    try:
        rating = float(rating)
    except ValueError:
        continue
    if current_product == product:
        current_rating += rating
        product_count += 1
    else:
        if current_product:
            # write result to stdoutput seperated by tab
            records.append((current_product, current_rating/product_count))
        current_rating = rating
        current_product = product
        product_count = 1

# do not forget to output the last word if needed!
if current_product == product:
    records.append((current_product, current_rating/product_count))
records.sort(key = (lambda x:x[1]), reverse = True)
for product in records:
    print ('%s,%f' % (product[0], product[1]))
