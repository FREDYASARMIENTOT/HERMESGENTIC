#==========================================================
# Initialize-HermesEnterprise.ps1
#
# Bootstrap del proyecto Hermes Enterprise
#
# Puede ejecutarse múltiples veces.
#==========================================================

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host " Hermes Enterprise Bootstrap"
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$Folders = @(

    "config",

    "examples",

    "assets",

    "logs",

    "docs",

    "tests",

    "scripts",

    "powershell",

    "docker",

    "terraform",

    "src\Core",

    "src\Runtime",

    "src\Providers",

    "src\Profiles",

    "src\Router",

    "src\Agents",

    "src\Memory",

    "src\Diagnostics",

    "src\FinOps",

    "src\Installer",

    "src\VSCode",

    "src\Integrations",

    "src\Integrations\Azure",

    "src\Integrations\Azure\Workbooks",

    "src\Integrations\Gateway",

    "src\Integrations\PowerBI",

    "src\Integrations\Telegram",

    "src\Integrations\Fabric"

)

foreach ($Folder in $Folders) {

    New-Item `
        -ItemType Directory `
        -Force `
        -Path $Folder | Out-Null

}

Write-Host "[OK] Carpetas creadas" -ForegroundColor Green

$Files = @(

    ".gitignore",

    "LICENSE",

    "CHANGELOG.md",

    "config\providers.json",

    "config\profiles.json",

    "config\routing.json",

    "config\pricing.json",

    "config\settings.json",

    "docs\ARCHITECTURE.md",

    "docs\ROADMAP.md",

    "docs\INSTALL.md",

    "docs\FINOPS.md",

    "docs\PROVIDERS.md",

    "docs\MEMORY.md"

)

foreach ($File in $Files) {

    if (!(Test-Path $File)) {

        New-Item `
            -ItemType File `
            -Path $File | Out-Null

    }

}

Write-Host "[OK] Archivos base creados" -ForegroundColor Green

Write-Host ""
tree /F