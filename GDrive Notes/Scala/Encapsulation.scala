class Employee(private var empname:String, private var salary:Int)
{
  // Set Method.
  def setName (newEmpName: String): Unit = {
    if(newEmpName.nonEmpty) empname = newEmpName
  }
  // Getter
  def getName: String = empname
  // Set Method
  def setSalary(newSal: Int): Unit = {
    if (newSal > 0) salary = newSal
  }
  // Getter
  def getSalary: Int = salary
}
object Encapsulation extends App {
  val emp1 = new Employee("Tom", 239990)
  emp1.setName("Jerry")
  emp1.setSalary(23999)
  println(emp1.getName)
  println(emp1.getSalary)
}