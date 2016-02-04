# Checking for module cache;
if (-not (test-path variable:\DSCRunner))
{
    $Script:DSCRunner = @{};
}

<<<<<<< HEAD
Get-ChildItem $PSScriptRoot\Functions | ForEach-Object {
    . $_.FullName
=======

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

Function Start-ConfigurationFactory {
    [cmdletbinding()]
    param(
        
    )
        
        Write-Verbose "Importing configurations."
        Import-Module $PSScriptRoot\Configurations
    
        $Script:DSCRunner["Configurations"] | ForEach-Object -Begin {
            

            
            try {
                    
                Write-Verbose "Imported required modules for config."
                $Script:DSCRunner["RequiredModules"] | ForEach-Object {
                    Try {
                        Write-Verbose "Importing Module $_"
                        Import-Module $_
                    } catch {
                        Write-Error "Failed to import $m_"
                    }
                }
            # Potentially, you could keep an instance of the imported module in memory to call back later.
            # Invoke in the Module runspace might be beneficial for debug extraction info. 
            
                    
                    
            } catch {
                    
                Write-Error "Unable to get RequiredModules from DSCRunner cache."
            }
            
                

        } -Process {
        
        $CommandName = $_
        
        try {        
            Write-Verbose "Obtaining configuration details."
            # This will need improvements, two dots will ruin break it.
            
            try {
                $Config = Get-Command $CommandName -ErrorAction Stop | Where-Object {$_.CommandType -like "Configuration"}
            }
            catch {
                
                Write-Error "Unable to find configuration command."
            }
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
>>>>>>> 674689179d00842a460bacfc818108713befddf2
}