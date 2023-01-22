<?php
$request_method = strtoupper($_SERVER['REQUEST_METHOD']);
if(isset($_GET["name"])){
    $myfile = fopen("testfile.txt", "r") or die("Unable to open file!");
    echo fread($myfile,filesize("testfile.txt"));
    fclose($myfile);
    return;
}
echo '<!DOCTYPE html>';
echo '<html lang="en">';
echo '<head>';
echo '<meta charset="UTF-8">';
echo '<title>Document</title>';
echo '</head>';
echo '<body>';
echo '<form action="index.php" method="post">';
echo '<button type="submit">Turn ON</button>';
echo '</form>';
echo '<form action="index.php" method="get">';
echo '<button type="submit">Turn OFF</button>';
echo '</form>';
echo '</body>';
echo '</html>';
if ($request_method === 'GET') {
    $myfile = fopen("testfile.txt", "w") or die("Unable to open file!");
    fwrite($myfile, "off");
    fclose($myfile);
} else {
	$myfile = fopen("testfile.txt", "w") or die("Unable to open file!");
fwrite($myfile, "on");
fclose($myfile);
}
?>