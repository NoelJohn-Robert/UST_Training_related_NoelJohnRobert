## Styles in Scala

 Styles: It refers to ways of writing Scala program.
It is based on various programming paradigms supported by the language:
1. Functional Style
2. Object-oriented style
3. Patterns matching style
4. For-Comprehension:
   ```val num = List(1,2,3,4,5,6,7)
   val result = for {
   n <- num
   squared = n*n
   } yield squared
   println(result)
5. If comprehension
6. Type class
7. Traits and Mixins
8. Imperative styles