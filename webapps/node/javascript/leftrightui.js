
var big_right_arrow = null;
var panelbox = null;

var widthpad = null;

function makeOrgUI(divid){
	panelbox = $("<tr class='panelbox'/>");
	$(document.body).append($("<table class='toptable'>").append(panelbox));
	widthpad = $("<div class='widthpad'>pad</div>").appendTo(document.body);
	
	getPanel(0,"recent.js");
	
	//var arrow = makeArrow();
	//big_right_arrow = arrow;
}

function getPanel(panelnum,nodeid,name){
	if($(".toptable").width() > widthpad.width()){
		widthpad.css("width",$(".toptable").width());
	}
	
	for(var i = panelnum; $("#panel-"+i).length != 0; i++){
		$("#panel-"+i).remove();		
	}
	panel = makePanel(panelnum,nodeid,name);
	panelbox.append(panel);
}

function makeArrow(panelnum,item){
	for(var i = panelnum; $("#arrow-"+i).length != 0; i++){
		$("#arrow-"+i).remove();		
	}

	var pos = getPos(item.get(0));
	var arrow = $("<td class='arrow'>")
		.attr("id","arrow-"+panelnum)
		.css("padding-top",pos.top + item.height()/2 - 40);
	arrow.append($("<img/>").attr("src",iconUrl("big_right_arrow")));
	return arrow;	
}

function moveArrow(){
	var node;
	if(selection){
		node = selection;
	}else{
		node = $("#panel-0");
	}
	var pos = getPos(node.get(0));
	var panel = $("#panel-0");
	var panel2 = $("#panel-1");
	var panpos = getPos(panel.get(0));
}


function makePanel(panelnum,nodeid,name){
	var panel = $("<td class='panel'/>").attr("id","panel-"+panelnum);
	loadObject(panel,nodeid,panelnum,name);
	return panel;
}

function loadObject(panel,nodeid,panelnum,name){
	var url;
	if(nodeid.indexOf("?") == -1){
		url = urlbase+"node/"+nodeid+"?callback=?";
	}else{
		url = urlbase+"node/"+nodeid+"&callback=?";
	}
	panel.empty();
	if(nodeid == "0.js"){ // wikipedia-only topic
		panel.append(makeWikiInfo(name));	
		panel.attr("class","wikipanel");	
	}else{
		$.getJSON(url,function(obj){
			panel.append(makeInfo(obj,panelnum));
		});	
	}
}

var verbs = ["supports","opposes","relates to","colitem"];

function removeParent(list,panelnum){
	if(!list){return null;};
	var newlist = [];
	for(var i = 0; i < list.length; i++){
		var item = list[i];
		if(item.id != selectionid[panelnum-2]){
			newlist.push(item);			
		}
	}
	return newlist;
}

function makeWikiInfo(name){
	var info = $("<div class='info'/>");
	$("<h2>Wikipedia Topic</h2>").appendTo(info);
	var iframe = $("<iframe class='wikiframe'/>")
		.attr("height",	$(".toptable").height())
		.attr("src","http://en.wikipedia.org/wiki/"+name)
		.appendTo(info);		
	return info;
}

function makeInfo(obj,panelnum){
	var info = $("<div class='info'/>");
	var body = $("<div class='panelbody'>").appendTo(info);
	
	$("<h2/>").text(obj.type).appendTo(body);
	$("<div class='objtitle'/>").text(obj.text).appendTo(body);	
	
	obj.from.supports = removeParent(obj.from.supports,panelnum);
	obj.from.opposes = removeParent(obj.from.opposes,panelnum);
	obj.from['relates to'] = removeParent(obj.from['relates to'],panelnum);
	
	
	switch(obj.type){
		case "snippet":		
			body.append(makeSubGroup("claims supported",obj.from.supports,panelnum));
			body.append(makeSubGroup("claims opposed",obj.from.opposes,panelnum));
			body.append(makeSubGroup("claims discussed",obj.from['relates to'],panelnum));
			break;
		case "topic":
			body.append(makeSubGroup("claims about this topic",obj.to.about,panelnum));
			body.append(makeSubGroup("snippets about this topic",obj.to.snipabout,panelnum));
			body.append(makeSubGroup("related topics",obj.to['relates to'],panelnum));
			break;
		case "claim":
			body.append(makeSubGroup("supported by",obj.to.supports,panelnum));
			body.append(makeSubGroup("opposed by",obj.to.opposes,panelnum));
			body.append(makeSubGroup("related to",obj.to['relates to'],panelnum));
			body.append(makeSubGroup("supporting snippets",obj.to.prosnips,panelnum));
			body.append(makeSubGroup("opposing snippets",obj.to.consnips,panelnum));
			body.append(makeSubGroup("related snippets",obj.to.aboutsnips,panelnum));
			body.append(makeSubGroup("related topics",obj.from.about,panelnum));
			break;
		default:
			body.append(makeSubGroup(null,obj.to.colitem,panelnum));
			break;

	}
	
	var add = $("<div class='addbox'><span class='addhdr'>add</span></div>").appendTo(body);;
	var addpanel = $("<div class='addpanel'/>");
	add.append(makeAdder("topic","topic","about",false,addpanel,obj,panelnum));
	if(obj.type == "claim"){
		add.append(makeAdder("supporting claim","claim","supports",true,addpanel,obj,panelnum));
		add.append(makeAdder("opposing claim","claim","opposes",true,addpanel,obj,panelnum));
		add.append(makeAdder("related claim","claim","relates to",true,addpanel,obj,panelnum));
	}
	if(obj.type == "snippet"){
		add.append(makeAdder("supported claim","claim","supports",false,addpanel,obj,panelnum));
		add.append(makeAdder("opposed claim","claim","opposes",false,addpanel,obj,panelnum));
		add.append(makeAdder("related claim","claim","relates to",false,addpanel,obj,panelnum));
	}

	addpanel.appendTo(body);

	//if(obj.type == "snippet" && obj.info && obj.info.url){
	//var iframe = $("<iframe class='snipframe'/>")
		//.attr("height",	$(".toptable").height())
		//.attr("src",obj.info.url)
		//.appendTo(info);		
	//}
	
	return info;
}

