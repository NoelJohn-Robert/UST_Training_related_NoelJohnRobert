object Functions{
  def main(args:Array[String]): Unit = {
//    // Function: Function is block of code which must do a certain task.
//
//    // 1. Create function which takes username as Input and print greetings
//    // Declare a Function - UDF (User Defined Function)
      import scala.io.StdIn.readLine
//    // Function takes one parameter
//    def greetings(name : String): Unit = {
//      println(s"Hello, $name Welcome to UST.")
//    }
//    println("Please enter your username: ")
//    val username = readLine()
//    // Call a function with user's input
//    greetings(username)
//
//    // 2. Create a Basic Function which takes more than one parameter
      import scala.io.StdIn.readInt
//    var a = readInt()
//    var b = readInt()
//    // Declare a function
//    def add(a: Int, b:Int): Int = {
//       a + b
//    }
//    // Call a function
//    println(add(a,b))
//
//    // Alternative: Using readLine()
      var p = readLine("Enter first value: ").toInt
      var q = readLine("Enter second value: ").toInt
//    // Declare a function
//    def addition(a: Int, b: Int): Int = {
//      a + b
//    }
//    // Call a function
//    println(add(p, q))
//
//    // 3. Create a Scala Function Calculator.
//    def calculator(a:Int, b:Int, op:String): Any = {
//      if (op == "+"){
//        return a + b
//      }
//      if (op == "-") {
//        return a - b
//      }
//      if (op == "*") {
//        return a * b
//      }
//      if (op == "/") {
//        return a / b
//      }
//    }
//    p = readLine("Enter first value: ").toInt
//    q = readLine("Enter second value: ").toInt
//    var op = readLine("Enter Operation: ")
//    println(calculator(p, q, op))

    // 4. Declare a function with default value
    def divide(a:Int, b:Int = 1): Any = {
      return a / b
    }
    p = readLine("Enter first value: ").toInt
    q = readLine("Enter second value: ").toInt
    println(divide(p))
    print(divide(p,q))

    // 5. Lambda Function or Anonymous Function
    val add = (a:Int, b:Int) => a + b
    println(add(p,q))

    // 6. Higher-Order Function: A Higher Order Function is Function
    // that takes another function as a parameter.
    def applyFunction(f: (Int,Int) => Int, value1: Int, value2: Int): Int = {
      f(value1, value2)
    }
    applyFunction(add, p, q)

    // 7. Create a Function that takes List as Input and returns List
    // without Duplicate Values.
    def duplicate(lst:List[Int]): List[Int] = {
      lst.distinct
    }
    // Example Usage
    val num = List(1,2,2,3,4,5,5,7,9,9)
    println(duplicate(num))

    // 8. Write a Function that test if user input is Palindrome
    // e.g. malayalam, racecar, mom
    def isPalindrome(s:String) : Boolean = {
      return s == s.reverse
    }
    println(isPalindrome("malayalam"))

    // 9. Create a Scala Function which returns factorial of a Number.
    def factorial(n: Int): Int = {
      if (n == 0) 1
      else n * factorial(n - 1)
    }
    // Example Usage
    val number = readLine("Enter number of factorial values: ").toInt
    println(factorial(number))
    
  }
}
