object DataTypes {
  def main(args: Array[String]): Unit = {
    // Primitive Data Types
    // Numeric Types
    // Immutable Datatype
    val intValue: Int = 25
    var doubleValue: Double = 23.87654345
    var longVal: Long = 423445645124L
    var floatValue: Float = 45.23F

    // Character and String Type
    var charValue: Char = 'A'
    var message: String = "Hello Scala"

    // Byte
    var byteValue: Byte = 127

    // Mutable DataType
    // Boolean
    val booleanValue: Boolean = true
    val booleanValue1: Boolean = false

    println("Integer Value: " + intValue)
    println("Double Datatype: " + doubleValue)
    println("String Datatype: " + message)
    println("Boolean Datatype: " + booleanValue)

    // Re initialize value
    charValue = 'B'
    // intValue = 101   // Cannot be reassigned to intValue.
    println("Char New Value: " + charValue)
  }
}

