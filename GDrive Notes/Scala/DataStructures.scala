object DataStructures{
    def main(args:Array[String]): Unit = {
      // In scala , a list is an immutable, heterogeneous ordered
      // sequence of elements. Lists are fundamental parts of scala programming.
      // Empty List Declaration
      val emptyList: List[Nothing] = List()

      val valList:List[String] = List("Apricot","Blueberry","Cherry","Donuts","Eclairs")
      print(valList)
      // collection.foreach(println) it takes print newline.
      valList.foreach(println)

      // Methods of List
      val firstValue = valList.head
      val restOfList = valList.tail
      val lastValue = valList.last
      val secondValue = valList(1)
      val length = valList.length

      // Print all values
      println("Display First Value: " + firstValue)
      println("Display Rest of Values: " + restOfList)
      println("Display Last Value: " + lastValue)
      println("Display Second Value: " + secondValue)
      println("Display Length of List: " + length)

      // valList = valList :+ "Fig" - Append in existing list throws error due to its immutability
      val newList = valList :+ "Fig"
      println("Is valList Empty ? " + valList.isEmpty)

      val newValList = List("Fig","Grapes","Hazelnut")
      // Concatenation of List
      val fruitBasket = valList ++ newValList

      // Transformation of List
      val list_1 = List(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
      println(list_1.map(_*3))
      val evenNum = list_1.filter(_%2 == 0)
      println("Even Numbers: " + evenNum)

      val nestedList = List(List("Delhi","Kochi","Bengaluru","Kolkata"),
                            List("Pune","Mumbai","Varkala","Delhi"),
                            List("Trivandrum","Kolkata","Visakhapatnam","Kottayam"))
      println(nestedList)
      // identity is predefined function `A=>A`
      println(nestedList.flatMap(identity))
      println(list_1.filter(_%2==0).reduce(_+_))
      println(nestedList.flatten)

      // Returns list of Characters Length from input List
      println(fruitBasket.map(_.length))
      // Returns boolean value if string starts with string "A"
      println(fruitBasket.map(_.startsWith("A")))
      // Sort the List by Word Length
      val sortedList = fruitBasket.sortWith(_.length < _.length)
      println(sortedList)
      val sortedCity = nestedList.flatten.sortBy(_.length)
      println(sortedCity)
      // List all city names starting with letter "K"
      println(nestedList.flatten.filter(_.startsWith("K")))
      // Alternative Method
      println(nestedList.flatten.filter(_.head == 'K'))

      // Subset and Slicing
      val city = nestedList.flatten
      println(city.take(5))
      println(city.takeRight(5))
      println(city.drop(1))
      println(city.dropRight(2))

      // slicing the lists using start index & last position
      println(city.slice(1,6))

      // slicing using random index position (0,2,4,5,7,9)
      val indices = List(0, 2, 4, 5, 7, 9)
      // lift(): It is method that retrieves an element at specified index.
      println(indices.flatMap(index => city.lift(index)))
      val population = List(31000000, 2100000, 12500000, 15000000, 7800000, 21000000, 55000, 2500000, 2300000, 200000)
      val pairedList = city.zip(population)
      println(pairedList)

      // Arrays: Mutable collection , indexed with sequence of elements.
      // Array provide fast access and modification of elements, making them
      // useful for performance critical applications.
      val emptyArray = Array[Int]()
      val Array1 = Array(1, 2, 3, 4, 5, 6)

      // Access individual value using index
      val firstElement = Array1(0)
      val secondElement = Array1(1)

      // Update the existing value
      Array1(0) = 10
      Array1.foreach(println)

      // Getting length of an Array
      println(Array1.length)

      // Adding or Removing values from an Array
      // Array1 += 7
      // Array1 -= 3
      import scala.collection.mutable.ArrayBuffer
      val arrayBuffer = ArrayBuffer(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
      arrayBuffer += 11
      arrayBuffer -= 1
      val newArray = arrayBuffer.toArray
      newArray.foreach(println)

      // Creating an Array Buffer Passing arrays as elements
      val Array2 = ArrayBuffer(Array1 : _*)
      Array2.foreach(println)

      // Apply mkString to Collections of Array, Lists, etc.
      println(Array2.mkString(", "))

      // Transformation of Arrays
      // Apply Map
      println(newArray.map(_+2).mkString(","))
      // Apply Filter(condition)
      println(newArray.filter(_>3).mkString(","))
      // Apply Flatten
      
      // Slicing and Substring
      println(newArray.take(5).mkString(","))
      println(newArray.takeRight(2).mkString(","))
      newArray.drop(1).foreach(println)
      println(newArray.dropRight(2).mkString(","))

      // slicing the lists using start index & last position
      println(newArray.slice(1, 6).mkString(","))
      
      // reverse the input array
      println(newArray.reverse.mkString(","))
      
      // Soring an Array
      val unsorted = Array(200, 100, 199, 99, 299, 499, 999)
      println(unsorted.sorted.mkString(","))
    }
}
