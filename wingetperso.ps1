Set-ExecutionPolicy -ExecutionPolicy Bypass

#winget bypass certificate problem
#winget settings --enable bypasscertificatepinningformicrosoftstore
#installation du paquet

$ListeSoftware =  @(
  #'Microsoft.PowerShell'
  #'Microsoft.VisualStudioCode'
  #'JanDeDobbeleer.OhMyPosh'
  #'Daum.PotPlayer'
  #'Devolutions.RemoteDesktopManagerFree'
  #'Notepad++.Notepad++'
  #'Mozilla.Firefox'
  #'CodecGuide.K-LiteCodecPack.Standard'
  #'obsidian.obsidian'
  #'variar.klogg'
  #'SumatraPDF.SumatraPDF'
  #'ShareX.ShareX'
  #'OBSProject.OBSStudio'
  #'Microsoft.PowerToys'
  #'Ferdium.Ferdium'
  #'Bitwarden.Bitwarden'
  #'brave.brave'
  #'7zip.7zip'
  #'KeePassXCTeam.KeePassXC'
  #dolby digital plus decode for pc oem (plex fix)
  #'9NVJQJBDKN97'
)
Write-Host "ajout du module terminal-icons pour oh-my-posh" -foregroundcolor Yellow
Install-module terminal-icons -force

Write-host "installation des applications avec winget" -foregroundcolor Yellow
Foreach($app in $listesoftware){
	winget install --id $app --accept-package-agreements
}

Write-Host "installation des paquets terminés" -foregroundcolor Yellow
Write-Host "modification clé de registre pour remettre l'ancien menu du clic droit" -foregroundcolor Yellow
#enable old right menu windows 11
New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Value "" -Force

Write-Host "activer le numpad au boot" -foregroundcolor Yellow
Set-ItemProperty -Path 'Registry::HKU\.DEFAULT\Control Panel\Keyboard' -Name "InitialKeyboardIndicators" -Value "2"
Write-Host "Clé de registre activée, reboot nécessaire" -foregroundcolor green

Write-Host "activer terminer la tâche avec le clic droit dans la barre des tâches" -foregroundcolor Yellow
$path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings"
	$name = "TaskbarEndTask"
	$value = 1
# Ensure the registry key exists
if (-not (Test-Path $path)) { New-Item -Path $path -Force | Out-Null }
	# Set the property, creating it if it doesn't exist
New-ItemProperty -Path $path -Name $name -PropertyType DWord -Value $value -Force | Out-Null

#region ajout fichier profil avec quickterm pour oh-my-posh
Write-Host "modification du theme oh-my-posh pour mettre quickterm + terminal icon a chaque lancement" -foregroundcolor Yellow
if (-not (test-path $PROFILE)){ New-item -Path $PROFILE -type File -Force}
add-content -path $PROFILE -value 'oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/quick-term.omp.json" | Invoke-Expression'
add-content -path $PROFILE -value "Import-module -Name Terminal-Icons"
#end region
#oh-my-posh install fonts
oh-my-posh font install meslo

#add font to terminal
$JsonFilePath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
if(-not (test-path $jsonFilePath)){
	Write-Host "fichier settings.json du terminal non present, ce n'est pas normal !"
}
else{
	Write-Host "modification du settings.json du terminal pour ajouter la font Meslo" -foregroundcolor Yellow
	$JsonContent = Get-Content -path $JsonFilePath -raw | convertFrom-Json
 	$JsonContant.profiles.defaults.font.face = "MesloLGL Nerd Font"
}
Write-Host "opérations terminée, merci d'effectuer un reboot pour application des cles de registre" -foregroundcolor Green


