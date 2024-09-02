import scala.language.postfixOps

object scalaFunctions {
    def main(args: Array[String]): Unit = {
        import scala.io.StdIn._

//        // Q1: create a function which takes username as input and prints greeting
//        // function declaration
//        def greetings(name: String): Unit = {
//            println(s"Hello, $name!\nWelcome to UST")
//        }
//
//        print("Please input your username: ")
//        val username = readLine()
//        greetings(username)     // call a function, by passing parameter to it
//
//
//        // Q2: Create a basic function which takes more thank 1 parameter
//        val num1 = readInt()
//        val num2 = readInt()
//        def additionFn(num1:Int, num2:Int): Int = {
//            (num1+num2)
//        }
//        println("Sum = " + additionFn(num1, num2))
//        println()
//
//
//        // Q2, alternate
//        var num1_c1 = readLine("Enter first value: ").toInt
//        var num2_c1 = readLine("Enter second number: ").toInt
//
//        println("Sum = " + additionFn(num1_c1, num2_c1))
//
//
//        // Q3: calculator
//        def calculator(operand1: Int, operand2: Int, operator:Char): Int = {
//            if (operator == '+') { return operand1+operand2 }
//            else if (operator == '-') { return operand1-operand2 }
//            else if (operator == '*') { return operand1*operand2 }
//            else if (operator == '/') { return operand1/operand2 }
//            return 0
//        }
//
//        num1_c1 = readLine("Enter first value: ").toInt
//        num2_c1 = readLine("Enter second number: ").toInt
//        print("Enter operation[+,-,*,/]: ")
//        var option = readChar()
//        print(s"Result = $calculator(num1_c1, num2_c1, option)")



        // Q4: Declare a function with default value
//        def divide(a:Int, b:Int = 1): Any = {
//            return (a*1.0/b)
//        }
//        var div_inp_a = readLine("First num: ").toInt
//        var div_inp_b = readLine("Second nunmber: ").toInt
//        println(divide(div_inp_a))
//        println(divide(div_inp_a, div_inp_b))


//        // Q5: lambda/anonymous functions
//        val adding = (a:Int, b:Int) => a+b
////        print(adding(4, 6))
//
//        // Q6: Higher order function
//        // function is passed as parameter to function
//        def applyFunction(f:(Int,Int)=>Int, value1:Int, value2:Int): Int = {
//            f(value1, value2)
//        }
//        println(applyFunction(adding, div_inp_a, div_inp_b))


//        // Q7: Write a function that takes list as input and returns list without duplicate values
////        val myList = List(1, 4, 2, 6, 3, 5, 8, 9, 4, 7)
//        val myList = List("A", "B", "B", "D", "F", "A", "E", "A")
//
//        def removeDuplicatesFromList(myList: List[Any]): List[Any] = {
////            myList.toSet.toList
//            myList.distinct
//        }
//        print(removeDuplicatesFromList(myList))


//        // Q8: create a function that checks if input is palindrome or not
//        def checkIfPalindrome(inputStr:String): Boolean = {
//            inputStr.toLowerCase == inputStr.toLowerCase.reverse
//        }
//
//        val inputStr = readLine("Input a string: ")
//        print(s"Is $inputStr a Palindrome? : ${checkIfPalindrome(inputStr)}")


//        // Q9: Create a scala function that returns factorial of a number
//        def factorial(n: Int): Int = {
//            if (n==0 || n==1) return 1
//            else n*factorial(n-1)
//        }
//        val num = readLine("Input a number to find its factorial : ").toInt
//        println(s"Factorial of $num is ${factorial(num)}")
        
    }
}
