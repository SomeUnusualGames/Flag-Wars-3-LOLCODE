<?php
declare(strict_types=1);

define('DIR', 'src');

// Main entry point
define('MAIN', DIR . '/main.lol');

// Where to join the .lol files
define('OUTPUT_PATH', 'main.lol');

// LOLCODE compiler
define('LCI', 'lci');

// Regex to import files
define('INCLUDE_RE', '/BTW INCLUDE \"(.+)\" PLS/');

// To execute the code right after creating it.
// Note that there won't be any output until the program ends.
define('EXECUTE', 1);

function addImports(array $mainContents): array
{
	$newContent = [];
	foreach ($mainContents as $i => $line) {
		$result = [];
		$matchFound = preg_match(INCLUDE_RE, $line, $result);
		if ($matchFound == 1) {
			$file = explode("\n", file_get_contents(DIR . "/" . $result[1]));
			$content = addImports($file);
			$newContent = array_merge($newContent, $content);
		} else {
			$newContent[] = $line;
		}
	}
	return $newContent;
}


function main()
{
	$mainContents = explode("\n", file_get_contents(MAIN));
	if (count($mainContents) <= 1) {
		die("Main file is empty\n");
	}
	if (!file_exists(OUTPUT_PATH)) {
		$tmp = fopen(OUTPUT_PATH, 'w');
		fclose($tmp);
	}
	$mainContents = addImports($mainContents);
	file_put_contents(OUTPUT_PATH, implode("\n", $mainContents));
	if (EXECUTE == 1) {
		system(sprintf("%s %s", LCI, OUTPUT_PATH));
	}
}

main();