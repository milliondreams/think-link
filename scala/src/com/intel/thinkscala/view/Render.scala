package com.intel.thinkscala.view
import scala.xml._

object Render {
  import Widgets._
  
  def claim(row : SqlRow)(implicit c : ReqContext) = 
    <div class="claim">
      <a class="title" href={Urls.claim(row("id"))}>{row("text")}</a>
      <div class="description">{row("description")}</div>
      {userref(row.int("user_id"),row.str("username"),"created by")}
      - <a href={Urls.findsnippets(row("id"))} class="instances">seen <span class="count">{row("instance_count")}</span> times on the web</a>  
<!--      <span class="agree"><span class="count">{row("agree_count")}</span> agree</span>
      - <span class="disagree"><span class="count">{row("disagree_count")}</span> disagree</span>    
-->
  </div>  

  def nodelink(row : SqlRow)(implicit c : ReqContext) =
    <div class="claimlink">
      {if(row("linkid") != null){
    	  	<div onclick={"connect(this,"+row("id")+","+c.arg("addto")+")"} class="disconnect">Disconnect</div>
       }else{
    	   <div onclick={"connect(this,"+row("id")+","+c.arg("addto")+")"} class="connect">Connect</div>
      }}
      <a class="title" href={Urls.topic(row("id"))}>{row("text")}</a>
    </div>

  def topic(row : SqlRow) =
    <div class="claim">
      <a class="title" href={Urls.topic(row("id"))}>{row("text")}</a>
      <div class="description">{row("description")}</div>
      {userref(row.int("user_id"),row.str("username"),"created by")}
      - <span class="claimcount"><span class="count">{row("instance_count")}</span> claims in this topic</span>
    </div>
  
  def user(row : SqlRow) =  
    <div class="claim">
      <a class='title' href={Urls.user(row("id"))}>{row("name")}</a>
      <div class='instances'>marked <span class='count'>{row("snipcount")}</span> snippets
         and created <span class='count'>{row("claimcount")}</span> claims</div>
    </div>
    
  def userLinkCount(row : SqlRow) = 
    <div class="linkcount">
      <a class="title" href={Urls.claim(row("id"))}>{row.str("text")}</a>
      <div class="instances">found <span class="count">{row("count")}</span> instances</div>
    </div>
  
      
  def evidence(row : SqlRow) : NodeSeq = {
    (<div class="webquote">
        <span class="title">{row.getOrElse("title","")}</span>
        <div class="text">{row("text")}</div>
        <a target="_blank" class="url" href={row.str("url")}>{row("url")}</a>                                                     
        {userref(row.int("user_id"), row.str("username"), "found by")} 
    </div>)
   }
  
  def userEvidence(row : SqlRow) =
    <div class="webquote">
        <span class="title">{row.getOrElse("title","")}</span>
        <div class="text">{row("text")}</div>
        <a target="_blank" class="url" href={row.str("url")}>{row("url")}</a>                                                     
        <div class="says">{row("verb")}
            <a class="claimlink" href={Urls.claim(row("claimid"))}>{row("claimtext")}</a>
        </div>
    </div>
  
  
  
     
  def topbar(c : ReqContext) = 
    <div id="topbar">
	    <a class="home" href={Urls.home}>Think Link</a>
	    {if(c.user.realuser)
	         <a class="user" href={Urls.profile(c.user.userid)}>{c.user.name}</a>
	         <a class="logout" href={Urls.logout}>logout</a>
	     else
             <a class="signup" href={Urls.signup}>sign up</a>
	         <a class="login" href={Urls.login(c.getUrl)}>login</a>           
	    }
	    <form class="searchbox" action={Urls.search} method="GET">
           {greyInput("query","query","Search")}
           <input class="icon" type="image" src={Images.search} alt="search"/>
        </form>         
        <a class='bugreport' href="mailto:robert.ennals@intel.com?body=Report a bug, suggest a feature, or just tell us what you think.">Send us your feedback</a>
    </div>
    
  def userref(id : Int, name : String, message : String) =
    <span class="user">{message} <a href={Urls.user(id)}>{name}</a></span>
            
 def searchQueryList(c : ReqContext, claimid : Int) = 
    (c.store.searchQueries(claimid) flatMap (Render.searchQuery(_,claimid))) ++
    (<a class="manualmarked" href={Urls.findsnippets(claimid,true)}>marked with extension</a>)

    
  def searchQuery(row : SqlRow, claimid : Int) : NodeSeq = 
    <div class="query">
    <a href={Urls.findsnippets(claimid,row.str("searchtext"))}>{row("searchtext")}</a>
    <div class="score">
    <span class="yes">{row("marked_yes")} marked</span>
    <span class="no">{row("marked_no")} ignored</span>
    </div>
    </div>

    // TODO: these should all be stored in the database before being shown
  def bossUrl(bu : BossUrl, position : Int,query : String)(implicit c : ReqContext) = 
    <div class="bossurl">
    <span class="title">{bu.title}</span>
    <a href={bu.url}>{bu.url}</a>
    <div class="snippets">
      {bu.snips flatMap (s => bossSnip(s,bu,position,query))}
    </div>
    </div>
    
