// base class
class Shape {
    def area():Double = 0.0
    
}

//derived class
 class Rectangle(val height:Double, val width:Double) extends Shape {
    override def area(): Double = height * width
}

class Triangle(val base:Double, val height:Double) extends Shape {
    override def area(): Double = 0.5 * base * height
}


// usage
object Polymorphism extends App {
    private val shapes: List[Shape] = List(new Rectangle(10, 11), new Triangle(4, 3))
    shapes.foreach(shape => println(shape.area()))
}