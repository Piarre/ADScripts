$domain = (Get-ADDomain).NetBIOSName

$sharedPath = Read-Host "Où créer le dossier pour connecter les utilisateurs "
$folderToShare = "$sharedPath\userProfils"

if (Test-Path -Path $sharedPath) {
    if (-not (Test-Path -Path $folderToShare)) {
        New-Item $folderToShare -Type Directory
        New-SmbShare -Name 
    }
    else {
        Write-Output "Le dossier existe déjà !"
    }
}
else {
    Write-Output "Se dossier n'existe pas ! "
}
