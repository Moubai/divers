Set-ExecutionPolicy -ExecutionPolicy Bypass

#recherche d'un paquet (copier l'id plutot que le nom)
#winget search notepad++

#winget bypass certificate problem
#winget settings --enable bypasscertificatepinningformicrosoftstore
#installation du paquet
#winget install notepad++

#installation via un id avec acceptation auto des  contrats 
#winget install --id Devolutions.RemoteDesktopManagerFree --accept-package-agreements

#winget upgrade --all #pour upgrade tous les paquets

#installation pc martin après fresh install windows
$ListeSoftware =  @(
	'Microsoft.PowerShell'
	#'Microsoft.VisualStudioCode'
  'JanDeDobbeleer.OhMyPosh'
  'Daum.PotPlayer'
  #'Devolutions.RemoteDesktopManagerFree'
  'Notepad++.Notepad++'
  'Mozilla.Firefox'
	'CodecGuide.K-LiteCodecPack.Standard'
	'obsidian.obsidian'
	'variar.klogg'
	'SumatraPDF.SumatraPDF'
	'ShareX.ShareX'
	#'OBSProject.OBSStudio'
	'Microsoft.PowerToys'
	'Ferdium.Ferdium'
	'Bitwarden.Bitwarden'
	'brave.brave'
	'7zip.7zip'
	#'KeePassXCTeam.KeePassXC'
)

Foreach($app in $listesoftware){
	winget install --id $app --accept-package-agreements
}

Write-Host "installation des paquets terminés"
Write-Host "modification clé de registre pour remettre l'ancien menu du clic droit"
#enable old right menu windows 11
New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Value "" -Force

Write-Host "activer le numpad au boot"
Set-ItemProperty -Path 'Registry::HKU\.DEFAULT\Control Panel\Keyboard' -Name "InitialKeyboardIndicators" -Value "2"
Write-Host "Clé de registre activée, reboot nécessaire" -foregroundcolor green

#install terminal-icons for oh-my-posh
Install-module -name Terminal-Icons -Repository PSGallery

