$sourceDir = "c:\path\to\dir"
$searchPattern = ".*\(.*\).*"
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
    if ($testOnly) {
        Remove-Item $item.FullName -Recurse -Force -WhatIf
    }else {
        Remove-Item $item.FullName -Recurse -Force
    }
}

"Items deleted: " + $itemList.Count
