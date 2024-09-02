// primitive datatypes
object DataTypes {
  def main(args:Array[String]): Unit = {
    val intValue: Int = 25
    var doubleValue: Double = 42.1417365904
    var longIntrValue: Long = 192730387990L
    var myFloatValue: Float = 45.23


    var charValue: Char = 'd'
    var message: String = "HEllo Scala"

    var byteValue: Byte = 127

    val boolValue: Boolean = true


//    printing
    println("Integer value: " + intValue)
    println("Double datatype: " + doubleValue)
    println("String datatpye: " + message)
    println("Boolean Datatype: " + boolValue)

//    trying to reinitialize value
    charValue = 'A'
    print("New value of 'charValue': " + charValue)
    
//    intValue = 1      // reassignment not possible

  }
}