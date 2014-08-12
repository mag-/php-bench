<?php
function match($desk, $word) {
    if($desk == "") return false;
    if($word == "") return true;

    $w = substr($word, 0, 1);
    $ws = substr($word, 1);

    $pos = strpos($desk, $w);
    if($pos !== false) {
        $desk = substr($desk, 0, $pos).substr($desk, $pos + 1);
        return match($desk, $ws);
    }

    $pos = strpos($desk, '*');
    if($pos !== false) {
        $desk = substr($desk, 0, $pos).substr($desk, $pos + 1);
        return match($desk, $ws);
    }

    return false;
}

function search($tokens, $dictionary) {
    $filter = function($word) use($tokens) { return match($tokens, $word); };

    return array_filter($dictionary, $filter);
}

function prettyPrint($words) {
    $compareLength = function($a, $b) { return strlen($a) - strlen($b); };

    usort($words, $compareLength);
    print(implode("\n", $words)."\n");
}

if(isset($argv[1])) {
    $firstArg = $argv[1];
} else {
    exit("One parameter needed");
}

$dictionary = explode("\n", file_get_contents("ODS6.txt"));

$results = search(strtoupper($firstArg), $dictionary);

prettyPrint($results);

