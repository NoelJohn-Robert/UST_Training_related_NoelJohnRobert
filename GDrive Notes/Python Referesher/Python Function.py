# User Defined Functions (UDF)
# Declaration
def greetings():
    return "Hello, How are you doing today ?"

# Calling
print(greetings())

# Lambda Function - Anonymous Function - Single line function
multiplier = lambda x : x * 2
# Declare a Function with an Argument.
print(multiplier(20))

# Functional Programming Methods
list_3 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
# map()
list_4 = map(lambda x : x * x, list_3)
print(list_4)
# filter()
list_5 = filter(lambda x : x % 2 == 0, list_4)
print(list_5)
# reduce()
from functools import reduce
list_6 = reduce(lambda x , y: x + y, list_5)
print(list_6)


# Create a Function and apply it on reduce() method to return aggregate sales data.
sales = [{'product':'Laptop','amount':50000},
         {'product':'iPhone','amount':150000},
         {'product':'Smart TV','amount':75000},
         {'product':'Gaming Console','amount':35000},
         {'product':'Laptop','amount':90000},
         {'product':'iPhone','amount':70000}]

# Accumulate total sales revenue for each product.
def accumulate(accumulator, transaction):
    product = transaction["product"]
    amount = transaction["amount"]
    accumulator[product] += amount
    return accumulator

from functools import reduce
from collections import defaultdict
# reduce(function, iterable, initializer); Intializer - A starting value used 
# to intialize 
total_sales = reduce(accumulate, sales, defaultdict(int))

# Find Top Selling Product and Top-selling revenue.
top_selling_product = max(total_sales, key=total_sales.get)
top_selling_revenue = total_sales[top_selling_product]

# Output Results
print("Total sales revenue by product.")
for product, revenue in total_sales.items():
    print(f"{product}: ₹{revenue}")

print(f"Top Selling Product: {top_selling_product} with total revenue of ₹{top_selling_revenue}")

# defaultdict() - subset of dictionary - to avoid KeyError

# *args & **kwargs
def sum_a_list(*args):
    total_sum = sum(args)
    return total_sum

print(sum_a_list(1, 2, 4))
num_list = [2, 3, 5, 6, 7, 3]
print(sum_a_list(*num_list))

def employee_info(**kwargs):
    for key, value in kwargs.items():
        print(f"{key}: {value}")

employee_info(name = "Reshma", age = 19, city = 'trivandrum', job='data engineer')

reshma_details = {'name':'Reshma','age':19,'city':'Trivandrum','job':'Data Engineer'}
employee_info(**reshma_details)

