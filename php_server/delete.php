<?php

require_once 'common.php';

$email = $HTTP_COOKIE_VARS["username"]; 
$pass = $HTTP_COOKIE_VARS["password"];
if(!$email){
	$email = postarg("username");
	$pass = postarg("password");
}
// check user and password
$user = getUser($email,$pass);

$cls = postarg("cls");
$id = postarg("id");

if($cls == "Topic"){
	$oldrow = sql_to_array("SELECT * FROM topics WHERE id = '$id';");
	$data = json_encode($oldrow);
	sql_query("INSERT INTO history (user_id,table_name,logaction,row_id,json_data) VALUES ($user,'topics','remove','$id','$data');");
	sql_query("DELETE FROM topics WHERE id = '$id';");
	
	$oldlinks = sql_to_array("SELECT * FROM topic_links WHERE parent_id = '$id' OR child_id = '$id' ;");
	$data = json_encode($oldlinks);
	sql_query("INSERT INTO history (user_id,table_name,logaction,row_id,json_data) VALUES ($user,'topics-topic_links','unlink','$id','$data');");
	sql_query("DELETE FROM topic_links WHERE parent_id = '$id' OR child_id = '$id';");

	$oldlinks = sql_to_array("SELECT * FROM point_topics WHERE topic_id = '$id';");
	$data = json_encode($oldlinks);
	sql_query("INSERT INTO history (user_id,table_name,logaction,row_id,json_data) VALUES ($user,'topics-point_topics','unlink','$id','$data');");
	sql_query("DELETE FROM point_topics WHERE topic_id = '$id';");

}else if($cls == "Point"){
	$oldrow = sql_to_array("SELECT * FROM points WHERE id = '$id';");
	$data = json_encode($oldrow);
	sql_query("INSERT INTO history (user_id,table_name,logaction,row_id,json_data) VALUES ($user,'points','remove','$id','$data');");
	sql_query("DELETE FROM points WHERE id = '$id';");
	
	$oldlinks = sql_to_array("SELECT * FROM point_links WHERE point_a_id = '$id' OR point_b_id = '$id' ;");
	$data = json_encode($oldlinks);
	sql_query("INSERT INTO history (user_id,table_name,logaction,row_id,json_data) VALUES ($user,'points-point_links','unlink','$id','$data');");
	sql_query("DELETE FROM point_links_links WHERE point_a_id = '$id' OR point_b_id = '$id';");

	$oldlinks = sql_to_array("SELECT * FROM point_topics WHERE point_id = '$id';");
	$data = json_encode($oldlinks);
	sql_query("INSERT INTO history (user_id,table_name,logaction,row_id,json_data) VALUES ($user,'points-point_topics','unlink','$id','$data');");
	sql_query("DELETE FROM point_topics WHERE point_id = '$id';");
	
	$oldlinks = sql_to_array("SELECT * FROM point_topics WHERE point_id = '$id';");
	$data = json_encode($oldlinks);
	sql_query("INSERT INTO history (user_id,table_name,logaction,row_id,json_data) VALUES ($user,'points-point_topics','unlink','$id','$data');");
	sql_query("DELETE FROM point_topics WHERE point_id = '$id';");
	
	$oldlinks = sql_to_array("SELECT * FROM snippets WHERE point_id = '$id';");
	$data = json_encode($oldlinks);
	sql_query("INSERT INTO history (user_id,table_name,logaction,row_id,json_data) VALUES ($user,'points-snippets','unlink','$id','$data');");
	sql_query("DELETE FROM snippets WHERE point_id = '$id';");
}

echo "\n";

json_out($id);

?>
