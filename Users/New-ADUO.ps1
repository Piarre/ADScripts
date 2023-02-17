Clear-Host
$yes = "Y"
$domain = (Get-ADDomain).distinguishedName

$groupName = Read-Host "Quel est le nom de l'UO en cours de création ? "

if ( (Read-Host "Créer cette UO à la racine ? Y/N") -like $yes ) {
    if (Get-ADOrganizationalUnit -Filter "distinguishedName -eq 'OU=$groupName,$domain'") { 
        Write-Host "[ERREUR] Une UO existe déjà avec ce nom, création impossible !"
        Exit 
    }
    New-ADOrganizationalUnit -Name $groupName
    Write-Host
    Get-ADOrganizationalUnit -Filter "distinguishedName -eq 'OU=$groupName,$domain'"
}
else {
    Write-Output (Get-ADOrganizationalUnit -Filter 'Name -like "*"') | Format-Table Name, DistinguishedName -A
    $whereUOCreation = Read-Host "Parmis vos UOs, dans quel UO créer celle-ci ? (nom de l'UO seulement) "
    if (Get-ADOrganizationalUnit -Filter "distinguishedName -eq 'OU=$groupName,OU=$whereUOCreation                                                                                                                                                           ,$domain'") { 
        Write-Host "[ERREUR] Une UO existe déjà avec ce nom, création impossible !"
        Exit 
    }
    New-ADOrganizationalUnit -Name $groupName -Path "OU=$whereUOCreation,$domain"
}
