
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
			setTimeout(function(){
				if(text == textbox.val()){
					callback(text);
				}
			},200);
	});
}


function doAdd(obj){
	if(!loggedIn()){
		alert("You need to be logged in to mark a snippet");
		return;
	}
	var snip = $(obj).parent();
	snip.addClass("snippet-added")
	snip.removeClass("snippet-ignored")
	setSnipStatus(snip,true)
}

function doIgnore(obj){
	if(!loggedIn()){
		alert("You need to be logged in to mark a snippet");
		return;
	}
	var snip = $(obj).parent()
	snip.addClass("snippet-ignored")
	snip.removeClass("snippet-added")
	setSnipStatus(snip,false)
}

function setSnipStatus(button,vote){
	var snippet = button.parents(".snippet")
	var resultid = snippet.find(".resultid").val();
	var claim = $("#data-claim").val();	

	$.post(url_base+"snippet/"+resultid+"/setvote", {claim: claim}, 
		function(querieshtml){
			$("#queries").html(querieshtml);
		}
	)
}


function addEvidence(id){
	if(document.forms.newsnippet.rel && document.forms.newsnippet.rel.value == "choose..."){
		alert("you must say whether the evidence supports or opposes the claim");
	}else{
		submitForm('newsnippet','claimid',id)
	}
}

function submitForm(formid,fieldname,fieldval){
	var form = document.forms[formid];
	form[fieldname].value = fieldval;
	form.submit();		
}

function submitNewClaim(){
	if(document.forms.newsnippet.rel && document.forms.newsnippet.rel.value == "choose..."){
		alert("you must say whether the evidence supports or opposes the claim");
		return;
	}
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

function reportSpam(node,id){
	$(node).parent().append($("<span>reported as spam <a onclick='unreportSpam(this,"+id+")'>(undo)</a></span>"))
	$(node).remove()
	$.post(url_base+"claim/"+id+"/setspam")
}

function unreportSpam(node,id){	
	$(node).parent().parent().append($("<a onclick='reportSpam(this,"+id+")'>report spam</a>"))
	$(node).parent().remove()
	$.post(url_base+"claim/"+id+"/unsetspam")
}

function deleteClaim(node,id){  // can only be used by creator or admin
	if(confirm("Are you sure you want to delete this claim? This action cannot be undone.")){
		$(node).parent().remove();
		$.post(url_base+"claim/"+id+"/delete")
	}
	//alert("This claim has been deleted.\nTo undelete it, go to the list of deleted claims in your profile"); 
}

function reportSpamEvidence(node,id){
	$(node).parent().append($("<span>reported as spam</span>"))
	$(node).remove()
	$.post(url_base+"evidence/"+id+"/setspam")
}

function deleteEvidence(node,id){
	$(node).parent().append($("<span>reported as spam</span>"))
	if(confirm("Are you sure you want to permanently delete this evidence?")){
		$(node).parents(".webquote").remove();
		$.post(url_base+"evidence/"+id+"/delete");
	}
}

function notAgain(node,id){
	if(node.checked){
		$.post(url_base+"claim/"+id+"/ignore");
	}else{
		$.post(url_base+"claim/"+id+"/unignore");
	}
}

function voteUp(node,id,typ){
	var box = $(node).parent();
	var now = box.attr("class");
	if(now == "votebox-down"){
		box.attr("class","votebox-norm");
		$.post(url_base+typ+"/"+id+"/votenorm");
	}else{
		box.attr("class","votebox-up");
		$.post(url_base+typ+"/"+id+"/voteup");
	}	
}

function voteDown(node,id,typ){
	var box = $(node).parent();
	var now = box.attr("class");
	if(now == "votebox-up"){
		box.attr("class","votebox-norm");
		$.post(url_base+typ+"/"+id+"/votenorm");
	}else{
		box.attr("class","votebox-down");
		$.post(url_base+typ+"/"+id+"/votedown");
	}
}

function unmark(snipid){
	$.post(url_base+"api/badsnippet?snipid="+snipid,function(){
		window.location.href = url_base+"/mini/markedbad";
	});
}

var foo = null;

function setToggle(box,vote){
	var id = box.attr("data-id")
	var type = box.attr("data-type")
	var zone = box.attr("data-zone")
	if(type != null){
		$.post(url_base+zone+"/pick/?type="+type+"&id="+id+"&vote="+vote);
	}
}

function getUserId(){
	return $("#user-id").val();
}

function loggedIn(){
	return getUserId() != 0;
}

window.onload = function(){
	$(".tempinput").focus(function(e){
		var input = e.target;
		$(input).removeClass("tempinput");
		input.value = "";		
	})
	$(".yes").click(function(e){
		var box = $(e.target).parents(".togglebox");
		box.addClass("state-yes");
		box.removeClass("state-no");
		setToggle(box,"yes");
	})
	$(".no").click(function(e){
		var box = $(e.target).parents(".togglebox");
		box.addClass("state-no");
		box.removeClass("state-yes");
		setToggle(box,"no");
	})
	$(".clicksentence").click(function(e){
		if(!loggedIn()){
			alert("You need to be logged in to mark a snippet");
			return;
		}
		var target = $(e.target);
		var box = target.parents(".snippettext");
		var snippet = target.parents(".snippet");
		var snipid = snippet.find(".resultid").val();
		snippet.addClass("state-yes");
		snippet.removeClass("state-no");
		box.find(".clicksentence").css("background-color","");
		target.css("background-color","yellow");
		$.post(url_base+"snippet/"+snipid+"/sethighlight",{highlight:target.text()});
	})
}

