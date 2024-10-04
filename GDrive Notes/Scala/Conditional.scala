object Conditional{
  def main(args:Array[String]): Unit = {
    // if-else Condition
    val x = 10
    if (x > 5) {
      println(s"$x is greater than 5")
    } else {
      println(s"$x is less than 5")
    }

    // if-else as an expression
    val y = 3
    val result = if (y % 2 == 0) "Even" else "Odd"
    println(result)

    // Ask user to input the Data
    import scala.io.StdIn._
    println("Please enter a value: ")
    
    // Read user input and convert to Integer
    val value = readInt()
    val result1 = if (value % 2 != 0) "Odd" else "Even"
    // print result
    println(result1)
    
  }
}