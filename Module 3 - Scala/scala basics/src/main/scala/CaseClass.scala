// Case Classes are special classes in scala that are immutable and compared by value.
// They are ideally used in pattern matching
// Starts or begins with keyword 'case'


// case classes will automatically provide useful methods, and those methods will be 
// toString, equals, hashcode, 
// built-in support for pattern matching

//case class Person(name:String, age:Int)
//
//// main object
//object Main extends App {
//    // create object of case class
//    val person = Person("Tom", 20)
//
//    // define function to describe a person
//    def describePerson(person: Any): String = person match {
//        case Person(name, age) => s"Person Name:$name, Age:$age"
//    }
//
//    // test functionality
//    println(describePerson(person))
//}





object Main extends App {
    // define a case class
    case class Employee(name: String, age: Int)

    // define omstance of case class
    val obj = Employee("Melissa", 20)

    // sccdss fields
    println(obj.name)

    obj match {
        case Employee(name, age) => println(s"Name:%$name , Age:$age")
    }

    val obj1 = obj.copy(name = "Anu")
    println(obj1)
}