  def bossSnip(snip : String, bu : BossUrl, position : Int, query : String)(implicit c : ReqContext) = {
    val existing = c.store.existingSnippet(bu.url,query,snip)
    val (mode,userrow) = c.store.existingSnippet(bu.url,query,snip) match {
      case Some(row) if(row("state") == "true") => ("added",row)
      case Some(row) if(row("state") == "false") => ("ignored",row)
      case _ => ("undecided",null)
    }
    <div class={"snippet snippet-"+mode}>
       <input type="hidden" class="position" value={""+position}/>
       <div class="text">{snip}</div>
       {if(c.user.realuser){
       <a class="add" onclick="doAdd(this)">{if(mode == "added") "marked" else "mark"}</a>
       <a class="ignore" onclick="doIgnore(this)">{if(mode == "ignored") "ignored" else "ignore"}</a>
        }else{
        	<a class="mustlogin" href={Urls.login(c.getUrl)}>login to edit</a>
        }
       }
       {if(userrow != null){
         userref(userrow.int("user_id"), userrow.str("username"), "by") 
        }else{          
        }
       }
    </div>    
    }
  
  def bossResults(query : String,page : Int)(implicit c : ReqContext) : NodeSeq = {
      val bossUrls = SnipSearch.searchBoss(query,page,10)      
      return <div class='searchcontent'>{Util.flatMapWithIndex(bossUrls,Render.bossUrl(_ : BossUrl,_,query))}</div>
  }
  
  def snipSearchResults(query : String)(implicit c : ReqContext) = 
    <div id="searchlist">
    <h2>Search Results matching "{query}"</h2>
    {Widgets.pagedList(bossResults(query,_))}
    </div>

  def markedSnippet(row : SqlRow)(implicit c : ReqContext) = 
    <div class='bossurl'>
      <span class='title'>{row("title")}</span>
      <a href={row.str("url")}>{row("url")}</a>
      <div class='snippets'>
          <input type='hidden' class='position' value="0"/>
         <div class={if(row("state") == "true") "snippet snippet-added" else "snippet snippet-ignored"}>
	       <div class="text">{row("abstract")}</div>
         {if(c.user.realuser){
	       <a class="add" onclick="doAdd(this)">{if(row("state") == "true") "marked" else "mark"}</a>
	       <a class="ignore" onclick="doIgnore(this)">{if(row("state") == "false") "ignored" else "ignore"}</a>         	
            }else{
        	<a class="mustlogin" href={Urls.login(c.getUrl)}>login to edit</a>
            }
         }
         {userref(row.int("user_id"), row.str("username"), "by")} 
         </div>
      </div>
    </div>
    
  def topicref(row : SqlRow) = 
    <a href={Urls.topic(row.int("id"))}>{row("text")}</a>
    
  def markedPage(row : SqlRow) = 
    <div class='claim'>
       <a class='title' target="_blank" href={row.str("url")}>{row("title")}</a>
       <a class='url' target="_blank" href={row.str("url")}>{Util.trimString(row.str("url"),80)}</a>
       <div class='says'>says that <a class='claimlink' href={Urls.claim(row("claimid"))}>{row("claimtext")}</a></div>
       {if(row.isDefinedAt("user_id")){userref(row.int("user_id"),row.str("username"),"marked by")} else {}}
    </div>
  
  def extension(c : ReqContext) = 
    if(c.getCookie("extension") == "true"){
    	<div class='hasextension'>extension installed</div>     
    }else{
        <a class='install' href={Urls.extension}>Install the FireFox extension</a>
    }
  
}      





object Images {
  import Urls._
  val imagebase = "/thinklink/images/"
  val search = imagebase + "magnifier.png"
}

object Messages {
  val pitch = <p>
    Discover when information you read on the web is disputed.
    Install the <a href="https://addons.mozilla.org/en-US/firefox/addon/11712">Firefox browser extension</a> to have Think Link
    highlight disputed claims on pages you read.  
    </p>
}



object Template {
  import Render._
  
  def normal(c : ReqContext, title : String, body : NodeSeq) = 
    basics(title,(<body class='body'>{topbar(c) ++ extension(c) ++ body}</body>))
  
  def mini(c : ReqContext, body : NodeSeq) =    
    basics("Think Link Popup Interface",(<body class='minibody'>{body}</body>))
  
  def nobar(c : ReqContext, body : NodeSeq) = 
    basics("",(<body class='body'>{body}</body>))
  
  def basics(title : String, body : NodeSeq) =
    <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
      <meta http-equiv="Content-Language" content="en-us" />
      <title>{title}</title>
      <link rel="icon" type="image/png" href="/thinklink/images/lightbulb_red.png" />
      <link rel="stylesheet" href="/thinklink/stylesheets/normal.css" media="screen"/>
      <script src="/thinklink/javascript/jquery-1.2.3.js" type="text/javascript"/>
      <script src="/thinklink/javascript/standard.js" type="text/javascript"/>
    </head>
      {body}
    </html>  
}
