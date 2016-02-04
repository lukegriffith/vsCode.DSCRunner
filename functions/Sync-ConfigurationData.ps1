Function Sync-ConfigurationData {
    [cmdletbinding()]
    param(
        $json
    )
    
    try {
        $Script:DSCRunner.add("Configurations", $json.DSCRunner.Configurations)
        $Script:DSCRunner.add("RequiredModules", $json.DSCRunner.RequiredModules)
        $Script:DSCRunner.add("ComputerNames", $json.DSCRunner.ComputerNames)
        Write-Verbose "Loaded Config Data from Launch.json."
    }
    catch {
        
        Write-Verbose "Configuration already loaded."
    }
}