object NestedCaseClass {
    def main(args:Array[String]): Unit = {
        // defining a case class
        case class Employee(name:String, id:Int)

        // define case class for a department
        case class Department(name:String, employees:List[Employee])


        // create 
        val emp1 = Employee("Name1", 123456)
        val emp2 = Employee("Name2", 123455)
        val emp3 = Employee("Name3", 978007)

        val dept1 = Department("HR", List(emp1, emp2))
        val dept2 = Department("WB", List(emp3))



        dept1 match {
            case Department(deptname, employees) => println(s"Department: $deptname")
            employees.foreach {
                case Employee(name, id) => println(s"Name:$name, Id:$id")
            }
        }

        dept2 match {
            case Department(deptname, employees) => println(s"Department: $deptname")
                employees.foreach {
                    case Employee(name, id) => println(s"Name:$name, Id:$id")
                }
        }
    }





}



