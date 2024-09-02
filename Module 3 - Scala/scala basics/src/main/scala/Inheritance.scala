// parent class
class Animal (val name: String) {
    def makeSound(): Unit = {
        println(s"$name makes sound")
    }
}

// subclass
class Dog(name:String) extends Animal(name) {
    override def makeSound(): Unit =  {
        println(s"$name make sound: Woof!!")
    }
}


object InheritanceExample extends App {
    val animal = new Animal("Generic")
    animal.makeSound()

    val dog_object = new Dog("Dobby")
    dog_object.makeSound()
}