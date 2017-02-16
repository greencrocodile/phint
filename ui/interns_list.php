<?php

require('config.php');
header('Content-type: application/javascript; charset=utf-8');
if (isset($_REQUEST['callback'])) {
    $callback = $_REQUEST['callback'];
} else {
    $callback = '';
}

if (isset($_REQUEST['sort'])) {
    $sort = $_REQUEST['sort'];
} else {
    $sort = 'date_start';
}

if (isset($_REQUEST['dir'])) {
    $dir = $_REQUEST['dir'];
} else {
    $dir = 'DESC';
}
if (($dir != 'ASC') && ($dir != 'DESC')) {
    $dir = 'DESC';
}

if (isset($_REQUEST['start_id'])) {
    $start_id = $_REQUEST['start_id'];
} else {
    $start_id = '';
}

if ($start_id == '') {
    $start_id = -1;
} else {
    $start_id = intval($start_id);
}

if (isset($_REQUEST['id'])) {
    $id = $_REQUEST['id'];
} else {
    $id = '-1';
}

$id = intval($id);

if (isset($_REQUEST['active_only'])) {
    $active_only = $_REQUEST['active_only'];
} else {
    $active_only = '0';
}

$active_only = intval($active_only);

if (isset($_REQUEST['firstname'])) {
    $firstname = $_REQUEST['firstname'];
} else {
    $firstname = '';
}

if (isset($_REQUEST['middlename'])) {
    $middlename = $_REQUEST['middlename'];
} else {
    $middlename = '';
}

if (isset($_REQUEST['lastname'])) {
    $lastname = $_REQUEST['lastname'];
} else {
    $lastname = '';
}

if (isset($_REQUEST['page'])) {
    $page = intval($_REQUEST['page']);
}

if (isset($_REQUEST['start'])) {
    $start = intval($_REQUEST['start']);
}

if (isset($_REQUEST['limit'])) {
    $limit = intval($_REQUEST['limit']);
}

//---------------------------------------
$offset = ($page - 1) * $limit;
$query = 'SELECT id,firstname,middlename,lastname,birthdate_text,active FROM v_interns where id >= 0 ';
if($id != -1){
	$query .= ' and id = '.$id;
} else {
	if ($active_only == 1){
		$query .= ' and active = 1 ';
	}
}
if ($firstname != ''){
	$query .= ' and firstname like \'%'.$firstname.'%\'';
}

if ($middlename != ''){
	$query .= ' and middlename like \'%'.$middlename.'%\'';
}

if ($lastname != ''){
	$query .= ' and lastname like \'%'.$lastname.'%\'';
}

	
$query .= ' order by ' . $sort . ' ' . $dir . ' limit ' . $limit . ' offset ' . $offset;
$result = $phint_db->query($query) or die_(__FILE__, __LINE__, 'Ошибка при выполнении запроса: ' . "\n" . $query . "\n" . $db->error, $db->error);
$d = '';
while ($arr = $result->fetch_assoc()) {
    $d.=',{
\'id\':' . intval($arr['id']) . ',
\'lastname\': \'' . escape4js($arr['lastname']) . '\',
\'firstname\': \'' . escape4js($arr['firstname']) . '\',
\'middlename\': \'' . escape4js($arr['middlename']) . '\',
\'birthdate\': ' . (($arr['birthdate_text'] == '') ? 'null' : 'new Date(\'' . escape4js($arr['birthdate_text']) . '\')') . ',
\'active\':' . intval($arr['active']) . '
}';
}
$result->free_result();

if ($start_id == -1) {
    $d=',{
\'id\':-1,
\'lastname\': \'-----\',
\'firstname\' \'\',
\'middlename\': \'\',
\'birthdate\': \'\',
\'active\':1
		}'.$d;
}
if ($d != '') {
    $d = mb_substr($d, 1);
}
$query = 'SELECT count(*) AS Total FROM v_interns where id >= 0 ';
if($id != -1){
	$query .= ' and id = '.$id;
} else {
	if ($active_only == 1){
		$query .= ' and active = 1 ';
	}
}
if ($firstname != ''){
	$query .= ' and firstname like \'%'.$firstname.'%\'';
}

if ($middlename != ''){
	$query .= ' and middlename like \'%'.$middlename.'%\'';
}

if ($lastname != ''){
	$query .= ' and lastname like \'%'.$lastname.'%\'';
}

$result = $phint_db->query($query) or die_(__FILE__, __LINE__, 'Ошибка при выполнении запроса: ' . "\n" . $query . "\n" . $db->error, $db->error);
$total = 0;
while ($arr = $result->fetch_assoc()) {
    $total = intval($arr['Total']);
    break;
}
$result->free_result();

echo $callback . '({\'total\': ' . $total . ',\'list\':[' . $d . ']});';
