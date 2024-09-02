object DataStructures2 {
    def main(args:Array[String]): Unit = {
        // Scala Collection -3

        val fruitBasket = Map("Apricot"->30, "Banana"->250,"Cherry"->100, "Donuts"->24, "Eclair"->100)

        // importing mutable maps
        import scala.collection.mutable
        val mutableMap = mutable.Map("Apricot"->30, "Banana"->250,"Cherry"->100, "Donuts"->24, "Eclair"->100)

        val value = fruitBasket("Donuts")
        println(fruitBasket.contains("Donuts"))
        val mapSize = fruitBasket.size
        println(mapSize)


        // getting keys and values
        val keys = mutableMap.keys
        val values = mutableMap.values


        // adding and removing in map
        mutableMap += {"Fig"->24}
        mutableMap -= "Donuts"

        // apply same on immutable
        val new_fruitBasket1 = fruitBasket + {"Fig"->24}
        val new_fruitBasket2 = fruitBasket - "Fig"

        // updating values
        mutableMap("Fig") = 15
    }
}
