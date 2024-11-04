
@echo off
cls
color 0f
:menu_a
cls
    echo.     
:: LOGO NTE
echo                 ##                       ###                        ###
echo                 ##                        ##                         ##
echo      #####     #####    ####              ##       ####     ####     ##  ##
echo      ##  ##     ##     ##  ##             #####       ##   ##  ##    ## ##
echo      ##  ##     ##     ######             ##  ##   #####   ##        ####
echo      ##  ##     ## ##  ##                 ##  ##  ##  ##   ##  ##    ## ##
echo      ##  ##      ###    #####            ###  ##   #####    ####     ##  ##
    echo.
    echo.  
@echo off
:: Verifica se o script está sendo executado como administrador
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo Este script precisa ser executado como administrador.
    echo Reiniciando...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

echo Modo admin ativado.
pause
cls
:: FIM DA CONFIGURALCAO INICIAL DE ADMIN
:menu

:: CONFIGURA COR
color 0f


:: DATA E INFORMAÇÕES DO PC
title    NTE ADMIN
set data=%date:~6,4%-%date:~3,2%-%date:~0,2%
set hora=%time:~0,2%:%time:~3,2%
echo.
echo    Data atual: %data%  - Hora Atual: %hora%         
echo    Computador: %computername%  -  Usuario: %username%
echo -------------------------------------------------------------------
::codigo ip
setlocal enabledelayedexpansion
for /f "delims=" %%a in ('ipconfig ^| findstr IPv4') do (
    set nome=%%a
    set nome=!nome::=!
)
echo !nome!
endlocal
::codigo ip fim 
echo -------------------------------------------------------------------
echo.
:: LOGO NTE
echo      ==================================================================
echo       =        ##   ##  ######   #######      ####     ####           =
echo       =        ###  ##  # ## #    ##   #     ##  ##   ##  ##          =
echo       =        #### ##    ##      ## #           ##   ##  ##          =   
echo       =        ## ####    ##      ####         ###     #####          =
echo       =        ##  ###    ##      ## #        ##          ##          =
echo       =        ##   ##    ##      ##   #     ##  ##      ##           =
echo       =        ##   ##   ####    #######     ######    ###            =    
echo      ==================================================================
    echo.
    echo.  

echo                            MENU TAREFAS
echo                 ===================================
echo                 =      1. Limpar pc               = 
echo                 =      2. Abrir MSCONFIG          =
echo                 =      3. Otimizar Disco          =
echo                 =      4. Escanear PC             =
echo                 =      5. Configurar PROXY        =
echo                 =      6. Creditos                = 
echo                 =      7. Copiar Arquivos         = 
echo                 =      8. Enviar Informacoes      = 
echo                 =      9. Sair                    = 
echo                 ===================================
    echo.
    echo.  
