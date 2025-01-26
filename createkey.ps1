<#
    .SYNOPSIS
    Creates a sign key file from secret
    .DESCRIPTION
    Creates a sign key file from secret
    .PARAMETER file
    Name of the key file to generate
    .PARAMETER key
    base64 encoded key file
    .NOTES
    Written by Ralf Beckers
#>

$file = $args[0]
$key = $args[1]
$currentDirectory = Get-Location
$certificatePath = Join-Path -Path $currentDirectory -ChildPath $file
	
if ( [string]::IsNullOrEmpty($key) )
{
    echo "No key available!!! Use dummy key."	
	
	$dummyPath = Join-Path -Path $PSScriptRoot -ChildPath "Dummy.snk"
	Copy-Item $dummyPath -Destination $certificatePath
}
else
{
	$signing_keys_payload = [System.Convert]::FromBase64String($key)
	[IO.File]::WriteAllBytes("$certificatePath", $signing_keys_payload)
}

$listcs = Get-ChildItem -Path $currentDirectory -Include *.csproj -Recurse
ForEach ($prj in $listcs ) 
{
	$pa = [IO.Path]::GetDirectoryName($prj)
	$to = Join-Path -Path $pa -ChildPath $file
	
	Copy-Item $certificatePath -Destination $to
	
    echo "$to"
}

$listvb = Get-ChildItem -Path $currentDirectory -Include *.vbproj -Recurse
ForEach ($prj in $listvb ) 
{
	$pa = [IO.Path]::GetDirectoryName($prj)
	$to = Join-Path -Path $pa -ChildPath $file
	
	Copy-Item $certificatePath -Destination $to
	
    echo "to"
}
