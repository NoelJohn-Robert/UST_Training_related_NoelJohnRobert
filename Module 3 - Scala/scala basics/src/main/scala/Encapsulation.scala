

class Employee(private var empname: String, private var salary: Int) {
    // set employee's name
    def setEmployeeName(newEmpName: String): Unit = {
        if (newEmpName.nonEmpty)
            empname = newEmpName
    }

    def getName: String = empname

    // set salary
    def setSalary(newSalary: Int): Unit = {
        if (newSalary > 0)
            salary = newSalary
    }

    def setSalary: Int = salary

    def displayDetails(): Unit = {
        print(s"Name:$empname Salary$salary")
    }
}

object Encapsulation extends App {
    val emp1 = Employee("Name1", 100)
    emp1.setEmployeeName("NewName1")
    emp1.setSalary(123456)
    // emp1.displayDetails()
    println(emp1.getName)
}

