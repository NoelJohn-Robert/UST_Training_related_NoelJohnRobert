object Loops{
  def main(args:Array[String]): Unit = {
    // A simple while loop syntax that print numbers from 1 to 9
    var variable = 1
    while (variable < 10) {
      println(variable)
      variable += 1
    }

    // For Loop
    val fruits = List("apples","banana","cherry","oranges",
      "pineapple")

    for (fruit <- fruits) {
      println(fruit)
    }

    for (i <- 1 to 10){
      println(i)
    }

    for (i <- 1 to 10 by 2) {
      println(i)
    }

    val food_list = List("idli","vada","dosa","uttapam","biryani","chocolate","curd")
    for (food<-food_list){
      println(food)
    }

    // Filtering records in for loop using if-condition
    // 1. Write a scala program to create collection of Even Array
    import scala.collection.mutable.ArrayBuffer
    val evenArray = ArrayBuffer[Int]()
    for (m <- 1 to 20 if m % 2 == 0){
      evenArray += m
    }
    println(evenArray.mkString(","))

    for (i<-1 to 10){
      println(i)
    }

    for (i <- 1 until 10) {
      println(i)
    }
    // 2. Write a Scala program to show collection of prime numbers 1-100.
    val primeNumbers = ArrayBuffer[Int]()
    for (i <- 1 to 100){
        if (i > 1){
          var isPrime = true
          for (j <- 2 to math.sqrt(i).toInt if isPrime){
            if (i % j == 0){
              isPrime = false
            }
          }
          if (isPrime){
            primeNumbers += i
          }
        }
    }
    println(primeNumbers)

    // 3. Fibonacci Series using while Loop

    // 4. Find the first prime number greater than given number. Take user input.
    import scala.io.StdIn._
    println("Please enter a value: ")
    val value = readInt()
    var i=1
    var j=2
    while (i <100) {
      var f=0
      if (i > 1) {
        var isPrime = true
        while(j < i/2 ) {
          if (i % j == 0) {
            f=1
          }
         j+=1
        }
        if (f==0 && j!=1) {
          primeNumbers += i
        }
      
      }
      i+=1
    }
    val A=primeNumbers.filter(_>value)
    println(A(0))
  }
}
