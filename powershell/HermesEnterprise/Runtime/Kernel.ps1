#==============================================================
# Kernel.ps1
# Hermes Enterprise Kernel
#==============================================================

$Global:Hermes = [ordered]@{

    Version = "2.0"

    Runtime = "Enterprise"

    Started = $false

    Environment = @{}

    Providers = @{}

    Profiles = @{}

}

function Initialize-HermesKernel {

    $Global:Hermes.Started = $true

    $Global:Hermes.Environment = @{

        Computer = $env:COMPUTERNAME

        User = $env:USERNAME

        PowerShell = $PSVersionTable.PSVersion.ToString()

        OS = (Get-CimInstance Win32_OperatingSystem).Caption

        Date = Get-Date

    }

}

