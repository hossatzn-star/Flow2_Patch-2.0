@echo off
setlocal enabledelayedexpansion
title FLOW 2 - Sistema di Patch PML

:: --- CONFIGURAZIONE PERCORSI ---
SET "CLIENT_ORIGINALE=C:\Server Clean\GitHub\Marty-v58\client"
SET "REPO_PATCH=C:\Flow 2 Patch\Flow2_Patch"
SET "PACKER_EXE=PackMakerLite.exe"
:: ------------------------------

echo [STEP 1] Sincronizzazione file dal client...
:: Creiamo una cartella temporanea per i file da impacchettare
if not exist "Source" mkdir "Source"
robocopy "%CLIENT_ORIGINALE%\pack" "%REPO_PATCH%\Source" /E /Z /R:2 /W:2

echo.
echo [STEP 2] Compattazione con PackMakerLite...
cd /d "%REPO_PATCH%"

:: Eseguiamo il packer. Nota: PML di solito richiede una cartella di output o un comando pack
if exist "%PACKER_EXE%" (
    :: Comando tipico per PML: impacchetta la cartella Source
    "%PACKER_EXE%" pack Source
) else (
    echo [ERRORE] %PACKER_EXE% non trovato! Copialo qui da Marty-v58.
    pause
    exit /b
)

echo.
echo [STEP 3] Caricamento su GitHub...
:: Aggiungiamo i file generati (es. .epk/.eix o il formato PML)
git add .
git commit -m "Patch PML Update: %date% %time%"
git push origin main

echo.
echo ======================================================
echo    OPERAZIONE COMPLETATA CON SUCCESSU (PML)
echo ======================================================
pause