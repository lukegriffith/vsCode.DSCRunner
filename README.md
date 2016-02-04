# vsCode DSC Runner

I started this project with the intended to ease the burden of testing DSC resource implementation all the way through the DSC engine. This VsCode development environment utilized the DSCRunner module and launch configuration to start the DSCRunner.ps1 script that executes the stated configuration files against specified nodes. 


## Configurations/
Within this folder are the module files that contain the final configuration files. 
These can contain nested configurations, as long as the required modules are within the RequiredModules/ folder and are specified on the Launch.Json, as these are imported into the runspace prior to compiling the configuaration MOF.

## RequiredModules/
This folder holds module folders (Folders that hold psm1 or psd1 files). At run time these modules will be imported into the scope of the execution environment prior to the configurations being loaded. These needs to be explicit stated in the Launch.Json under RequiredModules. 

