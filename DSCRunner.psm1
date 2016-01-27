# Checking for module cache;
if (-not (test-path variable:\DSCRunner))
{
    $Script:DSCRunner = @{};
}


Function Sync-ConfigurationData {
    [cmdletbinding()]
    param(
        $json
    )
    
    try {
        $Script:DSCRunner.add("ConfigurationModules", $json.DSCRunner.ConfigurationModules)
        $Script:DSCRunner.add("RequiredModules", $json.DSCRunner.RequiredModules)
        $Script:DSCRunner.add("ComputerNames", $json.DSCRunner.ComputerNames)
        Write-Verbose "Loaded Config Data from Launch.json."
    }
    catch {
        
        Write-Verbose "Configuration already loaded."
    }
}

Function Start-ConfigurationFactory {
    [cmdletbinding()]
    param(
        
    )
    
    
        ForEach ($mod in $Script:DSCRunner["ConfigurationModules"])
    {
        
        try {
            Write-Verbose "Importing module $mod."
            Import-Module $PSScriptRoot\Configurations\$mod
        
            Write-Verbose "Obtaining configuration details."
            # This will need improvements, two dots will ruin break it.
            $ModuleName = $mod -replace "(?>\.).+" , ""
            $Config = Get-Command -Module $ModuleName | Where-Object {$_.CommandType -like "Configuration"}

            $Config | ForEach-Object {
                $cmd = $_.Name

                try {
                    Write-Verbose "Executing configuration command."
                    & $cmd 
                    Write-Debug -Message "blah" 
                }
                catch {
                    Write-Error -Message "$cmd failed to run, from $ModuleName."
                    Write-Debug -Message "$_"

                }
            }
        
        }
        catch {
            
            Write-Error -Message "$mod failed to run."
            $_
        }
        
        
    }
    
    
    
}