
object DataStructures {
    def main(args:Array[String]): Unit = {
//        collection of data types
        val valList = List("Apricot", "Banana", "Cherry", "Donuts", "Eclair")
        // val valList:List[String] = List("Apricot", "Blueberry", "Cherry", "Donuts", "Eclair")
        print(valList) // this won't give correct output

        valList.foreach(println) // this will print each values in a new line


        // empty list declaration
        val emptyList:List[Nothing] = List()


        val firstElement = valList.head
        val restExceptFirst = valList.tail
        val lastElement = valList.last
        val secondElement = valList(1)
        val length = valList.length

        // printing results
        println("First element of valList: " + firstElement)
        println("Second element of valList: " + secondElement)
        println("Last element of valList: " + lastElement)
        println("Elements other than first element of valList: " + restExceptFirst)
        println("Length of valList: " + length)



        // concatenating value to existing list
        val appendedList = valList :+ "Fig"
        println("Concatenated list: " + appendedList)

        val newValList = List("Grapes", "Hazelnut")
        // list concatenation
        val fruitBasket = valList ++ newValList
        print("Fruit basket: " + fruitBasket)

        // list transformation
        val list_1 = List(1, 2, 3, 4, 5, 6, 7, 8, 9)
        println("Map: " + list_1.map(_*2))
        println("Filter: " + list_1.filter(_%2 == 0))
        println("Sum of all nuumbers in list using reduce: " + list_1.filter(_%2==0).reduce(_+_))

        val nestedList = List(List("Delhi", "Kochi", "Bengaluru", "Kolkata"),
                              List("Pune", "Mumbai", "Varkala", "Delhi"),
                              List("Visakhapatnam", "Kolkata", "Kottayam", "Thiruvananthapuram"),
                              )
        println("Nested List: " + nestedList)
        print(nestedList.flatMap(identity))
        println(nestedList.flatten)

        // returns list of word's length form input list
        println(fruitBasket.map(_.length))

        // returns true|false for condition
        println(fruitBasket.map(_.startsWith("A")))


        // sort strings in List by word length
        val sortedList = fruitBasket.sortWith(_.length < _.length)
        println(sortedList)
        val sortedCity = nestedList.sortBy(_.length)
        println(sortedCity)


        // return list of city begins with K
        println("Qn: Cities starting with 'K':" + nestedList.flatten.filter(_.capitalize.startsWith("K")))


        val city = nestedList.flatten
        println(city)
        println(city.take(1))
        println(city.takeRight(1))
        println(city.drop(1))
        println(city.dropRight(1))

        // slicing using start and end index
        println(city.slice(1, 6))

        // slicing using random index positions (eg: 0, 2, 4, 5, 7, 9)
        val indices = List(0, 2, 4, 5, 7, 9)
        println(indices.flatMap(index=>city.lift(index)))


        val population = List(31870000, 609500, 12400000, 44867000, 3190000, 20411000, 51000, 1860000, 500000, 916000)

        val city_population_zippedList = city.zip(population)
        println(city_population_zippedList)



        // Arrays
        val emptyArray = Array[Int]()
        val array1 = Array(1, 2, 3, 4, 5 ,6)

        val arrFirstElement = array1(0)
        val arrSecondElement = array1(1)

        array1(0) = 10 // update values
        array1.foreach(println)

        // getting length of array
        println(array1.length)

        // adding or removing values from an array
        // below 2 lines are wrong, coz array is of fixed size - but there is alternative
//        array1 += 7
//        array1 -= 3
        import scala.collection.mutable.ArrayBuffer
        val arrayBuffer = ArrayBuffer(1,2,3,4,5,6,7,8,9)
        arrayBuffer += 11
        arrayBuffer -= 1
        val newArray = arrayBuffer.toArray
        newArray.foreach(print)
        println()
        // creating ArrayBuffer, passing array as elements
        val arrayBuffer2 = ArrayBuffer(array1:_*)
        // arrayBuffer2.toArray.foreach(print)
        println(arrayBuffer2.toArray.mkString(", "))


        // apply map
        val array1_modified = array1.map(_*2)
        println(array1_modified.mkString(", "))

        // apply filter
        val array2_modified = array1.filter(_%3 == 0)
        println(array2_modified.mkString(", "))

        // apply flatten
        val array2D = Array(
            Array("Delhi", "Kochi", "Bengaluru", "Kolkata"),
            Array("Pune", "Mumbai", "Varkala", "Delhi"),
            Array("Visakhapatnam", "Kolkata", "Kottayam", "Thiruvananthapuram"),
        )
        print(array2D.flatten.mkString(","))
        println()

        // slicing
        // same things as previous

        // reversing an array
        val testArray = Array(1, 3, 5, 7, 9)
        println("Orignal array: " + testArray.mkString(",") + "\nReversed array: " + testArray.reverse.mkString(","))
        
        
        // sorting also same as in Lists
    }
}