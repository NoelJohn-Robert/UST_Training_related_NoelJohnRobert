str1 = 'This is Python String. We are Learning Python Programming'
# Reverse the string using index
print(str1[::-1])

str1 = str.lower(str1)
print('The start index position of Python in String: {} '.format(str1.find('python')))

list_1 = ["hello","how","are","you","doing","today."]

# join collection of word strings to join and create sentence.
sentence = " ".join(list_1)
print(sentence)
take_a_input = float(input("Enter a number: "))

# f = format
print(f"print a number {take_a_input}")

# Remove whitespaces from strings usage - user's input like email id , password etc.
stripped_text = sentence.lstrip()
print(stripped_text)

# partition the input sentence seperated by delimiter - (','," ",":","\t","\n",".")
print(sentence.rpartition(" "))

# list and its methods
list_2 = []
list_2 = list()

list_2 = ['Hello','Python','We','are','learning','Lists']
list_2.append('and')
# shallow copy - copy only the values
list_3 = list_2.copy()
# copy by reference - deep copy
list_4 = list_2

list_2.append('data structures')
print(list_3)
print(list_4)

list_2.extend(['tuples','sets','dictionary','all','are','data structures'])
print(list_2)

list_2.pop()
# Remove element from list using index.
list_2.pop(-2)
print(list_2)

# Tuples iterates faster compared to Lists. 
# List manages two memory where Tuples manages only one.

# Sets - Unordered Collection of Data. As it is unordered hence, no indexes are there.
sets_1 = set()

set_1 = {'A','B','C','D','E','E','H','A'}
set_2 = {'B','D','E','F','G','H','I','J'}
set_3 = {'H','I','J','K','L','M','N','O'}

set_1.add('Z')
print(set_1.difference(set_2))
print(set_2.difference(set_1))

print(set_1)
set_1.pop()
print(set_1)
# remove random value from sets
set_1.pop()
print(set_1)

# concatination of two sets without including duplicate values
set_1.union(set_2)
# updates the set_1 by dummy input set
set_1.update({'O','P','Q'})
# union of two sets containing elements present in either of two sets but not in both. 
print(set_1.symmetric_difference(set_2))

# common between both sets
set_1.intersection(set_2)

# Dictionary
dict_1 = {}    # Declare Empty Dictionary
# Method - I
dict_1 = {'A':'Apple','B':'BlueBerry','C':'Coconut','D':'Donuts','E':'Eclairs'}

city = ['kochi','trivandrum','kottayam','pala','vizag','thrissur']
emp_count = [20, 40, 10, 11, 12, 7]
# Method - II
dict_2 = dict.fromkeys(city, 20)
print(dict(zip(city, emp_count)))

# Method - III
dict_3 = dict([('kochi',20),('trivandrum',40),('kottayam',10),('pala',11)])
print(dict_3)

for key, value in dict_3.items():
    print(key, value)

for index, key in enumerate(dict_2):
    print(f"Index {index} : Key = {key}, Value = {dict_2[key]}")