set /p opcao=               Escolha uma opcao: 
echo ------------------------------
if %opcao% equ 1 goto opcao1
if %opcao% equ 2 goto opcao2
if %opcao% equ 3 goto opcao3
if %opcao% equ 4 goto opcao4
if %opcao% equ 5 goto opcao5
if %opcao% equ 6 goto opcao6
if %opcao% equ 7 goto opcao7
if %opcao% equ 8 goto opcao8
if %opcao% equ 9 goto opcao8
::------------------------------------------------------------------------------------------------------------------------------------------------
:: INÍCIO DO MENU 1 LIMPEZA
    :opcao1
    cls

    @echo off
  
    rd /Q /s c:\$Recycle.bin

    del /q/f/s %temp%\*
    
    del /q/f/s C:\Windows\temp

    del /q/f/s C:\Windows\SoftwareDistribution\Download

    del /q/f/s C:\Windows\Prefetch

    del /q/f/s C:\Users\%username%\AppData\Local\Microsoft\Windows\INetCache\IE

    REM INÍCIO DA LIMPEZA PEZADA ---------------------------------------------------------------------------------------------------------------------

    REM ******************** LIXEIRA ********************
    del c:\$recycle.bin\* /s /q
    PowerShell.exe -NoProfile -Command Clear-RecycleBin -Confirm:$false >$null
    del $null

    REM ******************** PASTA TEMP DOS USUÁRIOS ********************

    REM Apaga todos arquivos da pasta Temp de todos os usuários
    for /d %%F in (C:\Users\*) do (Powershell.exe Remove-Item -Path "%%F\AppData\Local\Temp\*" -Recurse -Force)

    REM cria arquivo vazio.txt dentro da pasta Temp de todos usuários
    for /d %%F in (C:\Users\*) do type nul >"%%F\Appdata\Local\Temp\vazio.txt"

    REM apaga todas as pastas vazias dentro da pasta Temp de todos usuários (mas não apaga a própria pasta Temp)
    for /d %%F in (C:\Users\*) do robocopy %%F\AppData\Local\Temp\ %%F\AppData\Local\Temp\ /s /move /NFL /NDL /NJH /NJS /nc /ns /np

    REM Apaga arquivo vazio.txt dentro da pasta Temp de todos usuários
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Temp\vazio.txt

    REM ******************** WINDOWS TEMP ********************

    REM Apaga todos arquivos da pasta \Windows\Temp, mantendo das pastas
    del c:\Windows\Temp\* /s /q

    REM cria arquivo vazio.txt dentro da pasta \Windows\Temp
    type nul > c:\Windows\Temp\vazio.txt

    REM apaga todas as pastas vazias dentro da pasta \Windows\Temp (mas não apaga a própria pasta)
    robocopy c:\Windows\Temp c:\Windows\Temp /s /move /NFL /NDL /NJH /NJS /nc /ns /np

    REM Apaga arquivo vazio.txt dentro da pasta \Windows\Temp
    del c:\Windows\Temp\vazio.txt

    REM ******************** ARQUIVOS DE LOG DO WINDOWS ********************
    del C:\Windows\Logs\cbs\*.log
    del C:\Windows\setupact.log
    attrib -s c:\windows\logs\measuredboot\*.*
    del c:\windows\logs\measuredboot\*.log
    attrib -h -s C:\Windows\ServiceProfiles\NetworkService\
    attrib -h -s C:\Windows\ServiceProfiles\LocalService\
    del C:\Windows\ServiceProfiles\LocalService\AppData\Local\Temp\MpCmdRun.log
    del C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Temp\MpCmdRun.log
    attrib +h +s C:\Windows\ServiceProfiles\NetworkService\
    attrib +h +s C:\Windows\ServiceProfiles\LocalService\
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\*.log /s /q
    del C:\Windows\Logs\MeasuredBoot\*.log 
    del C:\Windows\Logs\MoSetup\*.log
    del C:\Windows\Panther\*.log /s /q
    del C:\Windows\Performance\WinSAT\winsat.log /s /q
    del C:\Windows\inf\*.log /s /q
    del C:\Windows\logs\*.log /s /q
    del C:\Windows\SoftwareDistribution\*.log /s /q
    del C:\Windows\Microsoft.NET\*.log /s /q

    REM ******************** ARQUIVOS DE LOG DO ONEDRIVE ********************
    taskkill /F /IM "OneDrive.exe"
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\OneDrive\setup\logs\*.log /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\OneDrive\*.odl /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\OneDrive\*.aodl /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\OneDrive\*.otc /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\OneDrive\*.qmlc /s /q

    REM ******************** ARQUIVOS DE DUMP DE PROGRAMAS (NÃO DO WINDOWS) ********************
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\CrashDumps\*.dmp /s /q

    REM ******************** ARQUIVOS DE LOG DO WINDOWS E IE ********************
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Windows\Explorer\*.db /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Windows\WebCache\*.log /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Windows\SettingSync\*.log /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Windows\Explorer\ThumbCacheToDelete\*.tmp /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\"Terminal Server Client"\Cache\*.bin /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Windows\INetCache\IE\* /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Windows\INetCache\Low\*.dat /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Windows\INetCache\Low\*.js /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Windows\INetCache\Low\*.htm /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Windows\INetCache\Low\*.txt /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Windows\INetCache\Low\*.jpg /s /q
    for /d %%F in (C:\Users\*) do robocopy %%F\AppData\Local\Microsoft\Windows\INetCache\IE\ /s /move /NFL /NDL /NJH /NJS /nc /ns /np

    REM ******************** EDGE ********************
    taskkill /F /IM "msedge.exe"

    for /d %%F in (C:\Users\*) do attrib -h -s %%F\AppData\LocalLow\Microsoft\CryptnetUrlCache\Content\*.*
    for /d %%F in (C:\Users\*) do attrib -h -s %%F\AppData\LocalLow\Microsoft\CryptnetUrlCache\MetaData\*.*
    for /d %%F in (C:\Users\*) do del %%F\AppData\LocalLow\Microsoft\CryptnetUrlCache\Content\*.* /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\LocalLow\Microsoft\CryptnetUrlCache\MetaData\*.* /s /q
    for /d %%F in (C:\Users\*) do attrib +h +s %%F\AppData\LocalLow\Microsoft\CryptnetUrlCache\Content
    for /d %%F in (C:\Users\*) do attrib +h +s %%F\AppData\LocalLow\Microsoft\CryptnetUrlCache\MetaData
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\Default\Cache\Cache_Data\data*. /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Guest Profile"\Cache\Cache_Data\data*. /s /q
    for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\Cache\Cache_Data\data*. /s /q)
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\Default\Cache\Cache_Data\f*. /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Guest Profile"\Cache\Cache_Data\f*. /s /q
    for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\Cache\Cache_Data\f*. /s /q)
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\Default\Cache\Cache_Data\index. /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Guest Profile"\Cache\Cache_Data\index. /s /q
    for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\Cache\Cache_Data\index. /s /q)
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\Default\GPUCache\d*. /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Guest Profile"\GPUCache\d*. /s /q
    for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\GPUCache\d*. /s /q)
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\Default\GPUCache\i*. /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Guest Profile"\GPUCache\i*. /s /q
    for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\GPUCache\i*. /s /q)
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\Default\IndexedDB\https_ntp.msn.com_0.indexeddb.leveldb\*.* /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Guest Profile"\IndexedDB\https_ntp.msn.com_0.indexeddb.leveldb\*.* /s /q
    for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\IndexedDB\https_ntp.msn.com_0.indexeddb.leveldb\*.* /s /q)
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\*.pma /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\Default\"Code Cache"\js\*. /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Guest Profile"\"Code Cache"\js\*. /s /q
    for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\"Code Cache"\js\*. /s /q)
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\Default\"Code Cache"\wasm\*. /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Guest Profile"\"Code Cache"\wasm\*. /s /q
    for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\"Code Cache"\wasm\*. /s /q)
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\Default\"Platform Notifications"\*.* /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Guest Profile"\"Platform Notifications"\*.* /s /q
    for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\"Platform Notifications"\*.* /s /q)
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\Default\EdgePushStorageWithWinRt\*.log /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Guest Profile"\EdgePushStorageWithWinRt\*.log /s /q
    for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\EdgePushStorageWithWinRt\*.log /s /q)
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\Default\"File System"\*. /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Guest Profile"\"File System"\*. /s /q
    for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\"File System"\*. /s /q)
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\Default\"Service Worker"\CacheStorage\*. /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Guest Profile"\"Service Worker"\CacheStorage\*. /s /q
    for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\"Service Worker"\CacheStorage\*. /s /q)
    for /d %%F in (C:\Users\*) do robocopy %%F\AppData\Local\Microsoft\Edge\"User Data"\Default\"Service Worker"\CacheStorage\ %%F\AppData\Local\Microsoft\Edge\"User Data"\Default\"Service Worker"\CacheStorage\ /s /move /NFL /NDL /NJH /NJS /nc /ns /np
    for /d %%F in (C:\Users\*) do robocopy %%F\AppData\Local\Microsoft\Edge\"User Data"\"Guest Profile"\"Service Worker"\CacheStorage\ %%F\AppData\Local\Microsoft\Edge\"User Data"\"Guest Profile"\"Service Worker"\CacheStorage\ /s /move /NFL /NDL /NJH /NJS /nc /ns /np
    for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do robocopy %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\"Service Worker"\CacheStorage\ %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\"Service Worker"\CacheStorage\ /s /move /NFL /NDL /NJH /NJS /nc /ns /np)
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\Default\"Service Worker"\Database\*. /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Guest Profile"\"Service Worker"\Database\*. /s /q
    for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\"Service Worker"\Database\*. /s /q)
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\Default\"Service Worker"\ScriptCache\*. /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Guest Profile"\"Service Worker"\ScriptCache\*. /s /q
    for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\"Service Worker"\ScriptCache\*. /s /q)
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\Default\EdgeCoupons\coupons_data.db\*.ldb /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Guest Profile"\EdgeCoupons\coupons_data.db\*.ldb /s /q
    for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\EdgeCoupons\coupons_data.db\*.ldb /s /q)
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\Default\EdgeCoupons\coupons_data.db\index. /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Guest Profile"\EdgeCoupons\coupons_data.db\index. /s /q
    for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\EdgeCoupons\coupons_data.db\index. /s /q)
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\Default\EdgeCoupons\coupons_data.db\*.log /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Guest Profile"\EdgeCoupons\coupons_data.db\*.log /s /q
    for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\"Profile %%i"\EdgeCoupons\coupons_data.db\*.log /s /q)
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\Edge\"User Data"\BrowserMetrics\*.pma /s /q

    REM ******************** FIREFOX ********************
    taskkill /F /IM "firefox.exe"

    for /d %%F in (C:\Users\*) do del %%F\AppData\local\Mozilla\Firefox\Profiles\*. /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\local\Mozilla\Firefox\Profiles\script*.bin /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\local\Mozilla\Firefox\Profiles\startup*.* /s /q

    REM ******************** CHROME ********************
    taskkill /F /IM "chrome.exe"

    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\Default\Cache\Cache_Data\data*. /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Guest Profile"\Cache\Cache_Data\data*. /s /q
    for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\Cache\Cache_Data\data*. /s /q)
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\Default\Cache\Cache_Data\f*. /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Guest Profile"\Cache\Cache_Data\f*. /s /q
    for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\Cache\Cache_Data\f*. /s /q)
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\Default\Cache\Cache_Data\index. /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Guest Profile"\Cache\Cache_Data\index. /s /q
    for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\Cache\Cache_Data\index. /s /q)
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\Default\GPUCache\d*. /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Guest Profile"\GPUCache\d*. /s /q
    for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\GPUCache\d*. /s /q)
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\Default\GPUCache\i*. /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Guest Profile"\GPUCache\i*. /s /q
    for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\GPUCache\i*. /s /q)
    del C:\Program Files\Google\Chrome\Application\SetupMetrics\*.pma /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\Default\"Code Cache"\js\*. /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Guest Profile"\"Code Cache"\js\*. /s /q
    for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\"Code Cache"\js\*. /s /q)
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\Default\"Code Cache"\wasm\*. /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Guest Profile"\"Code Cache"\wasm\*. /s /q
    for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\"Code Cache"\wasm\*. /s /q)
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\Default\Storage\data_*. /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Guest Profile"\Storage\data_*. /s /q
    for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\Storage\data_*. /s /q)
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\Default\JumpListIconsRecentClosed\*.tmp /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Guest Profile"\JumpListIconsRecentClosed\*.tmp /s /q
    for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\JumpListIconsRecentClosed\*.tmp /s /q)
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\Default\Storage\index*. /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Guest Profile"\Storage\index*. /s /q
    for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\Storage\index*. /s /q)
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\Default\History-journal*. /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Guest Profile"\History-journal*. /s /q
    for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\History-journal*. /s /q)
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\Default\"Code Cache"\webui_js\*. /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Guest Profile"\"Code Cache"\webui_js\*. /s /q
    for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\"Code Cache"\webui_js\*. /s /q)
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\Default\"Service Worker"\CacheStorage\*. /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Guest Profile"\"Service Worker"\CacheStorage\*. /s /q
    for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\"Service Worker"\CacheStorage\*. /s /q)
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\Default\"Service Worker"\Database\*.log /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Guest Profile"\"Service Worker"\Database\*.log /s /q
    for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\"Service Worker"\Database\*.log /s /q)
    for /d %%F in (C:\Users\*) do robocopy %%F\AppData\Local\Google\Chrome\"User Data"\Default\"Service Worker"\CacheStorage\ %%F\AppData\Local\Google\Chrome\"User Data"\Default\"Service Worker"\CacheStorage\ /s /move /NFL /NDL /NJH /NJS /nc /ns /np
    for /d %%F in (C:\Users\*) do robocopy %%F\AppData\Local\Google\Chrome\"User Data"\"Guest Profile"\"Service Worker"\CacheStorage\ %%F\AppData\Local\Google\Chrome\"User Data"\"Profile 1"\"Service Worker"\CacheStorage\ /s /move /NFL /NDL /NJH /NJS /nc /ns /np
    for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do robocopy %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\"Service Worker"\CacheStorage\ %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\"Service Worker"\CacheStorage\ /s /move /NFL /NDL /NJH /NJS /nc /ns /np)
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\Default\"Service Worker"\Database\*. /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Guest Profile"\"Service Worker"\Database\*. /s /q
    for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\"Service Worker"\Database\*. /s /q)
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\Default\"Service Worker"\ScriptCache\*. /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Guest Profile"\"Service Worker"\ScriptCache\*. /s /q
    for /l %%i in (1,1,12) do (for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\"Profile %%i"\"Service Worker"\ScriptCache\*. /s /q)
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\BrowserMetrics*.pma /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Google\Chrome\"User Data"\crash*.pma /s /q

    REM ******************** SPOTIFY ********************
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Spotify\Data\*.file /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Spotify\Browser\Cache\"Cache_Data"\f*. /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Spotify\Browser\GPUCache\*. /s /q

    REM ******************** ADOBE MEDIA CACHE FILES ********************
    for /d %%F in (C:\Users\*) do del %%F\AppData\Roaming\Adobe\Common\"Media Cache files"\*.* /s /q
    for /d %%F in (C:\Users\*) do del %%F\AppData\Roaming\Adobe\*.log /s /q

    REM ******************** VMWARE ********************
    del C:\ProgramData\VMware\logs\*.log /s /q

    REM FIM DA LIMPEZA PEZADA ---------------------------------------------------------------------------------------------------------------------


    @echo off

    set /p reiniciar="Voce quer reiniciar o PC? (S/N): "

    if /i "%reiniciar%"=="S" (
    shutdown /r /t 0
    ) else (
    echo Reinicializacao cancelada.
    )

    echo ==================================
    echo *      PC limpo com sucesso      *
    echo ==================================
    pause
    cls
    goto menu
