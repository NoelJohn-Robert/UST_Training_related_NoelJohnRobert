# Condition Controlled Loop
condition = 0
while condition <= 12:
    print(2 * condition)
    condition += 1

# Count Controlled Loop
for num in range(10, 21):
    print(num)

# Collection controlled Loop
list_1 = [10, 20, 30, 40, 50, 60, 70, 80, 90]
for value in list_1:
    print(value)

import keyword
print(keyword.kwlist)

print(len(keyword.kwlist))

print(type(list_1))

# Delete a Python Object
del(list_1)

statement = "Break Time"
list_val = []
for alpha in statement:
    list_val.append(alpha)
print(list_val)

# conditional statements
bro_age = int(input("Enter Brother's Age:"))
sister_age = int(input("Enter Sister's Age:"))

if bro_age > sister_age:
    print("Brother is elder.")
elif bro_age < sister_age:
    print("Sister is elder.")
else:
    print("Both are twins.")

# Create login access using loop and condition statements.
while True:
    choice = input("Choose an Option: ")
    if choice == 'login':
        user = input("Username: ")
        password = input("Password: ")
        if user == 'admin' and password == 'pass@word':
            print("Login Successful. Welcome.")
        else:
            print("Incorrect Username or Password.")
    elif choice == 'quit':
        print("Exiting from the Program. GoodBye.")
        break
    else:
        print("Invalid Choice.Choose option as 'login' or 'quit'.")

# Break and Continue
list_a = ['kochi','trivandrum',None,'kottayam',None, None,'pala','vizag','thrissur']

for city in list_a:
    if city == None:
        continue
    else:
        print(list_a)

