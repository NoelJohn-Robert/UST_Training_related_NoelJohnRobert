// switch case in scala
// in scala programming, swithc is referred to as match

object matchCase {
    def main(args: Array[String]): Unit = {
        def dayOFWeek(day: Int): String = day match {
            case 1 => "Monday"
            case 2 => "Tuesday"
            case 3 => "Wednesday"
            case 4 => "Thursday"
            case 5 => "Friday"
            case 6 => "Saturday"
            case 7 => "Sunday"
            case _ => "Invalid Day"
        }
        
        println(dayOFWeek(1))
        println(dayOFWeek(5))
        println(dayOFWeek(44))
        println()


        def stringMatch(input: String): String = input match {
            case "Vivek" => "Hello Vivek"
            case "Elias" => "Good Afternoon Elias"
            case "Vismaya" => "Hello Not Anu"
            case _ => "Hello Strangers"
        }
        println(stringMatch("Vivek"))
        println(stringMatch("Elias"))
        println(stringMatch("Vismaya"))
        println(stringMatch("Sarath"))
    }
    
    
    
    
    
}



