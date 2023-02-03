<#
    .SYNOPSIS
    This script generates a password
    .DESCRIPTION
    A password is generated that contains at least one  non-capital, one capital, one number and one special character.
    It will than removes the similar characters (like I & l)
    .PARAMETER length
    The length of the password
    .NOTES
    Written by Barbara Forbes
    @Ba4bes
    https://4bes.nl

param(
    [parameter(Mandatory = $true)]
    [string]$file
)

$signing_keys_payload = [System.Convert]::FromBase64String("${{ secrets.SIGNKEY }}")
$currentDirectory = Get-Location
$certificatePath = Join-Path -Path $currentDirectory -ChildPath $file
[IO.File]::WriteAllBytes("$certificatePath", $signing_keys_payload)

# Return password to workflow
echo "$signing_keys_payload"
echo "$currentDirectory"
echo "$certificatePath"
    #>

param(
    [parameter(Mandatory = $true)]
    [string]$file

echo "Hello world $file"
