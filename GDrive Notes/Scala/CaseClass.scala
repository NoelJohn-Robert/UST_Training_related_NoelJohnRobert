// In scala programming Switch is referred as Match.
object CaseClass {
  def main(args: Array[String]): Unit = {
    def dayOfWeek(day: Int): String = day match {
      case 1 => "Monday"
      case 2 => "Tuesday"
      case 3 => "Wednesday"
      case 4 => "Thursday"
      case 5 => "Friday"
      case 6 => "Saturday"
      case 7 => "Sunday"
      case _ => "Invalid Day"
    }
    println(dayOfWeek(1))
    println(dayOfWeek(5))
    println(dayOfWeek(8))

    def StringMatch(Input: String): String = Input match {
      case "Vivek" => "Hello Vivek."
      case "Elias" => "Good Afternoon Elias."
      case "Vismaya" => "Hello Not Anu."
      case _ => "Hello Strangers"
    }
    println(StringMatch("Vivek"))
    println(StringMatch("Elias"))
    println(StringMatch("Vismaya"))
    println(StringMatch("Sarath"))
  }
}
