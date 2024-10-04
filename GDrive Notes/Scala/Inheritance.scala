// Parent Class
class Animal (val name: String) {
  def makeSound(): Unit = {
    println(s"$name makes sound")
  }
}
// SubClass
class Dog(name: String) extends Animal(name) {
  override def makeSound(): Unit = {
    println(s"$name make sound: Woof!")
  }
}

object InheritanceExample extends App {
  val animal = new Animal("Generic Name")
  animal.makeSound()

  val dog = new Dog("Tom")
  dog.makeSound()
}