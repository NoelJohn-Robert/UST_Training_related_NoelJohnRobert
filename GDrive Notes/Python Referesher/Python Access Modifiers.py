# Public, Protected, Private access modifiers
# Protected Access Modifier
class Employee:
    _name = None
    _department = None 
    # Declare Constructor
    def __init__(self,name, department):
        self._name = name
        self._department = department
    # protected method
    def _display(self):
        print("Employee Name: ",self._name)
        print("Employee Name: ",self._department)
class EmpDetails(Employee):
    def __init__(self, name, department):
        Employee.__init__(self,name, department)
    def displayDetails(self):
        self._display()

protectObj = EmpDetails("Uday","IT")
protectObj.displayDetails()

# Private Access Modifiers
class PEmployee:
    __name = None
    __department = None 
    # Declare Constructor
    def __init__(self,name, department):
        self.__name = name
        self.__department = department
    # protected method
    def __display(self):
        print("Employee Name: ",self.__name)
        print("Employee Name: ",self.__department)
class PEmpDetails(PEmployee):
    def __init__(self, name, department):
        Employee.__init__(self,name, department)
    def displayDetails(self):
        self.__display()

privateObj = PEmpDetails("Rohit","IT")
# cannot access __display() from private object as it is not accessible.
privateObj.displayDetails()