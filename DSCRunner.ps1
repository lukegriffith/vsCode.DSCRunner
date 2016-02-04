#$VerbosePreference = 'Continue'

<#
Start-Configuration 

# Process starts, takes configurations specified.
HAS TO:
-  Import Modules.
-  Provide $nodedata. 
-  Compile Mof.
-  Execute MOF's on localhost or defined endpoint.

Limitations:
This is a testing framework, do not venture above.

Potentil:
Add pester into the mix. 

#>

# Setting Environment
$env:PSModulePath = $env:PSModulePath + ";$PSScriptRoot\RequiredModules;$PSScriptRoot\Configurations;"
$VerbosePreference = 'Continue'
# testing parameters
$tpa = @{}
#$tpa.add("Verbose",$true)

set-location $PSScriptRoot\Execution
# Importing Module

Write-Verbose "======================================="
Write-Verbose "Sanitizing environment."
Write-Verbose "======================================="

Remove-Module $PSScriptRoot\DSCRunner.psm1 -ea SilentlyContinue
<<<<<<< HEAD
=======
Remove-Module $PSScriptRoot\vsCodeUtil.psm1 -ea SilentlyContinue
>>>>>>> 674689179d00842a460bacfc818108713befddf2

Write-Verbose "======================================="
Write-Verbose "Importing dependencies."
Write-Verbose "======================================="

Import-Module $PSScriptRoot\DSCRunner.psm1

Write-Verbose "======================================="
Write-Verbose "Syncing configuration data."
Write-Verbose "======================================="

Write-Verbose "======================================="
Write-Verbose "Syncing configuration data."
Write-Verbose "======================================="

Sync-ConfigurationData ( Get-LaunchJson ) @tpa


Write-Verbose "======================================="
Write-Verbose "Executing configurations."
Write-Verbose "======================================="

Start-ConfigurationFactory @tpa
<<<<<<< HEAD

=======
>>>>>>> 674689179d00842a460bacfc818108713befddf2
