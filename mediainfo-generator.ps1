$mediaInfoPath = "Z:\EmplacementduDossier\MediaInfo_CLI_25.10_Windows_x64\MediaInfo.exe"  # Remplace par le chemin vers MediaInfo CLI
$videoExtensions = @("*.mp4", "*.mkv", "*.avi", "*.mov")  # Extensions à traiter
$outputFolder = "H:\monDossierContenantlesvideos\"  # Dossier contenant les vidéos
$outputFile = "$outputFolder\MaSerieFull.nfo"  # Fichier de sortie unique

# Initialise le fichier NFO
New-Item -Path $outputFile -ItemType File -Force | Out-Null

# Parcourt chaque fichier vidéo
Get-ChildItem -Path $outputFolder -Include $videoExtensions -Recurse | ForEach-Object {
    $videoPath = $_.FullName
    $videoName = $_.Name

    # Ajoute un séparateur pour chaque vidéo
    Add-Content -Path $outputFile -Value "`n`n=== $videoName ===`n"

    # Extrait les infos en JSON et les ajoute au fichier
    & $mediaInfoPath --Output="xml" "$videoPath" | Out-File -FilePath $outputFile -Append -Encoding utf8
}

Write-Host "Fichier NFO combiné créé : $outputFile"
