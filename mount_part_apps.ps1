# drive letter to mount the partition on
$TcDrive = "o"

#path to the TrueCrypt/VeraCrypt file
$TcFile = "c:\path\to\file.tc"

# list of apps to start after the partition is mounted
$AppList = @("C:\Program Files (x86)\Dropbox\Client\Dropbox.exe","O:\PortableApps\start.exe")

# path to TrueCrypt/VeraCrypt
$TcPath = "C:\Program Files\TrueCrypt\TrueCrypt.exe"
# $TcPath = "C:\Program Files\VeraCrypt\VeraCrypt.exe"

# TrueCrypt/VeraCrypt arguments
$TcOpt = " /v %tcfile /l%drive /a /q background /p %password"
# $TcOpt = " /tc /v %tcfile /l %drive /nowaitdlg y /a /s /h n /p %password /q background"

# sleep timer before loading apps after partition is mounted
$TcTimer = 2

$TcLoaded = $false

while(-not $TcLoaded)
{
	$Password = Read-Host -Prompt 'Password: '
	
	Clear-Host
	
	$TcArg = $TcOpt.Replace("%tcfile", $TcFile).Replace("%drive", $TcDrive).Replace("%password", $Password)
	
    $TcPrms = $($TcArg).Split(" ")
    & $TcPath $TcPrms
	
	Start-Sleep $TcTimer
	# Write-Host -NoNewLine "Press any key to continue ..."
	# $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

	$DriveletterExists = Test-Path -Path $TcDrive':'
	if ($DriveletterExists)
	{
		foreach ($App in $AppList)
        {
            & $App 
        }
		$TcLoaded = $true
	}
}