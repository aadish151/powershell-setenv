$Name = Read-Host -Prompt 'Enter environment variable name'
$Value = Read-Host -Prompt 'Enter environment variable value'
$Scope = Read-Host -Prompt 'Enter environment variable scope [default is machine]'

if ($Scope -in "user")
    {[System.Environment]::SetEnvironmentVariable($Name, $Value, $Scope)}
else
    {
        $Scope = "machine"
        [System.Environment]::SetEnvironmentVariable($Name, $Value, $Scope)
    }

Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1 && refreshenv
Write-Output "Variable set."
$Pathadd = Read-Host -prompt "Add bin to path? (y/n) [default is n]"
if ($Pathadd -in "y")
    {
        $CurrentPATH = ([Environment]::GetEnvironmentVariable("PATH")).Split(";")
        $Value = "%" + $Name + "%\bin"
        $NewPATH = ($CurrentPATH + $Value) -Join ";"
        [System.Environment]::SetEnvironmentVariable("PATH", $NewPATH, $Scope)
        Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1 && refreshenv
        Write-Output "Path set."
    }
