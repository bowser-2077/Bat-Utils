@echo off
color 5
echo LOADING ADMIN PANEL...
timeout 2 > NUL
echo LOADING UTILS (CAN TAKE A WHILE)...
timeout 5 > NUL


:: Vérifie si le script est exécuté en tant qu'administrateur
net session >nul 2>&1
if %errorlevel% neq 0 (
    :: Si le script n'est pas en administrateur, affiche le menu admin
    goto adminMenu
) else (
    :: Si le script est déjà en administrateur, lance directement le menu principal
    goto menu
)

:adminMenu
cls
echo ===================================================
echo        Admin Check - Menu
echo ===================================================
echo 1. Run as Admin
echo 2. Run Script (Bypass Admin Check)
echo 3. Install Telnet and Wmic (PC RESTART REQUIRED)
echo 4. Exit
echo.
set /p choice="Enter your choice (1-4): "

if "%choice%"=="1" goto runAsAdmin
if "%choice%"=="2" goto runScript
if "%choice%"=="3" goto installTelnet
if "%choice%"=="4" exit
goto adminMenu

:runAsAdmin
cls
echo To run the script as an administrator, we will restart it with elevated privileges.
echo.
echo Please allow the User Account Control (UAC) prompt.
powershell -Command "Start-Process '%~f0' -Verb RunAs"
exit

:runScript
cls
echo Running the script without checking for administrator privileges...
:: Insert your script's main functionality here, or commands you want to run
echo This is a bypassed script execution (no admin required).
pause
goto menu

:installTelnet
cls
echo Installing Telnet...
:: Vérifie si Telnet est déjà installé
dism /online /enable-feature /featurename:TelnetClient /all /norestart
DISM /Online /Add-Capability /CapabilityName:WMIC~~~~
echo Telnet installation is complete. If you see no errors, Telnet was installed successfully.
pause
goto adminMenu

:menu
cls
echo ===================================================
echo        Main Script Menu
echo ===================================================
echo 1. List files in the current directory
echo 2. Display network details
echo 3. Open Task Manager
echo 4. Check Internet connectivity (ping)
echo 5. Clear the screen
echo 6. Create a new folder
echo 7. Delete a file
echo 8. Display running processes
echo 9. Test a network port
echo 10. Start a Windows service
echo 11. Stop a Windows service
echo 12. Restart the computer
echo 13. Show environment variables
echo 14. Search for a file in a directory
echo 15. Create a text file
echo 16. Read a text file
echo 17. Check disk space
echo 18. View active user sessions
echo 19. Display system information
echo 20. Exit
echo.
set /p choice="Enter your choice (1-20): "

if "%choice%"=="1" goto listFiles
if "%choice%"=="2" goto networkDetails
if "%choice%"=="3" goto taskManager
if "%choice%"=="4" goto pingTest
if "%choice%"=="5" goto clearScreen
if "%choice%"=="6" goto createFolder
if "%choice%"=="7" goto deleteFile
if "%choice%"=="8" goto displayProcesses
if "%choice%"=="9" goto testPort
if "%choice%"=="10" goto startService
if "%choice%"=="11" goto stopService
if "%choice%"=="12" goto restartPC
if "%choice%"=="13" goto environmentVariables
if "%choice%"=="14" goto searchFile
if "%choice%"=="15" goto createTextFile
if "%choice%"=="16" goto readTextFile
if "%choice%"=="17" goto checkDiskSpace
if "%choice%"=="18" goto activeSessions
if "%choice%"=="19" goto systemInfo
if "%choice%"=="20" exit
goto menu

:listFiles
cls
dir
pause
goto menu

:networkDetails
cls
ipconfig /all
pause
goto menu

:taskManager
cls
start taskmgr
pause
goto menu

:pingTest
cls
set /p site="Enter a URL or IP address to ping: "
ping %site%
pause
goto menu

:clearScreen
cls
echo The screen has been cleared.
pause
goto menu

:createFolder
cls
set /p folder="Enter the name of the new folder: "
mkdir "%folder%"
echo Folder "%folder%" created.
pause
goto menu

:deleteFile
cls
set /p file="Enter the full path of the file to delete: "
del "%file%"
echo File "%file%" deleted.
pause
goto menu

:displayProcesses
cls
tasklist
pause
goto menu

:testPort
cls
set /p address="Enter the IP address: "
set /p port="Enter the port number: "
echo Press Ctrl+C to exit if it takes too long.
timeout /t 2 >nul
telnet %address% %port%
pause
goto menu

:startService
cls
set /p service="Enter the name of the service to start: "
net start "%service%"
pause
goto menu

:stopService
cls
set /p service="Enter the name of the service to stop: "
net stop "%service%"
pause
goto menu

:restartPC
cls
echo The PC will restart in 10 seconds. Press Ctrl+C to cancel.
shutdown /r /t 10
pause
goto menu

:environmentVariables
cls
set
pause
goto menu

:searchFile
cls
set /p path="Enter the directory to search: "
set /p name="Enter the name or part of the file name: "
dir "%path%\%name%" /s /p
pause
goto menu

:createTextFile
cls
set /p name="Enter the name of the text file to create: "
echo Enter the content of the file (finish with Ctrl+Z):
copy con "%name%"
pause
goto menu

:readTextFile
cls
set /p file="Enter the full path of the text file to read: "
type "%file%"
pause
goto menu

:checkDiskSpace
cls
echo Checking disk space:
echo ----------------------------------
wmic logicaldisk get size,freespace,caption
pause
goto menu

:activeSessions
cls
query user
pause
goto menu

:systemInfo
cls
systeminfo
pause
goto menu
 