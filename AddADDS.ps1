#Add-WindowsFeature AD-Domain-Services
$Feature = (Get-WindowsFeature *ADDS*).Installed

if ($Feature) {
    Import-Module ADDSDeployment
    Install-ADDSForest `
        -CreateDnsDelegation:$false `
        -DatabasePath "C:\Windows\NTDS" `
        -DomainMode "WinThreshold" `
        -DomainName "ideestore.fr" `
        -DomainNetbiosName "IDEESTORE" `
        -ForestMode "WinThreshold" `
        -InstallDns:$true `
        -LogPath "C:\Windows\NTDS" `
        -NoRebootOnCompletion:$false `
        -SysvolPath "C:\Windows\SYSVOL" `
        -Force:$true
}
else {
    Add-WindowsFeature AD-Domain-Services
}
