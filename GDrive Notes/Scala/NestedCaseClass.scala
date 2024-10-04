object NestedCaseClass{
  def main(args: Array[String]): Unit = {
    //    case class sides(x: Int, y:Int)
    //    case class Rectangle (TopLeft: sides, bottomRight: sides)
    
    // Define a case class for an Employee
    case class Employee(name: String, id:Int)
    // Define a case class for a Department, which contains a list of employee
    case class Department(deptname: String, employees: List[Employee])
    // Create an Instance of Employee
    val emp1 = Employee("Reshma", 123456)
    val emp2 = Employee("Maria", 654321)
    val emp3 = Employee("Vigneshwar", 987651)
    // Create Instance of Department
    val dept1 = Department("HR",List(emp1, emp2))
    val dept2 = Department("IT",List(emp3))
    
    // Pattern Matching with another case class
    dept1 match {
      case Department(deptname, employees) =>
        println(s"Department: $deptname")
        employees.foreach{
          case Employee(name, id) =>
            println(s"Employee: $name, Id: $id")
        }
    }
    // Pattern Matching with another case class
    dept2 match {
      case Department(deptname, employees) =>
        println(s"Department: $deptname")
        employees.foreach {
          case Employee(name, id) =>
            println(s"Employee: $name, Id: $id")
        }
    }
  }
}
