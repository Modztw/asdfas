@echo off
color 7
title Fivem Cleaner

:spoof

REM BFCPEICON=
cls
REM BFCPEICONINDEX=-1
cls
REM BFCPEEMBEDDISPLAY=0
cls
taskkill /f /im Steam.exe /t
cls
set hostspath=%windir%\System32\drivers\etc\hosts
cls
echo 127.0.0.1 xboxlive.com >> %hostspath%
cls
echo 127.0.0.1 user.auth.xboxlive.com >> %hostspath%
cls
echo 127.0.0.1 presence-heartbeat.xboxlive.com >> %hostspath%
cls
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSLicensing\HardwareID /f
cls
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSLicensing\Store /f
cls
REG DELETE HKEY_CURRENT_USER\Software\WinRAR\ArcHistory /f
cls
deltree /y c:\windows\temp
cls
deltree /y c:\windows\cookies
cls
rmdir /s /q "%LocalAppData%\FiveM\FiveM.app\cache\Browser"
cls
rmdir /s /q "%LocalAppData%\FiveM\FiveM.app\cache\db"
cls
rmdir /s /q "%LocalAppData%\FiveM\FiveM.app\cache\servers"
cls
del /s /q /f "%LocalAppData%\FiveM\FiveM.app\steam_api64.dll"
cls
del /s /q /f "%LocalAppData%\FiveM\FiveM.app\CitizenGame.dll"
cls
del /s /q /f "%LocalAppData%\FiveM\FiveM.app\cfx_curl_x86_64.dll"
cls
echo [!] FIVEM CLEANED !!!
timeout /t 2 >nul
