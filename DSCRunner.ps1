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
$env:PSModulePath = $env:PSModulePath + ";$PSScriptRoot\ResourceModules"
$VerbosePreference = 'Continue'
# testing parameters
$tpa = @{}
#$tpa.add("Verbose",$true)


# Importing Module

Write-Verbose "======================================="
Write-Verbose "Sanitizing environment."
Write-Verbose "======================================="

Remove-Module $PSScriptRoot\DSCRunner.psm1 -ea SilentlyContinue
Remove-Module $PSScriptRoot\vsCodeUtil.psm1 -ea SilentlyContinue

Write-Verbose "======================================="
Write-Verbose "Importing dependencies."
Write-Verbose "======================================="

Import-Module $PSScriptRoot\DSCRunner.psm1
Import-Module $PSScriptRoot\vsCodeUtil.psm1

Write-Verbose "======================================="
Write-Verbose "Syncing configuration data."
Write-Verbose "======================================="

Sync-ConfigurationData ( Get-LaunchJson ) @tpa


Write-Verbose "======================================="
Write-Verbose "Executing configurations."
Write-Verbose "======================================="

Start-ConfigurationFactory @tpa
