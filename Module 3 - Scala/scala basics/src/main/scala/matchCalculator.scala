// calculator program

object matchCalculator {
    def main(args: Array[String]): Unit = {
        def calculate(num1:Int, num2:Int, operator:String): Any = operator match {
            case "+" => num1 + num2
            case "-" => num1 - num2
            case "*" => num1 * num2
            case "/" => if num2!=0 then (num1 / num2).toFloat else "NaN"
            case "%" => (num1%num2)
            case "^" => Math.pow(num1, num2)
            case "//" => if num2!=0 then (num1 / num2) else "NaN"
            case _ => "Error"
        }

        println(calculate(1, 3, "+"))
        println(calculate(5, 3, "*"))
        println(calculate(5, 0, "/"))
        println(calculate(5, 2, "^"))
        println(calculate(5, 2, "//"))
        println()
    }
    
    
}

