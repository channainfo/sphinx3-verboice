<?php 
 
 #TODO need to handle error later on
 $error = "" ;
 $filename = $argv[1];
 $content = file_get_contents($filename);

 $lines =  explode("\n", $content);
 
 $skip = 6;
 $limit = count($lines)-2; // count($lines)
 $results = array();
 
 $k = 1 ;
 for($i=$skip; $i< $limit; $i++ ) {
 	$results[] = parse_line($lines[$i]);
    $k++;
    if($k >3)
      break;
 }

#convert the confidence result into percentage
$total=0;
$arrlength=count($results);

for($x=0;$x<$arrlength;$x++) { 
	$total+=$results[$x]['confidence'];
}

for($x=0;$x<$arrlength;$x++) {
	$results[$x]['confidence'] = number_format(1-($results[$x]['confidence']/$total),3)*100;
}
 
echo json_encode(array("results" => $results, "errors" => $error));

function parse_line($line) {
 	$items = explode(" ", $line);
    $result = $items[17] ;
    $index = 17;
    while($result == "<sil>") {
    	if($index < count($items) ) {
	    	$index = $index + 4;
	    	$result = $items[$index];
    	}
    	else
    		break;
    }
 	return array("result" => $result , "confidence" => $items[3]);
 }

 function translate_result($result){
 	return $result;
 }

