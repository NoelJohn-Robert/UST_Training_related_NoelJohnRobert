object conditionStatements {
    def main(args:Array[String]): Unit = {
        // if condition
        val x = 10
        if (x > 5) {
            println(s"$x is greater than 5" )
        } else {
            println(s"$x is lesser than 5" )
        }

        // if else as an expression
        val y = 3
        val result = if (y%2==0) "Even" else "Odd"
        println(result)


        // input from user
        import scala.io.StdIn._
        print("please enter value: ")
        val value = readInt()
        val results = if (value%2==0) "Even" else "Odd"
        print(results)
        println()



        // Q: ask user to input a value and will return a grade
        print("please enter marks: ")
        val marks = readFloat()

        var grade = '0'
        if (marks>90) grade = 'S'
        else if (marks>80) grade = 'A'
        else if (marks>70) grade = 'B'
        else if (marks>60) grade ='C'
        else if (marks>50) grade = 'D'
        else if (marks>40) grade = 'E'
        else grade = 'F'
        println(s"Grade: $grade")

        val grade_expr = if (marks>90) 'S' else if (marks>80) 'A' else if (marks>70) 'B' else if (marks>60) 'C' else if (marks>50) 'D' else if (marks>40) 'E' else 'F'
        println(s"Grade: $grade_expr")
    }
}
