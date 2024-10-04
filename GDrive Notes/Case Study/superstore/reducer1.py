#!/usr/bin/python3
"""reducer1.py"""
import sys

current_branch = None
current_income = 0.0
branch = None

records = []
# input comes from STDIN
for line in sys.stdin:
    line = line.strip()
    # parse the input we got from mapper.py
    # word & count are seperated by <tab> delimited
    branch, income = line.split(",")
    # convert count (currently a string) to integer data
    try:
        income = float(income)
    except ValueError:
        # count was not a number, so silently
        # ignore/discard this line
        continue
    # this IF-switch only works because Hadoop sorts map output
    # by key (here key is word) before it is passed to the reducer
    if current_branch == branch:
        current_income += income
    else:
        if current_branch:
            # write result to stdoutput seperated by tab
            records.append((current_branch, current_income))
	# making current_word = word
        current_income = income
        current_branch = branch

# do not forget to output the last word if needed!
if current_branch == branch:
    records.append((current_branch, current_income))
records.sort(key = (lambda x:x[1]), reverse = True)

for branch in records:
    print ('%s,%s' % (branch[0], branch[1]))
