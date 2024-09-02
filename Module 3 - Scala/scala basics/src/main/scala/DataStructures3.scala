object DataStructures3 {

    def main(args: Array[String]): Unit = {

        val set1 = Set(1, 2, 3, 4, 5, 6, 7, 8)
        val set2 = Set("Apple", "Banana", "Cherry", "Oranges", "Watermelon", "Pineapple")


        // basic operations
        println(set1.contains(5))
        println(set1.size)
        println(set1 + 9)


        // union of sets
        val set3 = Set("Grapes", "Tomato", "Guava", "Oranges", "Banana,")
        val fruitBasket = set2 union set3
        println(fruitBasket)


        //intersect
        val common = set2 intersect set3
        print(common)


        // difference
        val diff1 = set2 diff set3
        println(diff1)
        val diff2 = set3 diff set2
        println(diff2)


        // subset check
        val isSubset = set2.subsetOf(set3)
        print(isSubset)


        // transformation
        // map
        println(set2.map(_.toLowerCase))

        // reduce
        println(set1.reduce(_+_))

        // filter
        println(set2.filter(_.startsWith("G")))


        // MUTABLE sets
        import scala.collection.mutable
        val mutableSet = mutable.Set(10, 20, 30, 40, 50, 70, 90, 60);
        mutableSet ++= Set(80, 100)
        mutableSet --= Set(10, 30)
        println(mutableSet.mkString(", "))


        // clear the Set
        mutableSet.clear()


        // create a new collection
        val fruitList = List("Apple", "Apricon", "Banana", "Chocolate", "Coconut")
        val mapFruits = fruitList.groupBy(_.head)
        println("Grouped by first letter:" + mapFruits)


        // convert immutable Map to mutable Map
        val newMapFruits:mutable.Map[Char, List[String]] = mutable.Map(mapFruits.toSeq:_*)

        // concatenating new values to mutable map
        newMapFruits ++= Map('D'->List("Donut"), 'E'->List("Eclairs"))
        print(newMapFruits)
        println()
        println()





        // TUPLE
        val tuple1 = (1, "Hello Tuple", 3.14, "Scala", 9458470934L)
        println("First value in tuple: " + tuple1._1)
        println("Second value in tuple: " + tuple1._2)

        // pattern matching in tuples
        val(a,b,c) = (1, "Scala", "rnadombs")
        println("Pattern matching: " + a + " " + b + " " + c)

        // returns number of elements present in tuple
        println("productArity: " + tuple1.productArity)

        // get datatype of variable
        println(tuple1.getClass)

        // copy - allows to copy tuple with some elements
        val tuple1_copy = tuple1.copy(_4 = "Tuple")
        println(tuple1_copy)


        tuple1.productIterator.foreach(
            {element => println(s"Element: $element")}
        )
        // => is used to denote lambda expression
    }
}
