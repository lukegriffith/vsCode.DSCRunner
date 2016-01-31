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
        $Script:DSCRunner.add("CompileModules", $json.DSCRunner.ResourceModules)
        $Script:DSCRunner.add("ComputerNames", $json.DSCRunner.ComputerNames)
        Write-Verbose "Loaded Config Data from Launch.json."
    }
    catch {
        
        Write-Verbose "Configuration already loaded."
    }
}

Function Start-RunnerConfiguration {
    [cmdletbinding()]
    param(
        
    )
    
    
        ForEach ($mod in $Script:DSCRunner["ConfigurationModules"])
    {
        
        try {
            Write-Verbose "Importing module $mod."
            . $PSScriptRoot\Configurations\$mod
        
            Write-Verbose "Obtaining configuration details."
            # This will need improvements, two dots will ruin break it.
            $ModuleName = $mod -replace "(?>\.).+" , ""
            $Config = Get-Command -Module $ModuleName | Where-Object {$_.CommandType -like "Configuration"}

            $Config | ForEach-Object {
                $cmd = $_.Name

                $sb = { 

                    Import-Module $PSScriptRoot\Configurations\$mod
                    $Config = Get-Command -Module $ModuleName | Where-Object {$_.CommandType -like "Configuration"}
                    & $cmd
                }
                
                Write-Verbose "Executing configuration command."
                & $cmd 
                Invoke-Command -ScriptBlock $sb

                Write-Debug -Message "blah"
            }
        
        }
        catch {
            
            Write-Error -Message "$mod failed to run."
            $_
        }
        
        
    }
    
    
    
}