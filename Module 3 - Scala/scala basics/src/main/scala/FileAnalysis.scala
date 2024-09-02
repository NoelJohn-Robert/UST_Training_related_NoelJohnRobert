import scala.io.Source
object FileAnalysis {
    def main(args: Array[String]): Unit = {
        // read from file
        val source = Source.fromFile("C:\\Users\\Administrator\\Downloads\\sample.txt")

        // read all data from file and create list of lines
        val lines = source.getLines().toList

        // close file object
        source.close()
//        lines.foreach(println)
//        println(lines(0))

//        val words = lines.map(_.split("\\s+").mkString(", "))
        val words = lines.flatMap(_.split("\\s+")).map(_.toLowerCase)
        println(words)

        // group words by identity
        // map values by size
        // sorting by word count in descending order
        val wordCount = words.groupBy(identity).mapValues(_.size).toSeq.sortBy(-_._2)
        println(wordCount)

        // display top 10 most frequent words
//        wordCount.take(10).foreach {
//            case (word, count) => println(s"$word: $count")
//        }


        // Q: find the word with maximum length and minimum length
        val wordsByLength = words.sortBy(-_.length)
        println(s"Word with max number of characters: ${wordsByLength.take(3)}")
        println(s"Word with min number of characters: ${wordsByLength.takeRight(1)}")


        // Q: find total number of words
        print(s"Total number of words: ${words.length}")


    }
}