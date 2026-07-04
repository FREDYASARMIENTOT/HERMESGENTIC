Clear-Host

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host " Hermes Enterprise Tests"
Write-Host "==========================================" -ForegroundColor Cyan

$Tests = @(

    "src\Core",

    "config",

    "docs",

    "scripts"

)

$Failed = 0

foreach ($Test in $Tests) {

    if (Test-Path $Test) {

        Write-Host "[PASS] $Test"

    }

    else {

        Write-Host "[FAIL] $Test" -ForegroundColor Red

        $Failed++

    }

}

Write-Host ""

if ($Failed -eq 0) {

    Write-Host "All Tests Passed." -ForegroundColor Green

}
else {

    Write-Host "$Failed Tests Failed." -ForegroundColor Red

}
