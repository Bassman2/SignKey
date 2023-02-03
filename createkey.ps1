<#
    .SYNOPSIS
    Creates a sign key file from secret
    .DESCRIPTION
    Creates a sign key file from secret
    .PARAMETER file
    Name of the key file to generate
    .NOTES
    Written by Ralf Beckers
#>

param(
    [parameter(Mandatory = $true)]
    [string]$file,
    [string]$key,
	[string]$actionpath
	)

echo "start file: $file"
echo "start actionpath: $actionpath"

if ( [string]::IsNullOrEmpty($key) )
{
    echo "no key"	
}

$signing_keys_payload = [System.Convert]::FromBase64String($key)
$currentDirectory = Get-Location
echo "currentDirectory $currentDirectory"		
$certificatePath = Join-Path -Path $currentDirectory -ChildPath $file
echo "certificatePath $certificatePath"		
[IO.File]::WriteAllBytes("$certificatePath", $signing_keys_payload)

echo "x0"

# fallback to DummySignKey.snk for forks without secrets.SIGNKEY defined
if ( [string]::IsNullOrEmpty($signing_keys_payload) )
{
    echo "no payload"	
}


echo "x1"

if ( [File]::Exists("$certificatePath") )
{
	echo "file exists";
}

echo "x2"

$dummyPath = Join-Path -Path $actionpath -ChildPath "Dummy.snk"


echo "dummyPath $dummyPath";

if ( [File]::Exists("$dummyPath") )
{
	echo "dummy file exists";
	
	Copy-Item $dummyPath -Destination "Dummy.snk"
}

echo "ready"