
var url_base = "/thinklink/";

function ungrey(obj){
	if(obj.style.color == "gray"){
		obj.style.color = "black";
		obj.value = "";		
	}
}

function onInput(textbox,callback){
	textbox.keyup(function(ev){
		var text = textbox.val();
		//if(ev.which == 32){
			//callback(text);
		//}else{
			setTimeout(function(){
				if(text == textbox.val()){
					callback(text);
				}
			},200);
		//}
	});
}


function doAdd(obj){
	$(obj).text("marked")
	var snip = $(obj).parent();
	snip.find(".ignore").text("ignore")
	snip.addClass("snippet-added")
	snip.removeClass("snippet-ignored")
	setSnipStatus(snip,true)
}

function doIgnore(obj){
	$(obj).text("ignored")
	var snip = $(obj).parent()
	snip.find(".add").text("mark")
	snip.addClass("snippet-ignored")
	snip.removeClass("snippet-added")
	setSnipStatus(snip,false)
}

function setSnipStatus(snip,vote){
	var query = $("#data-query").val();
	var claim = $("#data-claim").val();
	var text = snip.find(".text").text();
	var bossurl = snip.parents(".bossurl");
	var url = bossurl.find("a").attr("href");
	var title = bossurl.find(".title").text();
	var position = bossurl.find(".position").val();
	$.post(url_base+"claim/"+claim+"/setsnippet",
		{query: query, text: text, url: url,title: title, vote: vote, position: position}, 
		function(querieshtml){
			$("#queries").html(querieshtml);
		}
	)
}

function submitForm(formid,fieldname,fieldval){
	var form = document.forms[formid];
	form[fieldname].value = fieldval;
	form.submit();		
}

function submitNewClaim(){
	var claimform = document.forms.newclaimform;
	var snipform = document.forms.newsnippet;
	snipform.name.value = claimform.name.value;
	snipform.descr.value = claimform.descr.value;
	snipform.submit();
}

function closePopupWindow(){
    var ev = document.createEvent("Events");
    ev.initEvent("thinklink-close-popup", true, false);
    document.body.dispatchEvent(evt);	
}

function connect(node,id,addto){
	if(node.className == "connect"){
		$.post(url_base+"connect/",{addto:addto,id:id},function(){
			node.className = "disconnect";
			node.textContent = "Disconnect";
		})
	}else{
		$.post(url_base+"connect/",{addto:addto,id:id,disconnect:true},function(){
			node.className = "connect";
			node.textContent = "Connect";
		})
	}
}
