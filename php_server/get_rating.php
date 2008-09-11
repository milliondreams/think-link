//  Copyright 2008 Intel Corporation
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

<?php

require_once 'common.php';

$snipid = getarg("snippet_id");
$pointid = getarg("point_id");

$query = "SELECT SUM(temp.rating)/COUNT(temp.rating) as ratings FROM (SELECT rating FROM `ratings` WHERE snippet_id=$snipid AND point_id=$pointid) as temp";

json_out(sql_to_array($query));
?>