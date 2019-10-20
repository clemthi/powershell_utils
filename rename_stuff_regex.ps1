$sourceDir = "c:\path\to\dir"
$searchPattern = ".*\(.*\).*"
$replacePattern = " \(.*\)" # pattern of the name to be replaced
$replacePatternBy = ""
$folderOnly = $false # folder or file, not both
$testOnly = $false

$itemList = Get-ChildItem -Path $sourceDir -Recurse -Force | Where-Object { ($_.Name -Match $searchPattern) }
if ($folderOnly) {
    $itemList = $itemList.Where{ ($_.PSIsContainer) }
}
else {
    $itemList = $itemList.Where{ (! $_.PSIsContainer) }
}

foreach ($item in $itemList) {
    $itemPath = Split-Path -Path $item.FullName
    $newItemFullName = $itemPath + "\" + ($item.Name -Replace $replacePattern, $replacePatternBy)
    if ($testOnly) {
        Rename-Item $item.FullName $newItemFullName -WhatIf
    }else {
        Rename-Item $item.FullName $newItemFullName
    }
}

"Items renamed: " + $itemList.Count