:: FIM MENU 1 LIMPEZA

::------------------------------------------------------------------------------------------------------------------------------------------------

:: MENU 2 - ABRIR MSCONFIG (Desativar itens que iniciam com o windows)
    :opcao2
    cls
    start msconfig
    echo      ==================================
    echo      *        Abrindo MSCONFIG        *
    echo      ==================================
    pause
    cls
    goto menu

::------------------------------------------------------------------------------------------------------------------------------------------------

:: MENU 3 - Abrir DESFRAGMENTADOR de unidades
    :opcao3
    cls
    echo          ###     ###                                 ##
    echo           ##    ## ##
    echo           ##     #      ######    ### ##  ##  ##    ###
    echo        #####   ####      ##  ##  ##  ##   ##  ##     ##
    echo       ##  ##    ##       ##      ##  ##   ##  ##     ##
    echo       ##  ##    ##       ##       #####   ##  ##     ##
    echo        ######  ####     ####         ##    ######   ####
    echo                                   #####
    echo.
    echo.
    start dfrgui
    echo      ==================================
    echo      *    Abrindo Desfragmentador     *
    echo      ==================================
    pause
    cls
    goto menu

::------------------------------------------------------------------------------------------------------------------------------------------------

:: MENU 4 - COM SUBMENUS | Verificar erros no disco

    :opcao4
    cls

    @echo off
    cls
    :menu1
    cls
    color 0D


    date /t

    echo Computador: %computername%        Usuario: %username%
    echo.  
    echo        ####    ######   ######    ####     #####
    echo       ##  ##    ##  ##   ##  ##  ##  ##   ##
    echo       ######    ##       ##      ##  ##    #####
    echo       ##        ##       ##      ##  ##        ##
    echo        #####   ####     ####      ####    ######
    echo.                     
    echo                      MENU TAREFAS
    echo            ==================================
    echo           * 1. Verificacao rapida           * 
    echo           * 2. Verificacao completa         *
    echo           * 3. Verificacao DISM+SFC         *
    echo           * 4. CHKDSK em C:                 *
    echo           * 5. Voltar                       *
    echo            ==================================

    set /p opcao= Escolha uma opcao: 
    echo ------------------------------
    if %opcao% equ 1 goto opcao1
    if %opcao% equ 2 goto opcao2
    if %opcao% equ 3 goto opcao3
    if %opcao% equ 4 goto opcao4
    if %opcao% equ 5 goto opcaov

    :opcao1
    cls
    "%ProgramFiles%\Windows Defender\MpCmdRun.exe" /Scan /ScanType:1

    echo      ==================================
    echo      *    Verificacao concluida       *
    echo      ==================================
    pause
    goto menu1

    :opcao2
    cls

    "%ProgramFiles%\Windows Defender\MpCmdRun.exe" /Scan /ScanType:2

    echo      ==================================
    echo      *    Verificacao concluida       *
    echo      ==================================
    pause
    goto menu1

    :opcao3
    cls

    SFC /scannow
    DISM /Online /Cleanup-Image /ScanHealth
    DISM /Online /Cleanup-Image /RestoreHealth


    @echo off

    set /p reiniciar="Voce quer reiniciar o PC? (S/N): "

    if /i "%reiniciar%"=="S" (
    shutdown /r /t 0
    ) else (
    echo Reinicializacao cancelada.
    pause
    )

    :opcao4
    cls

    chkdsk C: /f /r


    @echo off

    set /p reiniciar="Voce quer reiniciar o PC? (S/N): "

    if /i "%reiniciar%"=="S" (
    shutdown /r /t 0
    ) else (
    echo Reinicializacao cancelada.
    pause
    )

    :opcaov
    cls
    goto menu
