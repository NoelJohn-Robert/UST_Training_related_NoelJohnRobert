#!/usr/bin/python3
"""reducer9.py"""
import sys
import numpy as np

current_income = 0.0
current_rating = 0.0

gross_income = []
ratings = []
for line in sys.stdin:
    line = line.strip()
    income, rating = line.split(",")
    try:
        income = float(income)
        rating = float(rating)
    except ValueError:
        continue
    gross_income.append(income)
    ratings.append(rating)

gross_array = np.array(gross_income)
gross_ratings = np.array(ratings)
correlation = np.corrcoef(gross_array,gross_ratings)[0][1]
print(f"Correlation between Gross Income and Ratings: {correlation}")
