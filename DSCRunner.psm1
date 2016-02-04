# Checking for module cache;
if (-not (test-path variable:\DSCRunner))
{
    $Script:DSCRunner = @{};
}


Get-ChildItem $PSScriptRoot\Functions | ForEach-Object {
    . $_.FullName
}
