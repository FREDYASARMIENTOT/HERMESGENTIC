#==============================================================
# Hermes Enterprise Loader
#==============================================================

Set-StrictMode -Version Latest

$LoadOrder=@(

"Configuration",

"Core",

"Logging",

"Providers",

"Profiles",

"Router",

"Memory",

"Runtime",

"Diagnostics",

"FinOps",

"Integrations",

"VSCode",

"Git",

"Utils"

)

$Excluded=@(

"Loader.ps1",

"Bootstrap.ps1"

)

Write-Host ""
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "Loading Hermes Enterprise Runtime" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""

foreach($Folder in $LoadOrder){

    $FolderPath=Join-Path $Script:HermesModuleRoot $Folder

    if(!(Test-Path $FolderPath)){
        continue
    }

    Get-ChildItem `
        $FolderPath `
        -Filter *.ps1 `
        -File |

    Where-Object{

        $_.Name -notin $Excluded

    } |

    Sort-Object Name |

    ForEach-Object{

        try{

            . $_.FullName

            Write-Host ("[OK] "+$_.BaseName) -ForegroundColor Green

        }

        catch{

            Write-Host ("[FAIL] "+$_.BaseName) -ForegroundColor Red

            Write-Host $_.Exception.Message -ForegroundColor Yellow

            throw

        }

    }

}

Write-Host ""
Write-Host "Hermes Runtime Ready." -ForegroundColor Green

