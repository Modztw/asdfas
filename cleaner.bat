@echo off
:: =============================================================
:: Saytus Systems | FiveM Cleaner Utility
:: https://saytus.systems
:: =============================================================

REM -- Asegurar ejecución como Administrador --
openfiles >nul 2>&1 || (
    echo Solicitando permisos de administrador...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

cls
echo =============================================================
echo               Saytus Systems - FiveM Cleaner
echo =============================================================
echo.
setlocal EnableDelayedExpansion

REM ================================
REM 1. Cerrar procesos relacionados
REM ================================
echo [1/7] Cerrando procesos... 
taskkill /f /t /im Steam.exe            >nul 2>&1
taskkill /f /t /im FiveM.exe            >nul 2>&1
taskkill /f /t /im FiveM_GTAProcess.exe >nul 2>&1
echo  -> Procesos finalizados.

REM ================================
REM 2. Respaldar y actualizar Hosts
REM ================================
echo [2/7] Actualizando archivo Hosts...
set HOSTS_FILE=%windir%\System32\drivers\etc\hosts
set BACKUP_HOSTS=%windir%\System32\drivers\etc\hosts.bak
if not exist "!BACKUP_HOSTS!" copy /y "!HOSTS_FILE!" "!BACKUP_HOSTS!" >nul 2>&1
for %%D in (xboxlive.com user.auth.xboxlive.com presence-heartbeat.xboxlive.com) do (
    findstr /i "%%D" "!HOSTS_FILE!" >nul 2>&1 || (
        echo 127.0.0.1 %%D >> "!HOSTS_FILE!"
    )
)
echo  -> Hosts actualizado.

REM ================================
REM 3. Limpiar licencias MSLicensing
REM ================================
echo [3/7] Eliminando licencias MSLicensing...
reg delete "HKLM\SOFTWARE\Microsoft\MSLicensing\HardwareID" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\MSLicensing\Store" /f >nul 2>&1
echo  -> Licencias eliminadas.

REM ================================
REM 4. Borrar historial de WinRAR
REM ================================
echo [4/7] Borrando historial de WinRAR...
reg delete "HKCU\Software\WinRAR\ArcHistory" /f >nul 2>&1
echo  -> Historial borrado.

REM ================================
REM 5. Limpiar Temp y Cookies
REM ================================
echo [5/7] Limpiando carpetas temporales...
rd /s /q "%windir%\Temp"        >nul 2>&1
rd /s /q "%windir%\Cookies"     >nul 2>&1
echo  -> Carpetas temporales eliminadas.

REM ================================
REM 6. Limpiar caché de FiveM
REM ================================
echo [6/7] Limpiando caché de FiveM...
set FIVEM_CACHE=%LocalAppData%\FiveM\FiveM.app\cache
for %%F in (Browser db servers) do rd /s /q "!FIVEM_CACHE!\%%F" >nul 2>&1

echo  -> Caché de FiveM limpia.

REM ================================
REM 7. Eliminar DLLs de FiveM
REM ================================
echo [7/7] Eliminando DLLs de FiveM...
del /s /q /f "%LocalAppData%\FiveM\FiveM.app\steam_api64.dll"     >nul 2>&1
del /s /q /f "%LocalAppData%\FiveM\FiveM.app\CitizenGame.dll"      >nul 2>&1
del /s /q /f "%LocalAppData%\FiveM\FiveM.app\cfx_curl_x86_64.dll" >nul 2>&1
echo  -> DLLs eliminadas.

echo.
echo =============================================================
echo            ¡FiveM ha sido limpiado correctamente!           
echo       (Script por Saytus Systems)      
echo =============================================================

echo.
echo Presiona cualquier tecla para salir...
pause >nul
exit /b
