// traits
// it is a special type of class used to define collection of methods 
// and field names which can be reused across different classes

// usage of traits
// improves code-reusability in scala
// instead of duplicating code in multiple classes, you can define common functionalities in a trait
// then you can mix it with any class to use

// scala does not support multiple inheritance {class inherited from more than one class}, 
// but traits help achieve this. class can extend one class and multiple traits



trait drivable {
    def drive() : Unit
}

trait flyable {
    def fly() : Unit = {
        println("Flying in the sky")
    }
}

class car (val name:String, val model:String) extends drivable {
    override def drive(): Unit = {
        println(s"Driving a $name $model")
    }
}

class Airplane (val name:String, val model:String) extends flyable with drivable {
    override def drive(): Unit = {
        println("Taxiing on the runway")
    }
    
    override def fly(): Unit = {
        println("Airplane is flying at 30000ft")
    }
}