function makeAdder(title,type,verb,reverse,panel,obj,panelnum){
	var callback = function(other){	
		if(reverse){
			$.post(urlbase+"node/"+other.id+"/addlink.js?verb="+verb+
				"&type="+type+
				"&id="+obj.id+"&text="+obj.text+"&reverse="+reverse,function(){
					getPanel(panelnum,obj.id+'.js',null);
			});
		}else{
			$.post(urlbase+"node/"+obj.id+"/addlink.js?verb="+verb+
				"&type="+type+
				"&id="+other.id+"&text="+other.text+"&reverse="+reverse,function(){
					getPanel(panelnum,obj.id+'.js',null);
			});
		}
	};
	
	var adder = $("<span class='adder'/>").text(title)
		.click(function(){
			panel.empty();
			if(adder.attr("class") == "adder-selected"){
				adder.attr("class","adder");
				return;
			}
			
			adder.parent().find(".adder-selected").attr("class","adder");
			adder.attr("class","adder-selected");
			var textbox = $("<input class='addtxt' type='text'>").appendTo(panel);
			var gobut = $("<input class='addbutton' type='button' value='add'>").appendTo(panel);

			textbox.keyup(function(){
				var text = textbox.val();
				setTimeout(function(){
					var nowtext = textbox.val();
					if(text == nowtext){
						updateSuggestions(panel,
							urlbase+"node/search.js?type="+type+"&callback=?&query="+encodeURIComponent(text),
							panelnum,"suggested "+type+"s",obj,callback);
					}
				},500);
			});

			if(type == "topic"){
				updateSuggestions(panel,
					"http://localhost:8180/test/test?id="+obj.id+"&callback=?",
					panelnum,"suggested topics",obj,callback);
			}else{ // crappy suggestions for the moment
				updateSuggestions(panel,
					"http://localhost:8180/thinklink/node/search.js?type=claim&query="+encodeURIComponent(obj.text)+"&callback=?",
					panelnum,"suggested claims",obj,callback);
			}
		});
	
	return adder;
}

function updateSuggestions(panel,url,panelnum,title,obj,callback){
	panel.find(".suggestions").remove();
	panel.find(".sugghdr").remove();
	$.getJSON(url,function(sugs){
		$("<div class='sugghdr'/>").text(title).appendTo(panel);
		panel.append(makeSuggestor(obj,sugs,panelnum,callback));
	});
}

function makeSuggestor(obj,topics,panelnum,callback){
	var box = $("<div class='suggestions'/>");
	var topics = topics.to.colitem;
	for(var i = 0; i < topics.length; i++){ // TODO: allow this to be expanded
		box.append(makeSuggestion(topics[i],panelnum,callback));
	}
	return box;
}

function makeSubGroup(subtitle,links,panelnum){
	var group = $("<div class='subgroup'>").appendTo(group);
	if(links && links.length > 0){
		if(subtitle && subtitle != "colitem"){
			$("<h3/>").text(subtitle).appendTo(group);
		}
		for(var j = 0; j < links.length; j++){
			group.append(makeLink(links[j],panelnum));
		} 
	} 
	return group;
}

