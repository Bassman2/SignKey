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
    [string]$file
    [string]$key
    [string]$bin
	)

echo "start file: $file"

if ( [string]::IsNullOrEmpty($key) )
{
    echo "no key"	
}

if ( [string]::IsNullOrEmpty($bin) )
{
    echo "no bin"	
}

$signing_keys_payload = [System.Convert]::FromBase64String($key)
$currentDirectory = Get-Location
echo "currentDirectory $currentDirectory"		
$certificatePath = Join-Path -Path $currentDirectory -ChildPath $file
echo "certificatePath $certificatePath"		
[IO.File]::WriteAllBytes("$certificatePath", $signing_keys_payload)

# fallback to DummySignKey.snk for forks without secrets.SIGNKEY defined
if ( [string]::IsNullOrEmpty($signing_keys_payload) )
{
    echo "no payload"	
}
echo "ready"