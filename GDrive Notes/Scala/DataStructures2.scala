object DataStructures2{
  def main(args:Array[String]): Unit = {
    // Scala Collection - Map 
    // Map: Collection of key-value pairs. Map can be either mutable
    // or immutable. By default, Map is Immutable.
    val fruitBasket = Map("Apricot" -> 20,"Blueberry" -> 250,
      "Cherry" -> 100, "Donuts" -> 24,"Eclairs" ->100)
    // Mutable Maps
    import scala.collection.mutable
    val mutableMap = mutable.Map("Apricot" -> 20,"Blueberry" -> 250,
      "Cherry" -> 100, "Donuts" -> 24,"Eclairs" ->100)
    
    // Basic Operations
    val value = fruitBasket("Donuts")
    println(fruitBasket.contains("Donuts"))
    val mapSize = fruitBasket.size
    println(mapSize)
    val keys = mutableMap.keys
    val values = mutableMap.values
    
    // Adding and Removing in Map
    mutableMap += ("Fig" -> 24 )
    mutableMap -= ("Eclairs")
    // Apply same on Immutable
    val newfruitBasket = fruitBasket + ("Fig" -> 24 )
    
    // Update the Value in Key "Fig"
    mutableMap("Fig") = 30

    val set1 = Set(1, 2, 3, 4, 5, 6, 7, 8)
    val set2 = Set("Apple", "Banana", "Cheery", "Grapes", "Tomato",
      "Oranges", "Watermelon", "Pineapple")

    // Basic Operations
    println(set1.contains(5))
    println(set1.size)
    println(set1 + 9)

    // Union of sets
    val set3 = Set("Grapes", "Tomato", "Guava", "Oranges", "Banana")
    val fruitBasket1 = set2 union set3
    println(fruitBasket1)

    // Intersect : Common value between Two Sets.
    val interSet = set2 intersect set3

    // Difference
    val diffSet = set2 diff set3
    println(diffSet)

    val diffSet1 = set3 diff set2
    println(diffSet1)

    // subset check
    val isSubset = set2.subsetOf(set3)
    println(isSubset)

    // Transformation - map, filter, reduce
    println(set3.map(_.toLowerCase()).mkString(","))
    println(set1.map(_ * 2).mkString(","))
    println(set3.filter(_.startsWith("G")).mkString(","))

    // mutable Sets
    val set4 = mutable.Set(10, 20, 30, 40, 50, 60, 70)
    set4 += 10
    set4 ++= Set(80, 90)
    set4 --= Set(10, 20)

    // clear Sets
    set4.clear()

    // create a new collection
    val fruitList = List("apple", "apricot", "banana", "chocolate", "coconut")
    val mapFruits = fruitList.groupBy(_.head)
    val newMapFruits: mutable.Map[Char, List[String]] = mutable.Map(mapFruits.toSeq: _*)
    println(newMapFruits.mkString(", "))

    // Concatenate new value to Mutable Map
    newMapFruits ++= Map('d' -> List("Dragon Fruit"),'e'->List("Eclairs"))

    // Tuple Datatype
    // Tuple : Collection of Immutable Datatype, Fixed Size, Heterogeneous
    val tuple1 = (1, "Hello Tuple", 3.14, "Scala", 9876543210L)
    val firstValue = tuple1._1
    val secondValue = tuple1._2
    println(firstValue)

    // Pattern Matching in Tuple
    val(var1, var2, var3) = (1, "Scala", 3.14)
    println(var1)
    // Returns number of elements present in tuple.
    println(tuple1.productArity)

    // Returns Datatype of variable
    println(tuple1.getClass)

    // copy : Allows you to copy tuple with some elements replaced
    val newTuple = tuple1.copy(_4 = "Tuple")
    
    // => (Arrow Function)
    // In Scala, => is used to denote a lambda expression or anonymous function
    // (parameter) => expression
    tuple1.productIterator.foreach{
      (element => println(s"Element: $element"))
    }
  }
}
