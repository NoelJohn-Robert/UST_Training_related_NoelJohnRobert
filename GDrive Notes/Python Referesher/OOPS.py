var_1 = 10
# var_1 is an object of class integer
print(type(var_1))

# Declare a Class
class Person:
    def __init__(self, *args):
        if len(args) >= 4:
            self.name = args[0]
            self.age = args[1]
            self.dob = args[2]
            self.email = args[3]
        else:
            raise ValueError("Not enough arguments passed. Expected exactly 4.")
    def display(self):
        print("Person Details :")
        print(f"Name: {self.name}, age: {self.age}, DOB: {self.dob}, Email: {self.email}")

# Declare an Object
person_obj = Person("Arjun",21,'2001/03/31','arjun@example.com')
person_obj.display()

# Inheritance Example
# Single-Level Inheritance
# # Super Class or Parent Class 
class vehicle:
    def __init__(self, brand, model, mileage):
        self.brand = brand
        self.model = model
        self.mileage = mileage
# Subclass or Child Class for vehicle
class car(vehicle):
    def __init__(self, brand, model, mileage, speed, color):
        super().__init__(brand, model, mileage)
        self.speed = speed
        self.color = color
    def display(self):
        print(f"Vehicle Brand: {self.brand}, Model: {self.model}, Mileage: {self.mileage}")

objcar = car("Hyundai","Creta",15,120,"Black")
objcar.display()

# Multi-Level Inheritance
# Access Permissions
class Entity:
    def __init__(self, name):
        self.name = name

class User(Entity):
    def __init__(self,name,email):
        super().__init__(name)
        self.email = email

class admin(User):
    def __init__(self, name, email, permissions):
        super().__init__(name, email)
        self.permissions = permissions
    def display(self):
        return f"{self.name} has following permissions: {', '.join(self.permissions)}"
    
firstObj = admin("admin","admin@example.com",['read','write','execute'])
print(firstObj.display())

# Hierarchical Inheritance
class phone:
    def __init__(self, brand, model, color):
        self.brand = brand
        self.model = model
        self.color = color

class android(phone):
    def __init__(self,brand, model, color, os, osversion, processing):
        super().__init__(brand, model, color)
        self.os = os
        self.osversion = osversion
        self.processing = processing
    def androiddisplay(self):
        print("Android Phone Description: ")
        print(f"Brand: {self.brand}, Model: {self.model}, Color: {self.color}")
        print(f"OS: {self.os}, OSVersion: {self.osversion}, Processing: {self.processing}")

class iphone(phone):
    def __init__(self,brand, model, color, os, osversion, processing):
        super().__init__(brand, model, color)
        self.os = os
        self.osversion = osversion
        self.processing = processing
    def appledisplay(self):
        print("iPhone Description: ")
        print(f"Brand: {self.brand}, Model: {self.model}, Color: {self.color}")
        print(f"OS: {self.os}, OSVersion: {self.osversion}, Processing: {self.processing}")

# Multiple Inheritance
class Person:
    def __init__(self,name,age,city):
        self.name = name
        self.age = age
        self.city = city
    def personInfo(self):
        print(f"Employee Name: {self.name}, Age: {self.age}, City: {self.city}")
class Employee:
    def __init__(self, dept, position, salary):
        self.dept = dept
        self.position = position
        self.salary = salary
    def empinfo(self):
        print(f"Dept: {self.dept}, Position: {self.position}, Salary: {self.salary}")
class Manager(Person, Employee):
    def __init__(self,name,age,city,dept,position,salary,teamsize):
        Person.__init__(self,name,age,city)
        Employee.__init__(self,dept,position,salary)
        self.teamsize = teamsize
    def displayManager(self):
        print(f"Personal Info: {self.personInfo()}, Employee Info: {self.empinfo()}, Team Size: {self.teamsize}")

empobj = Manager("Maria",21,"Kochi","IT","Data Engineer",150000,15)
empobj.displayManager()

# Abstraction
# Import abstract class package
from abc import ABC, abstractmethod
class Bill(ABC):
    def print_slip(self,amount):
        print("Purchase Amount: ", amount)
    @abstractmethod
    def bill(self,amount):
        pass
class DebitCardPayment(Bill):
    # Method Overriding
    def bill(self,amount):
        print("Debit card payment of - ", amount)

absObj = DebitCardPayment()
absObj.print_slip(10000)
absObj.bill(10000)

