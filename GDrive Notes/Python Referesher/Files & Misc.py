# Use Datetime Package.
import datetime

print("Display Today's Date: ", datetime.date.today())
print(datetime.datetime.now())

today = datetime.date.today()
print("Day:", today.day, "Month: ",today.month, "Year: ",today.year)

# Usage of Datetime in Example
class Person:
    def __init__(self,name,surname,birthdate,adress,contact,email):
        self.name = name
        self.surname = surname
        self.birthdate = birthdate
        self.address = adress
        self.contact = contact
        self.email = email
    def age(self):
        today = datetime.date.today()
        age = today.year - self.birthdate.year
        if today < datetime.date(today.year, self.birthdate.month, self.birthdate.day):
            age -= 1
        if age < 0:
            print("Person is not Born.")
        return age 
    
person = Person("Elias","xyz",datetime.date(2001,9,4),"UST, Trivandrum, Kerala",
                "9876543210","elias@example.com")
print(person.age())

# File Handling
# Open the file in default mode - read mode.
fileobj = open('newfile.txt')
print(fileobj.read())

fileobj = open('newfile.txt', 'r')
# w - Create file & then Open file in write mode 
fileobj = open('newtextfile.txt', 'w')
# Do write the input content in an empty file.
fileobj.write("This is new content added to the new file.")
fileobj.close()

# 'r+' - open file in read & write mode
fileobj1 = open('newtextfile.txt', 'r+')
print(fileobj1.read())
print("Read Again")

# seek(0) - Position the file cursor at first position.
fileobj1.seek(0)
print(fileobj1.read())

fileobj1.write("\nThis is another content appended in the EOF.")
fileobj1.seek(0)
print(fileobj1.read())

# 'w+' - open file in write and then read mode
fileobj2 = open('filename.txt', 'w+')
print(fileobj2.read())
fileobj2.write("Write the content in the newfile.")
fileobj2.seek(0)
print(fileobj2.read())
fileobj2.close()

# Usage of with in file 
with open('newtextfile.txt', 'r+') as fileobj:
    data = fileobj.readlines()
    for line in data:
        word = line.split()
        print(word)
        

# List Comprehension with Lambda Function.
grade = lambda marks: ('A' if marks >= 90 else 'B' if marks >= 80 else 'C' 
if marks >= 70 else 'D' if marks >= 60 else 'E' if marks >= 50 else 'F')
marks_list = [33, 44, 55, 66, 77, 88, 99]
grade = [grade(marks) for marks in marks_list]
print(grade)





