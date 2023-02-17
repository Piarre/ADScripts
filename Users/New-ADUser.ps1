Clear-Host
$yes = "Y"
$domainDistinguishedName = (Get-ADDomain).distinguishedName
$domainForestName = (Get-ADDomain).Forest

Add-Type -AssemblyName System.Web
$generatedPwd = [System.Web.Security.Membership]::GeneratePassword(8, 2) 
$securedPwd = ConvertTo-SecureString $generatedPwd -AsPlainText  -Force


$firstName = Read-Host "Prénom de l'utilisateur "
$secondName = Read-Host "Et nom "
$autoPassword = Read-Host "Génerer un mot de passe sécuriser ? "

if ( -not (Get-ADUser -Filter { SamAccountName -eq $SomeSamAccountName }) ) {
    if (-not ($autoPassword -like $yes)) {
        New-ADUser 
        -GivenName $firstName 
        -Surname $secondName
        -SamAccountName "$firstName.$secondName" 
        -UserPrincipalName "$firstName.$secondName@$domainForestName" 
        -Path "OU=Utilisateurs,$domainDistinguishedName" 
        -Name prenomnom
        -AccountPassword $securedPwd
    }
    else {
        $givenPwd = Read-Host "Quel mot de passe souhaitez-vous ? "
        New-ADUser 
        -GivenName $firstName 
        -Surname $secondName
        -SamAccountName "$firstName.$secondName" 
        -UserPrincipalName "$firstName.$secondName@$domainForestName" 
        -Path "OU=Utilisateurs,$domainDistinguishedName" 
        -Name prenomnom
        -AccountPassword $A:givenPwd
    }
}