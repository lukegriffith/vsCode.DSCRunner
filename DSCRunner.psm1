# Checking for module cache;
if (-not (test-path variable:\DSCRunner))
{
    ${DSCRunner} = @{};
}


Function Sync-ConfigurationData {
    [cmdletbinding()]
    param(
        $json
    )
    
    ${GLOBAL:DSCRunner}.add("ConfigurationModules", $json.ConfigurationModules)
    ${GLOBAL:DSCRunner}.add("CompileModules", $json.ResourceModules)
    ${GLOBAL:DSCRunner}.add("ComputerNames", $json.ComputerNames)
    Write-Verbose "Loaded Config Data from Launch.json"
}

Function Start-RunnerConfiguration {
    
    param(
        
    )
    
    
    ForEach ($mod in $DSCRunner["ConfigurationModules"])
    {
        
        try {
            Import-Module $PSScriptRoot\Configurations\$mod
        
        
            # This will need improvements, two dots will ruin break it.
            $ModuleName = $mod -replace "(?>\.).+" , ""
            $Config = Get-Command $ModuleName | Where-Object {$_.CommandType -like "Configuration"}

            $Config | ForEach-Object {
            $cmd = $_.Name

            & $cmd 
            }
        
        }
        catch {
            
            Write-Error -Message "$mod failed to run"
            $_
        }
        
        
    }
    
    
    
}