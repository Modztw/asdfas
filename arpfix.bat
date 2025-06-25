@echo off
title "Saytus | Arp Fix"
>nul 2>&1


net stop winmgmt /y >nul 2>&1
net start winmgmt /y >nul 2>&1
sc stop winmgmt >nul 2>&1
sc start winmgmt >nul 2>&1
netsh interface ipv6 set teredo disable >nul 2>&1
netsh interface ipv6 set global randomizeidentifiers=disabled >nul 2>&1
netsh interface ipv6 set global state=disabled >nul 2>&1

arp -d >nul 2>&1

netsh winsock reset >nul 2>&1

netsh int ip reset >nul 2>&1

ipconfig /release >nul 2>&1

ipconfig /renew >nul 2>&1

ipconfig /flushdns >nul 2>&1

takeown /f "C:\Windows\System32\DriverStore\FileRepository\*\nvml.dll" /r /d y >nul 2>&1
icacls "C:\Windows\System32\DriverStore\FileRepository\*\nvml.dll" /grant administrators:F /t >nul 2>&1
del /f /q "C:\Windows\System32\DriverStore\FileRepository\*\nvml.dll" >nul 2>&1

taskkill /f /t /im SecurityHealthSystray.exe >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Realtek HD Audio Universal Service" /f >nul 2>&1
taskkill /f /t /im dklsdksapodoads.exe >nul 2>&1

exit