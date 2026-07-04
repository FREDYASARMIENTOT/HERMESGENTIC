function Initialize-HermesProviders {

    Write-Host ""
    Write-Host "Loading Providers..." -ForegroundColor Cyan

    $Providers = Get-HermesConfiguration "providers.json"

    $Global:Hermes.Providers=@{}

    foreach($Provider in $Providers.providers){

        $EnvValue=[Environment]::GetEnvironmentVariable(
            $Provider.env_var,
            "User"
        )

        if([string]::IsNullOrWhiteSpace($EnvValue)){

            $Enabled=$false

        }

        else{

            $Enabled=$true

        }

        $Global:Hermes.Providers[$Provider.name]=[PSCustomObject]@{

            Name=$Provider.name

            Model=$Provider.model

            Deployment=$Provider.deployment

            Endpoint=$Provider.base_url

            EnvironmentVariable=$Provider.env_var

            ApiKeyLoaded=$Enabled

            Priority=$Provider.priority

            Enabled=$Provider.enabled

        }

        if($Enabled){

            Write-Host ("[PASS] "+$Provider.name) -ForegroundColor Green

        }

        else{

            Write-Host ("[WARN] "+$Provider.name+" (API Key not found)") -ForegroundColor Yellow

        }

    }

}
