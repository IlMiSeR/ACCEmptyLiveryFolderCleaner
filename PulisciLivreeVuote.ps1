# Imposta il percorso della cartella principale
$MyDocsFolder = [Environment]::GetFolderPath("MyDocuments")
$rootFolder = $MyDocsFolder + "\Assetto Corsa Competizione\Customs\Liveries"

# Ottieni tutte le sottocartelle nella cartella principale
$subfolders = Get-ChildItem -Path $rootFolder -Directory

# Archivia le cartelle da eliminare in un array
$foldersToDelete = @()

# Itera attraverso ogni sottocartella
foreach ($folder in $subfolders) {
    # Verifica se la cartella contiene file PNG
    $pngFiles = Get-ChildItem -Path $folder.FullName -Filter *.png -File

    # Se non ci sono file PNG, aggiungi la cartella all'elenco
    if ($pngFiles.Count -eq 0) {
        $foldersToDelete += $folder.FullName
    }
}

if ($foldersToDelete.Count -gt 0 ) {
    # Visualizza l'elenco delle cartelle da eliminare
    Write-Host "Cartelle da eliminare:"
    $foldersToDelete | ForEach-Object { Write-Host "  $_" }

    # Richiedi conferma
    $confirmation = Read-Host "Vuoi eliminare le cartelle elencate? (S/N)"

    if ($confirmation -eq 'S' -or $confirmation -eq 's') {
        # Elimina le cartelle
        foreach ($folder in $foldersToDelete) {
            Remove-Item -LiteralPath $folder -Recurse -Force
            Write-Host "Cartella eliminata: $folder"
        }
        Write-Host "Esecuzione dello script completata."
    } else {
        Write-Host "Eliminazione annullata dall'utente."
    }
} else {
    Write-Host "Non sono presenti cartelle da eliminare."
}
