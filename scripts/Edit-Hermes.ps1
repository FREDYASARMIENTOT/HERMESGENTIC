param(
    [Parameter(Mandatory)]
    [string]$File
)

$Path = Resolve-Path $File

code $Path