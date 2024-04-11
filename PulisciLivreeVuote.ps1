# Ottiene la cultura corrente del sistema
$Culture = Get-Culture
$Language = $Culture.TwoLetterISOLanguageName
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
    switch ($Language) {
        'it' {
            Write-Host "Cartelle da eliminare:"
        }
        default {
            Write-Host "Folders to be deleted:"
        }
    }
    
    $foldersToDelete | ForEach-Object { Write-Host "  $_" }

    # Richiedi conferma
    switch ($Language) {
        'it' {
            $confirmation = Read-Host "Vuoi eliminare le cartelle elencate? (S/N)"
        }
        default {
            $confirmation = Read-Host "Do you want to permanently delete these folders? (Y/N)"
        }
    }
    
    if ($confirmation -ieq 'S' -or $confirmation -ieq 'Y') {
        # Elimina le cartelle
        foreach ($folder in $foldersToDelete) {
            Remove-Item -LiteralPath $folder -Recurse -Force
            switch ($Language) {
                'it' {
                    Write-Host "Cartella eliminata: $folder"
                }
                default {
                    Write-Host "Folder deleted: $folder"
                }
            }
        }
        switch ($Language) {
            'it' {
                Write-Host "Esecuzione dello script completata."
            }
            default {
                Write-Host "Script execution terminated."
            }
        }
    } else {
        switch ($Language) {
            'it' {
                Write-Host "Eliminazione annullata dall'utente."
            }
            default {
                Write-Host "Deletion canceled by the user."
            }
        }
    }
} else {
    switch ($Language) {
        'it' {
            Write-Host "Non sono presenti cartelle da eliminare."
        }
        default {
            Write-Host "There are no folders to delete."
        }
    }
}
