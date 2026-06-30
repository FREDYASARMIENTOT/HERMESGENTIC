function Start-HermesEnterprise {

    Initialize-HermesKernel

    Write-Host ""
    Write-Host "======================================" -ForegroundColor Cyan
    Write-Host " Hermes Enterprise Started" -ForegroundColor Green
    Write-Host "======================================" -ForegroundColor Cyan
    Write-Host ""

    $Global:Hermes.Environment

}
