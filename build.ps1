Clear-Host

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host " Hermes Enterprise Build"
Write-Host "==========================================" -ForegroundColor Cyan

$BuildModules = @(

    "src\Core",

    "src\Runtime",

    "src\Providers",

    "src\Profiles",

    "src\Router",

    "src\Agents",

    "src\Memory",

    "src\Diagnostics",

    "src\FinOps",

    "src\Integrations"

)

foreach ($Module in $BuildModules) {

    if (Test-Path $Module) {

        Write-Host "[PASS] $Module"

    }

    else {

        Write-Host "[FAIL] $Module" -ForegroundColor Red

    }

}