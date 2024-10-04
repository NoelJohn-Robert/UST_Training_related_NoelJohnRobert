import scala.io.Source
object FileAnalysis{
  def main(args: Array[String]): Unit = {
    // Read from file
    val source = Source.fromFile("C:/Users/Administrator/Downloads/sample.txt")
    // Read all values and create List of Lines
    val lines = source.getLines().toList
    // Close the file object
    source.close()
    println(lines)
    // Process the file data
    // split lines into words, change words to its lowercase.
    val words = lines.flatMap(_.split("\\s+")).map(_.toLowerCase)
    println(words)
    // group words by identity
    // map values by its size
    // sort words in descending order using negated values (-_._2)
    val wordCount = words.groupBy(identity).mapValues(_.size)
      .toSeq.sortBy(-_._2)

    // Print Top 10 most frequent words
    wordCount.take(10).foreach{
      case (word, count) =>
      println(s"$word: $count")
    }

    // 1. Find the count of words
    println(words.length)


    // 2. Find the word with maximum length and minimum length

    val sortedWords = words.sortWith(_.length<_.length)
    println("Minimum Length: "+sortedWords.head)
    println("Maximum Length: " + sortedWords.last)
    
  }
}

