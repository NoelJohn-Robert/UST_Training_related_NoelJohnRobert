#!/usr/bin/python3
"""reducer6.py"""
import sys

current_day = None
current_total = 0.0

records = []
for line in sys.stdin:
    line = line.strip()
    day_of_week, total  = line.split(",")
    try:
        total = float(total)
    except ValueError:
        continue
    if current_day == day_of_week:
        current_total += total
    else:
        if current_day:
            records.append((current_day, current_total))
        current_total = total
        current_day = day_of_week

if current_day == day_of_week:
    records.append((current_day, current_total))
records.sort(key = (lambda x:x[1]), reverse = True)

for week_total in records:
    print ('%s,%s' % (week_total[0], week_total[1]))