:: FIM DO MENU 4 COM SUBMENUS

::------------------------------------------------------------------------------------------------------------------------------------------------

:: MENU 5 PROXY - COM SUBMENUS

    :opcao5
    cls

    @echo off
    cls
    :menub
    cls
    color 0E
    echo.
    echo         ######   ######    ####    ##  ##   ##  ##
    echo          ##  ##   ##  ##  ##  ##    ####    ##  ##
    echo          ##  ##   ##      ##  ##     ##     ##  ##
    echo          #####    ##      ##  ##    ####     #####
    echo          ##      ####      ####    ##  ##       ##
    echo          ####                                #####
    echo. 

    echo                 MENU PROXY
    echo       ==================================
    echo      * 1. Ativar PROXY                 * 
    echo      * 2. Confgurar PAC PRODEMGE       *
    echo      * 3. Desativar PROXY              *
    echo      * 4. Voltar                       *
    echo       ==================================

    set /p opcao=       Escolha uma opcao: 
    echo ------------------------------
    if %opcao% equ 1 goto opcao1
    if %opcao% equ 2 goto opcao2
    if %opcao% equ 3 goto opcao3
    if %opcao% equ 4 goto opcao4



    :opcao1
    cls
    :: Ativar o proxy
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f

    echo ==================================
    echo *       PROXY Ativado            *
    echo ==================================
    pause

    @echo off

    set /p reiniciar="Voce quer reiniciar o PC? (S/N): "

    if /i "%reiniciar%"=="S" (
    shutdown /r /t 0
    ) else (
    echo Reinicializacao cancelada.
    pause
    )

    cls
    goto menu2

    :opcao2
    cls

    :: Configurar o proxy (substitua pelo seu endereço PAC)
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v AutoConfigURL /t REG_SZ /d "http://proxy.prodemge.gov.br/proxy.pac" /f


    echo ==================================
    echo *     Proxy PAC Configurado      *
    echo ==================================
    pause
    @echo off

    set /p reiniciar="Voce quer reiniciar o PC? (S/N): "

    if /i "%reiniciar%"=="S" (
    shutdown /r /t 0
    ) else (
    echo Reinicializacao cancelada.
    pause
    )

    cls
    goto menub

    :opcao3
    cls
    :: Desativar proxy
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f
    echo ==================================
    echo *        PROXY Desativado        *
    echo ==================================
    pause
    @echo off

    set /p reiniciar="Voce quer reiniciar o PC? (S/N): "

    if /i "%reiniciar%"=="S" (
    shutdown /r /t 0
    ) else (
    echo Reinicializacao cancelada.
    pause
    )

    cls
    goto menub

    :opcao4
    cls
    goto menu
