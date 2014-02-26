<?php 
 
 #TODO need to handle error later on
 $error = "" ;
 $filename = $argv[1];
 $content = file_get_contents($filename);

 $lines =  explode("\n", $content);
 
 $skip = 6;

 $results = array();
 for($i=$skip; $n= count($lines), $i< $n-2; $i++ ) {
 	$results[] = parse_line($lines[$i]);
 }
 
 echo json_encode(array("results" => $results, "errors" => $error));


 function parse_line($line) {
 	$items = explode(" ", $line);
 	return array("result" => $items[17], "confidence" => $items[3]);
 }

