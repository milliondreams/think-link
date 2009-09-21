package com.intel.thinkscala.learn
import scala.collection.mutable.HashMap
import scala.io.Source
import java.io.File

object HotWords {
	def loadHotwords : HashMap[String,Int] = {
		var map = new HashMap[String,Int]
		val source = Source.fromFile(new File("/home/rob/wiki_wordfreqs"))
		source.getLines("\n") foreach {line =>
			val split = line.indexOf(":")
			if(split > 0){
				val word = line.substring(0,split)
				val count = Integer.parseInt(line.substring(split+1))
				map(word) = count
			}
		}
		return map
	}

	val wordfreqs = loadHotwords

	def hotWords(str : String) : (String,String) = {
		val words = Paraphraser.textWords(str)	
		val scored : Seq[(String,Option[int])]= words map (word => (word,wordfreqs.get(word)))
		val sorted = scored.toList.sort((x,y) => (x._2,y._2) match {
			case (Some(xf),Some(yf)) => xf < yf
			case (None,Some(yf)) => false
			case (Some(xf),None) => true
			case (None,None) => x._1 < y._1
		})
		(sorted(0)._1,sorted(1)._1)
	}
	
}