:: FIM DO MENU 5 COM SUBMENUS

::------------------------------------------------------------------------------------------------------------------------------------------------

:: CRÉDITOS

    :opcao6
    cls
    color e0
    @echo off

    echo.
    echo       ###                 ##
    echo        ##                 ##
    echo        ##       ####     #####   ##  ##    ####    #####
    echo        #####       ##     ##     #######      ##   ##  ##
    echo        ##  ##   #####     ##     ## # ##   #####   ##  ##
    echo        ##  ##  ##  ##     ## ##  ##   ##  ##  ##   ##  ##
    echo        ######    #####      ###   ##   ##   #####   ##  ##
    echo.
    echo.
    echo ---------------------------------------------------------------------------
    echo      ELIENAY HEMERSON - NTE CARANGOLA
    echo      elienay.domingues@educacao.mg.gov.br
    echo ---------------------------------------------------------------------------
    echo.
    echo.
    pause
    cls
    goto menu

::------------------------------------------------------------------------------------------------------------------------------------------------

:: OPÇÃO 7 - copiar arquivos
    :opcao7
    cls
    color 0F
    @echo off

    setlocal

    echo                   ###
    echo                    ##
    echo ######    ####     ##       ####     ####     ####    ######   ##  ##
    echo  ##  ##  ##  ##    #####   ##  ##   ##  ##   ##  ##    ##  ##  ##  ##
    echo  ##      ##  ##    ##  ##  ##  ##   ##       ##  ##    ##  ##  ##  ##
    echo  ##      ##  ##    ##  ##  ##  ##   ##  ##   ##  ##    #####    #####
    echo ####      ####    ######    ####     ####     ####     ##          ##
    echo                                                       ####     #####


    echo Digite o caminho da pasta que deseja copiar:
    set /p sourceFolder="Fonte: "

    echo Deseja criar uma nova pasta no diretorio de destino? (S/N)
    set /p createFolder="Resposta: "

    if /I "%createFolder%"=="S" (
        echo Digite o nome da nova pasta:
        set /p newFolderName="Nome da nova pasta: "
        set destinationFolder="%temp%\%newFolderName%"
        mkdir %destinationFolder%
    ) else (
        echo Digite o caminho do diretorio de destino:
        set /p destinationFolder="Destino: "
    )

    echo Digite o caminho do diretorio de destino:
    set /p destinationFolder="Destino: "

    robocopy "%sourceFolder%" %destinationFolder% /E /Z /R:5 /W:5

    if %errorlevel% neq 0 (
        echo Erro: A copia nao foi bem-sucedida!
    ) else (
        echo Copia concluida com sucesso!
    )

    pause
    cls
        goto menu

::------------------------------------------------------------------------------------------------------------------------------------------------


:: OPÇÃO 8 - ENVIAR INFORMAÇÕES
    :opcao8
    cls
    color e0
    @echo off

    set "email_destino=nte29.coord@educacao.mg.gov.br"
    set "assunto=INF BAT CODE"
    set "corpo=Este é um email enviado a partir de um script batch.\nAqui estão as informações que você pediu."

    powershell -Command "Send-MailMessage -To '%email_destino%' -From 'nte29.coord@educacao.mg.gov.br' -Subject '%assunto%' -Body '%corpo%' -SmtpServer 'smtp.gmail.com' -Credential (Get-Credential)"

    echo Email enviado para %email_destino%
    pause

::------------------------------------------------------------------------------------------------------------------------------------------------



:: MENU 9 - SAIR 
    :opcao9
    cls
    exit