function makeSuggestion(obj,panelnum,callback){
	var item = $("<a class='item'/>")
		.attr("href",urlbase+"node/"+obj.id)
		.attr("tl_panel",panelnum)
		.click(function(ev){
			ev.preventDefault();
			selectItem(item,obj.id,panelnum,obj.text);
			return false;
		});
	
	var add = $("<span class='greenadd'>add</span>")
		.click(function(ev){
			ev.preventDefault(); ev.stopPropagation();			
			callback(obj);
		});

	var text = $("<span/>").text(obj.text);
	item.append(makeHBox([add,text],"linkbox"));
	
	return item;
}

function trim_url(url){
	m = url.match(/http:\/\/(www.)?([^\/]*)/);
	if(m){
		return m[2];
	}else{
		return url;
	}		
}

function makeLink(obj,panelnum,suggestcb){
	var item = $("<a class='item'/>")
		.attr("href",urlbase+"node/"+obj.id)
		.attr("tl_panel",panelnum)
		.click(function(ev){
			ev.preventDefault();
			selectItem(item,obj.id,panelnum);
			return false;
			});		
	
	var icon = $("<img class='icon'/>").attr("src",getIcon(obj));				
	var text = $("<span/>").text(obj.text);
	item.append(makeHBox([icon,text],"linkbox"));
	
	if(obj.type == "snippet" && obj.info && obj.info.url){
		var site = $("<span class='snipshorturl'/>").text(trim_url(obj.info.url));
		site.appendTo(text);		
	}
	
	var votebox = $("<nobr class='votebox'/>").appendTo(text);
	
	var up = $("<img class='vote' title='Promote'/>").attr("src",iconUrl("vote_up_e"))
		.mouseover(function(){up.attr("src",iconUrl("vote_up_on"))})
		.mouseout(function(){up.attr("src",iconUrl("vote_up_e"))})
		.click(function(ev){
			ev.preventDefault(); ev.stopPropagation();			
		})
		.appendTo(votebox);		

	var down = $("<img class='vote' title='Remove'/>").attr("src",iconUrl("vote_down_e"))
		.mouseover(function(){down.attr("src",iconUrl("vote_down_on"))})
		.mouseout(function(){down.attr("src",iconUrl("vote_down_e"))})
		.click(function(ev){
			ev.preventDefault(); ev.stopPropagation();			
		})
		.appendTo(votebox);		
	
	return item;
}

function iconUrl(icon){
	return urlbase+"images/"+icon+".png";
}

function getIcon(obj){
	if(obj.icon){
		return obj.icon;
	}
	switch(obj.type){
		case "claim":
			if(obj.opposed){
				return iconUrl("exclamation");
			}else{
				return iconUrl("lightbulb");
			}
		case "snippet":
			return iconUrl("comment");
		case "topic":
			return iconUrl("folder");
		case "user":
			return iconUrl("user");
	}
}
	

var selection = {};
var selectionid = {};

function selectItem(item,id,panelnum,text){
	try{
		if($(".toptable").width() > widthpad.width()){
			widthpad.css("width",$(".toptable").width());
		}
			
		if(selection[panelnum] == item){
			return;
		}
		item.attr("class","item-selected");
		if(selection[panelnum]){
			selection[panelnum].attr("class","item");
		}
		selection[panelnum] = item;
		selectionid[panelnum] = id;
		panelbox.append(makeArrow(panelnum,item));
		getPanel(panelnum+1,""+id+".js",text);
		var panel = $("#panel-"+panelnum);
		var pos = getPos(panel.get(0));
		$('html,body').animate({scrollLeft: pos.left},500);
	}catch(ex){
		console.error(ex);
	}
}

function getParentWithClass(node,classname){
	while(node != null && node.getAttribute){
		if(node.className == classname){
			return node;
		}
		node = parentNode;
	}
}

function makeHBox(items,classname){
	var table = $("<table/>");
	if(classname){
		table.attr("class",classname);
	}
	var tr = $("<tr/>").appendTo(table);
	for(var i = 0; i < items.length; i++){
		var td = $("<td/>").append(items[i]).appendTo(tr);
	}
	return table;
}

function getPos(node){
	var left = 0;
	var top = 0;
	while(node){
		left += node.offsetLeft;
		top += node.offsetTop;
		node = node.offsetParent;
	}
	return {left:left,top:top};
}

function invertVerb(verb,text,type){
	switch(verb){
		case "about": return "claims about "+text;
		case "refines": return "more specific topics";
		case "opposes": return "opposed by";
		case "supports": return "supported by";
		case "relates to": return "relates to";
		case "states": 
			if(type == "claim"){
				return "snippets making this claim";
			}else{
				return "snippets about this topic";
			}
		case "related": return "related";
		case "colitem": return "colitem";
		case "created by": return "created";
	}	
	return "";
}

function tl_log(msg){		
	if(typeof console !== "undefined"){
		console.log(msg);
	}
}
