package com.intel.thinkscala.claimfinder
import scala.xml.NodeSeq
import scala.xml.Node
import scala.xml.parsing._
import scala.io._
import java.io._
import com.intel.thinkscala.Util._
import scala.collection.mutable.ListBuffer
 
object ClaimFinder {
	val bossKey = "NpeiOwLV34E5KHWPTxBix1HTRHe4zIj2LfTtyyDKvBdeQHOzlC_RIv4SmAPuBh3E";
	val bossSvr = "http://boss.yahooapis.com/ysearch/web/v1";
	
	def bossUrl(phrase : String, page : Int) = 
		bossSvr + "/"+encode(phrase)+"?appid="+bossKey+"&format=xml&count=50&start="+(page*50)
	
	def getUrls(phrase : String, page : Int) : Seq[String] = {
	    val url = bossUrl(phrase,page) 
	    val xmltext = download(url)
	    val parser = ConstructingParser.fromSource(Source.fromString(xmltext),false)
	    val doc = parser.document   
	    val results = doc \\ "result"
	    val realstart = doc \\ "resultset_web" \ "@start" text;
	    if(realstart == (page * 50).toString){
	    	return results map {result => result \ "url" text}    
	    }else{
	    	return null   // we reached the end
	    }
	}

	def getAllUrls(query : String) : Seq[String] = {
		var allurls = new ListBuffer[String]
		for(i <- 0 until 20){
			try{
				val urls = getUrls(query,i)
				if(urls == null) return allurls
				allurls.appendAll(urls)
				if(urls.length < 50) return allurls
			}catch{
				case _ => System.out.println("exception on batch "+i)
			}
		}
		return allurls
	}
	
	def getPhraseUrls(phrase : String, page : Int) : Seq[String] = 
		getUrls('"'+phrase+'"',page)	

	var basepath = "/home/rob/git/thinklink/output/claimfinder"
		
	def urlFileForPhrase(phrase : String){
		val filename = basepath+"/urlphrases/"+phrase.replace(" ","_")+".urls"
		if(fileExists(filename)) return
		val writer = new PrintWriter(new FileWriter(filename))
		val urls = getAllUrls('"'+phrase+'"')
		urls.foreach(url => writer.println(url))
		writer.close		
	}
	
	def getUrlsForAllPhrases(){
		phrases_that.foreach{phrase => 
			System.out.print("getting urls for phrase: "+phrase+"...")
			urlFileForPhrase(phrase)
			System.out.println("DONE")
			Thread.sleep(2000)
		}
	}	
	
	def getDomains(filename : String){
		val source = Source.fromFile(new File(filename))		
		val outfile = basepath+"domains.doms"
		val writer = new PrintWriter(new FileWriter(outfile))
		source.getLines("\n").foreach{url =>
			val domain = domainForUrl(url)
			writer.println(domain)
		}
		writer.close
	}
	
		
	val phrases_that = List(
			"into believing that",
			"people who think that",
			"people who believe that",
			"the misconception that",
			"the delusion that",
			"the myth that",
			"the mistaken belief that",
			"the fallacy that",
			"the lie that",
			"the false belief that",
			"the deception that",
			"the misunderstanding that",
			"false claim that",
			"mistakenly believe that",
			"mistaken belief that",
			"the absurdity that",
			"the absurd idea that",
			"the hoax that",
			"the deceit that",
			"falsely claimed that",
			"falsely claiming that",
			"erroneously believe that",
			"erroneous belief that",
			"the fabrication that",
			"falsely claim that",
			"bogus claim that",
			"urban myth that",
			"urban legend that",
			"the fantasy that",
			"incorrectly claim that",
			"incorrectly believe that",
			"stupidly believe that",
			"falsely believe that",
			"wrongly believe that",
			"falsely suggests that",
			"falsely claims that"
			)
	
}


