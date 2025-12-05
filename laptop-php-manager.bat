@echo off
title PHP Project Manager
color 0A

:menu
cls
echo ========================================
echo PHP Project Manager for XAMPP
echo ========================================
echo.
echo [1] List all PHP projects
echo [2] Create new PHP project
echo [3] Link project to XAMPP
echo [4] Open project in browser
echo [5] Open project in VS Code
echo [6] Start XAMPP Apache
echo [7] Stop XAMPP Apache
echo [8] Sync with Git
echo [9] Exit
echo.
set /p choice="Select option (1-9): "

if "%choice%"=="1" goto list_projects
if "%choice%"=="2" goto create_project
if "%choice%"=="3" goto link_project
if "%choice%"=="4" goto open_browser
if "%choice%"=="5" goto open_vscode
if "%choice%"=="6" goto start_xampp
if "%choice%"=="7" goto stop_xampp
if "%choice%"=="8" goto sync_git
if "%choice%"=="9" exit /b

echo Invalid choice! Press any key...
pause >nul
goto menu

:list_projects
cls
echo PHP Projects:
echo =============
echo.
echo In portfolio (D:\code-Portfolio\Dev\php-projects\):
dir "D:\code-Portfolio\Dev\php-projects" /b /ad
echo.
echo In XAMPP htdocs (D:\Programfiles\Xampp\htdocs\):
dir "D:\Programfiles\Xampp\htdocs" /b /ad
echo.
echo Press any key to continue...
pause >nul
goto menu

:create_project
cls
echo Create New PHP Project
echo ======================
echo.
set /p project_name=Enter project name: 

if "%project_name%"=="" (
    echo Project name cannot be empty!
    timeout /t 2
    goto create_project
)

set "project_path=D:\code-Portfolio\Dev\php-projects\%project_name%"

if exist "%project_path%" (
    echo Project already exists!
    timeout /t 2
    goto create_project
)

echo Creating project structure...
mkdir "%project_path%"
mkdir "%project_path%\css"
mkdir "%project_path%\js"
mkdir "%project_path%\images"

echo Creating index.php...
(
echo ^<!DOCTYPE html^>
echo ^<html lang="en"^>
echo ^<head^>
echo     ^<meta charset="UTF-8"^>
echo     ^<meta name="viewport" content="width=device-width, initial-scale=1.0"^>
echo     ^<title^>%project_name%^</title^>
echo     ^<link rel="stylesheet" href="css/style.css"^>
echo ^</head^>
echo ^<body^>
echo     ^<h1^>Welcome to %project_name%^</h1^>
echo     ^<?php
echo         echo "Hello from PHP!";
echo         echo ^"^<p^>Server time: ^" . date('Y-m-d H:i:s') . ^"^</p^>";
echo     ?^>
echo     ^<script src="js/script.js"^>^</script^>
echo ^</body^>
echo ^</html^>
) > "%project_path%\index.php"

echo Creating CSS file...
(
echo /* %project_name% - Main Styles */
echo body {
echo     font-family: Arial, sans-serif;
echo     margin: 20px;
echo     background-color: #f5f5f5;
echo }
echo h1 {
echo     color: #333;
echo }
) > "%project_path%\css\style.css"

echo Creating JS file...
(
// %project_name% - Main JavaScript
console.log('%project_name% loaded!');
) > "%project_path%\js\script.js"

echo Creating README...
(
# %project_name%
PHP Project

Created on: %date%

## Description
Your PHP project description here.

## Setup
1. Link to XAMPP using the PHP Manager
2. Access at: http://localhost/%project_name%/
3. Start coding!

## Features
- PHP backend
- HTML/CSS/JS frontend
- Ready for development
) > "%project_path%\README.md"

echo ✅ Project created at: %project_path%
echo.
echo Would you like to link it to XAMPP now? (y/n)
set /p link_now=
if /i "%link_now%"=="y" goto link_specific

echo Press any key to continue...
pause >nul
goto menu

:link_specific
set "link_project=%project_name%"
goto do_link

:link_project
cls
echo Link Project to XAMPP
echo =====================
echo.
echo Available projects:
dir "D:\code-Portfolio\Dev\php-projects" /b /ad
echo.
set /p link_project=Enter project name to link: 

if not exist "D:\code-Portfolio\Dev\php-projects\%link_project%" (
    echo Project not found!
    timeout /t 2
    goto link_project
)

:do_link
echo Creating junction...
mklink /J "D:\Programfiles\Xampp\htdocs\%link_project%" "D:\code-Portfolio\Dev\php-projects\%link_project%" 2>nul

if errorlevel 1 (
    echo Failed to create junction. Copying files instead...
    xcopy "D:\code-Portfolio\Dev\php-projects\%link_project%" "D:\Programfiles\Xampp\htdocs\%link_project%\" /E /I /Y
    echo ✅ Copied %link_project% to htdocs
) else (
    echo ✅ Created junction for %link_project%
)

echo.
echo Access at: http://localhost/%link_project%/
timeout /t 3
goto menu

:open_browser
cls
echo Open Project in Browser
echo =======================
echo.
dir "D:\Programfiles\Xampp\htdocs" /b /ad
echo.
set /p open_project=Enter project name: 

if exist "D:\Programfiles\Xampp\htdocs\%open_project%" (
    start http://localhost/%open_project%/
    echo ✅ Opening: http://localhost/%open_project%/
) else (
    echo Project not found in htdocs!
)

timeout /t 2
goto menu

:open_vscode
cls
echo Open Project in VS Code
echo =======================
echo.
dir "D:\code-Portfolio\Dev\php-projects" /b /ad
echo.
set /p code_project=Enter project name: 

if exist "D:\code-Portfolio\Dev\php-projects\%code_project%" (
    code "D:\code-Portfolio\Dev\php-projects\%code_project%"
    echo ✅ Opening in VS Code...
) else (
    echo Project not found!
)

timeout /t 2
goto menu

:start_xampp
cls
echo Starting XAMPP Apache...
echo.
if exist "D:\Programfiles\Xampp\xampp-control.exe" (
    start "" "D:\Programfiles\Xampp\xampp-control.exe"
    echo XAMPP Control Panel opened. Please start Apache manually.
) else (
    echo XAMPP control panel not found!
)

timeout /t 3
goto menu

:stop_xampp
cls
echo Stopping XAMPP...
echo.
echo Please stop Apache from XAMPP Control Panel.
echo.
timeout /t 3
goto menu

:sync_git
cls
echo Syncing with Git
echo ================
echo.
cd /d "D:\code-Portfolio"
echo Adding PHP projects to Git...
git add "Dev/php-projects/"
set /p commit_msg="Enter commit message: "
git commit -m "%commit_msg%"
git push origin main
echo.
echo ✅ PHP projects synced to GitHub!
timeout /t 3
goto menu