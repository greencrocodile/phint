<?php
	
error_reporting(0);
date_default_timezone_set('Europe/Moscow');
setlocale(LC_ALL, 'ru_RU');

define('APP_NAME', 'PHINT');
define('APP_CHARSET', 'UTF-8');
define('SYSTEM_OEM_CHARSET', 'cp866');

mb_internal_encoding(APP_CHARSET);
define('LOGIN', "phint_user");
define('PASSWORD', "phint12345");
define('SERVER', "127.0.0.1:3306");
define('DATABASE', "phint");

$phint_db = mysqli_connect(SERVER, LOGIN, PASSWORD, DATABASE) or die_(__FILE__, __LINE__, 'Ошибка при подключении к БД');
mysqli_set_charset($db,'utf8');

//$REPORTS_TEMPLATES_PATH = 'D:/work/AS/Reports/templates/';
//$REPORTS_TMP_PATH = 'D:/work/AS/Reports/tmp/';
// $REPORTS_TEMPLATES_PATH = 'D:/users/vin/projects/AS/Reports/templates/';
// $REPORTS_TMP_PATH = 'D:/users/vin/projects/AS/Reports/tmp/';
$REPORTS_TEMPLATES_PATH = 'templates/';
$REPORTS_TMP_PATH = 'tmp/';
$DOC_TEMPLATE_NAME = 'doc00.xlsx';

function br2nl($str) {
    return str_replace('<br/>', "\n", $str);
}

function escape4js($str) {
    return str_replace('\'', '\\\'', str_replace('\\', '\\\\', str_replace(chr(0x0D), '', str_replace(chr(0x0A), '<br/>', $str))));
}

function escape4jsnobr($str) {
    return str_replace(chr(0x0D), '', str_replace(chr(0x0A), '\\n', str_replace('\'', '\\\'', str_replace('\\', '\\\\', $str))));
}

function mysqli_get_db_charset($stmt) {
    $query = "SELECT @@character_set_database;";
    $result = mysqli_query($stmt, $query) or die_(__FILE__, __LINE__, 'Ошибка при выполнении запроса: ' . "\n" . iconv(CHARSET, APP_CHARSET, $query) . "\n" . $phint_db->error);
    while ($row = mysqli_fetch_array($result, MYSQL_NUM)) {
        break;
    };
    return $row[0];
}

function Log_($msg) {
    $f = @fopen('logs/' . date('Y_m_d') . '.log', 'at');
    if ($f !== false) {
        fwrite($f, date('H:i:s') . ' host(' . (isset($_SERVER['REMOTE_ADDR']) ? $_SERVER['REMOTE_ADDR'] : 'console') . '): ' . $msg . "\n");
        fclose($f);
    }
}

function die_($file_name, $line, $message, $screen_message) {
    Log_('Произошла ошибка в файле ' . $file_name . ' на строке ' . $line . ': ' . $message . '');
    die($screen_message);
}