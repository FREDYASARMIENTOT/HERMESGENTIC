#-------------------------------------------------------
# Hermes Enterprise Framework
#-------------------------------------------------------

$ModuleRoot=$PSScriptRoot

Get-ChildItem `
"$ModuleRoot\Core\*.ps1" `
-ErrorAction SilentlyContinue |
ForEach-Object{

. $_.FullName

}

Export-ModuleMember -Function *
