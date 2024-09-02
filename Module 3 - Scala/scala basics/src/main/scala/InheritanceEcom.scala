class Ecommerce(val name:String, val quantity:Float, val price:Float) {
    def displayDetails(): Unit =  {
        // return name, qty, per unit price, total price
        println(s"Name:$name, Quantity:$quantity, PricePerUnit:$price, TotalPrice:${quantity*price}")
    }
}


// Inheritance - electronics
class Electronics(name:String, quantity:Float, price:Float) extends Ecommerce(name, quantity, price) {
    override def displayDetails(): Unit = {
        // super.displayDetails()
        println(s"Name:$name, Category:Electronics, Quantity:$quantity, PricePerUnit:$price, TotalPrice:${quantity*price}")
    }
}

// Inheritance - books
class Books(name:String, quantity:Float, price:Float) extends Ecommerce(name, quantity, price) {
    override def displayDetails(): Unit = {
        println(s"Name:$name, Category:Books, Quantity:$quantity, PricePerUnit:$price, TotalPrice:${quantity*price}")
    }
}

// Inheritance - footwear
class Footwear(name:String, quantity:Float, price:Float) extends Ecommerce(name, quantity, price) {
    override def displayDetails(): Unit = {
        println(s"Name:$name, Category:Footwear, Quantity:$quantity, PricePerUnit:$price, TotalPrice:${quantity*price}")
    }
}

object supporting extends App {
    val electronicsObject = new Electronics("Pixel 8",65999, 2)
    electronicsObject.displayDetails()

    val bookObject = new Books("Caliban's War", 1299, 3)
    bookObject.displayDetails()

    val footwearObject = new Footwear("Nike Shoes", 4599, 3)
    footwearObject.displayDetails()
}