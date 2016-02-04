
Function Get-LaunchJson {
    
    try {
    Get-Content $PSScriptRoot\..\.vscode\launch.json | 
        ConvertFrom-Json 
    }
    catch {
        Write-Error -Category "vsCodeUtil.CannotFindLaunchConfig" `
            -Message "Unable to locate the launch config. Check `$PSScriptRoot\.vscode\launch.json"
    }
}