object loops {
    private def isPrime(num: Int): Boolean = {
        if (num == 1) {
            return false
        }
        for (i<-2 to math.sqrt(num).toInt if num%i==0) {
            return false
        }
        true
    }

    def main(args: Array[String]): Unit = {
        // simple while loop that prints numbers from 1 to 9
        var variable = 1
        while (variable < 10) {
            println("Hi")
            variable += 1
        }


        // do-while loop: dropped in scala 3
//        var j = 1
//        do
//            print(j + " ")
//            j += 1
//        while(j<10);
//        println()


        // for loop
        val fruits = List("Apple", "Mango", "Guava", "Pineapple", "Apricot", "Strawberry", "Cherry")
        for (fruit <- fruits) {
            print(fruit + " ")
        }
        println()

        // alternate for-loop
        for (i<-1 to 10) print(i + " ")
        println()

        // alternate for-loop, with step size 2
        for (i <- 1 to 10 by 2) print(i + " ")
        println()



        val foodList  = List("Idli", "Appam", "Biryani", "dosa")
        for (food<-foodList)
            print(s"$food ")

        println()


        // filtering records in for loop using if condition
        // 1. write Scala program which creates a collection of even array
        import scala.collection.mutable.ArrayBuffer
        val evenArray = ArrayBuffer[Int]()
        for (m <- 1 to 20 if m%2==0)
            evenArray += m
        print("Even numbers: " + evenArray.mkString(", "))
        println()

        // 2. write scala program to show collection of prime numbers between 1 and 100
        val primeArray = ArrayBuffer[Int]()
        for (num<-1 to 100 if isPrime(num)) primeArray += num
        println("Prime numbers: " + primeArray.mkString(", "))


        // 3. fibonacci series using while loop
        var fib_num1 = 0
        var fib_num2 = 1
        print("Fibonacci series: " + fib_num1 + " "  + fib_num2)
        var count = 0
        while (count <= 10) {
            count += 1
            var fib_next = (fib_num1+fib_num2)
            print(" " + fib_next)
            fib_num1 = fib_num2
            fib_num2 = fib_next
        }
        println()


        // 4. find first prime number greater than given number
        import scala.io.StdIn._
        print("please enter number: ")
        val input_num = readInt()
        var next_num = input_num + 1
        var prime_found = false
        while (!prime_found) {
            var loop_var = 2
            var prime_flag = true
            while (loop_var <= math.sqrt(next_num))
                if (next_num%loop_var == 0)
                    prime_flag = false
                loop_var += 1

            if (!prime_flag)
                next_num += 1
            else
                prime_found = true
        }
        println(s"Prime number after $input_num is $next_num")
    }
}
