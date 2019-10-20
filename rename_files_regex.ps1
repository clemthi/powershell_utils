$sourceDir = "c:\path\to\dir"
$searchPattern = ".*\(.*\).*"
$replacePattern = " \(.*\)"
$replacePatternBy = ""

$fileList = Get-ChildItem  -Path $sourceDir -Recurse -Force | Where-Object {! $_.PSIsContainer -AND ($_.Name -Match $searchPattern) }

foreach($file in $fileList)
{
    $filepath = Split-Path -Path $file.FullName
    $newfilename = $filepath + "\" + ($file.Name -Replace $replacePattern, $replacePatternBy)
    Rename-Item $file.FullName $newfilename
}

"Files renamed: " + $fileList.Count