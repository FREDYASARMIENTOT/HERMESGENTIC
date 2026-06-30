Clear-Host

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host " Hermes Enterprise Doctor"
Write-Host "==========================================" -ForegroundColor Cyan

$Commands = @(

    "git",

    "python",

    "pwsh",

    "hermes",

    "az"

)

foreach ($Cmd in $Commands) {

    if (Get-Command $Cmd -ErrorAction SilentlyContinue) {

        Write-Host "[PASS] $Cmd"

    }

    else {

        Write-Host "[FAIL] $Cmd" -ForegroundColor Red

    }

}