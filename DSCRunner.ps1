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
$env:PSModulePath = $env:PSModulePath = ";$PSScriptRoot\ResourceModules"

# testing parameters
$tpa = @{}
$tpa.add("Verbose",$true)


# Importing Module
Import-Module $PSScriptRoot\DSCRunner.psm1
Import-Module $PSScriptRoot\vsCodeUtil.psm1

Sync-ConfigurationData ( Get-LaunchJson ) @tpa

Start-RunnerConfiguration