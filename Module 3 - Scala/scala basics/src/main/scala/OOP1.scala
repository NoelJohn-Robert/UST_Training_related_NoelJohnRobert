class Car(val make: String, val model: String, var year: Int) {
    def displayInfo(): Unit = {
        println(s"Car Info: $year $make $model")
    }
}

// singleton object extends app {trait} which does not need the main() function
object SimpleClass extends App {
    val car = new Car("HYUNDAI", "Creta", 2023)
    car.displayInfo()

    car.year = 2024
    car.displayInfo()
}
