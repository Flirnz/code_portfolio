@echo off
title PHP Project Linker to XAMPP
color 0A

:: ========================================
:: Configuration - EDIT THESE PATHS
:: ========================================
set "HTDOCS_PATH=D:\Programm files\XAMPP\htdocs\my-php-project"
set "PHP_PROJECTS_PATH=%cd%"

:: ========================================
:: Main Menu
:: ========================================
:menu
cls
echo ========================================
echo LINK PHP PROJECTS to XAMPP
echo ========================================
echo.
echo XAMPP htdocs: %HTDOCS_PATH%
echo PHP Projects: %PHP_PROJECTS_PATH%
echo ========================================
echo.
echo [1] List PHP projects
echo [2] Link a project to htdocs
echo [3] Link ALL projects
echo [4] Unlink a project
echo [5] Create new PHP project
echo [6] Test in browser
echo [7] Start XAMPP
echo [8] Fix permission issues
echo [0] Exit
echo.
set /p choice="Select option (0-8): "

if "%choice%"=="1" goto list_projects
if "%choice%"=="2" goto link_project
if "%choice%"=="3" goto link_all
if "%choice%"=="4" goto unlink_project
if "%choice%"=="5" goto create_project
if "%choice%"=="6" goto test_browser
if "%choice%"=="7" goto start_xampp
if "%choice%"=="8" goto fix_permissions
if "%choice%"=="0" exit /b

echo Invalid choice!
timeout /t 2
goto menu

:: ========================================
:: 1. List PHP Projects
:: ========================================
:list_projects
cls
echo ========================================
echo PHP PROJECTS LIST
echo ========================================
echo.
echo In your portfolio (php-projects folder):
echo ----------------------------------------
if exist "%PHP_PROJECTS_PATH%" (
    dir "%PHP_PROJECTS_PATH%" /b /ad
) else (
    echo No php-projects folder found!
    echo Creating it now...
    mkdir "%PHP_PROJECTS_PATH%"
)
echo.

echo In XAMPP htdocs (linked projects):
echo ----------------------------------
if exist "%HTDOCS_PATH%" (
    dir "%HTDOCS_PATH%" /b /ad
) else (
    echo [ERROR] XAMPP htdocs not found at: %HTDOCS_PATH%
)
echo.

echo Linked projects (with status):
echo ------------------------------
if exist "%HTDOCS_PATH%" (
    for /d %%i in ("%HTDOCS_PATH%\*") do (
        set "project=%%~nxi"
        if exist "%PHP_PROJECTS_PATH%\!project!\" (
            echo [LINKED] !project! -> http://localhost/!project!/
        ) else (
            echo [ORPHAN] !project! (not in portfolio)
        )
    )
)
echo.
pause
goto menu

:: ========================================
:: 2. Link a Project to htdocs
:: ========================================
:link_project
cls
echo ========================================
echo LINK PHP PROJECT to XAMPP
echo ========================================
echo.

:: Check if folders exist
if not exist "%HTDOCS_PATH%" (
    echo [ERROR] XAMPP htdocs not found at: %HTDOCS_PATH%
    echo Please check XAMPP installation.
    echo.
    pause
    goto menu
)

if not exist "%PHP_PROJECTS_PATH%" (
    echo Creating php-projects folder...
    mkdir "%PHP_PROJECTS_PATH%"
)

:: List available projects
echo Available PHP projects in portfolio:
echo -----------------------------------
if exist "%PHP_PROJECTS_PATH%" (
    dir "%PHP_PROJECTS_PATH%" /b /ad
) else (
    echo No projects found!
)
echo.

:: Get project name
set /p project_name="Enter project name to link: "
if "%project_name%"=="" (
    echo Project name cannot be empty!
    timeout /t 2
    goto link_project
)

:: Check if project exists in portfolio
if not exist "%PHP_PROJECTS_PATH%\%project_name%\" (
    echo.
    echo [ERROR] Project not found in: %PHP_PROJECTS_PATH%\%project_name%
    set /p create="Create this project? (y/n): "
    if /i "%create%"=="y" goto create_specific
    goto link_project
)

:: Check if already linked in htdocs
if exist "%HTDOCS_PATH%\%project_name%" (
    echo.
    echo [WARNING] Project already exists in htdocs!
    echo Type: %HTDOCS_PATH%\%project_name%
    attrib "%HTDOCS_PATH%\%project_name%"
    echo.
    set /p action="Choose: [1] Overwrite [2] Skip [3] Backup and replace: "
    
    if "%action%"=="1" (
        rmdir /s /q "%HTDOCS_PATH%\%project_name%" 2>nul
        echo Removed existing folder.
    ) else if "%action%"=="2" (
        echo Skipping...
        goto after_link
    ) else if "%action%"=="3" (
        set "backup_path=%HTDOCS_PATH%\%project_name%-backup-%date:~10,4%%date:~4,2%%date:~7,2%"
        echo Backing up to: !backup_path!
        move "%HTDOCS_PATH%\%project_name%" "!backup_path!" 2>nul
    )
)

:: Create the link
echo.
echo Creating link for: %project_name%
echo From: %PHP_PROJECTS_PATH%\%project_name%
echo To:   %HTDOCS_PATH%\%project_name%
echo.

:: Try different methods
echo Attempt 1: Creating Junction (recommended)...
mklink /J "%HTDOCS_PATH%\%project_name%" "%PHP_PROJECTS_PATH%\%project_name%"

if errorlevel 1 (
    echo Junction failed. Attempt 2: Creating Symlink...
    mklink /D "%HTDOCS_PATH%\%project_name%" "%PHP_PROJECTS_PATH%\%project_name%"
    
    if errorlevel 1 (
        echo Symlink failed. Attempt 3: Copying files...
        xcopy "%PHP_PROJECTS_PATH%\%project_name%" "%HTDOCS_PATH%\%project_name%\" /E /I /Y
        echo [INFO] Files copied (not linked). Changes won't sync automatically.
    ) else (
        echo [SUCCESS] Symlink created!
    )
) else (
    echo [SUCCESS] Junction created!
)

:after_link
echo.
echo Project will be accessible at: http://localhost/%project_name%/
echo.
echo Important: Always edit files in: %PHP_PROJECTS_PATH%\%project_name%\
echo.
pause
goto menu

:create_specific
call :create_project_logic "%project_name%"
goto link_project

:: ========================================
:: 3. Link ALL Projects
:: ========================================
:link_all
cls
echo ========================================
echo LINK ALL PHP PROJECTS
echo ========================================
echo.
echo This will link every project in your portfolio to XAMPP.
echo.
set /p confirm="Continue? (y/n): "
if /i not "%confirm%"=="y" goto menu

if not exist "%PHP_PROJECTS_PATH%" (
    echo No php-projects folder found!
    pause
    goto menu
)

set "count=0"
for /d %%i in ("%PHP_PROJECTS_PATH%\*") do (
    set "project=%%~nxi"
    set /a count+=1
    
    echo.
    echo [%count%] Processing: !project!
    
    if exist "%HTDOCS_PATH%\!project!" (
        echo Already exists in htdocs, skipping...
    ) else (
        echo Creating link...
        mklink /J "%HTDOCS_PATH%\!project!" "%%i" 2>nul
        if errorlevel 1 (
            echo Failed to create junction, copying instead...
            xcopy "%%i" "%HTDOCS_PATH%\!project!\" /E /I /Y
        )
    )
)

echo.
echo [DONE] Processed %count% projects.
echo Access them at: http://localhost/
echo.
pause
goto menu

:: ========================================
:: 4. Unlink a Project
:: ========================================
:unlink_project
cls
echo ========================================
echo UNLINK PHP PROJECT
echo ========================================
echo.

echo Projects currently in htdocs:
echo -----------------------------
if exist "%HTDOCS_PATH%" (
    dir "%HTDOCS_PATH%" /b /ad
) else (
    echo No htdocs folder found!
    pause
    goto menu
)
echo.

set /p project_name="Enter project name to unlink: "
if "%project_name%"=="" goto menu

if not exist "%HTDOCS_PATH%\%project_name%" (
    echo Project not found in htdocs!
    pause
    goto menu
)

echo.
echo Project: %project_name%
echo Location: %HTDOCS_PATH%\%project_name%
echo.

:: Check if it's a link or regular folder
dir /al "%HTDOCS_PATH%\%project_name%" 2>nul >nul
if errorlevel 1 (
    echo This is a regular folder (not a link).
    set /p action="Delete folder and all contents? (y/n): "
    if /i "%action%"=="y" (
        rmdir /s /q "%HTDOCS_PATH%\%project_name%"
        echo Folder deleted.
    )
) else (
    echo This is a junction/symlink.
    set /p action="Remove link? (y/n): "
    if /i "%action%"=="y" (
        rmdir "%HTDOCS_PATH%\%project_name%"
        echo Link removed (original files untouched).
    )
)

echo.
pause
goto menu

:: ========================================
:: 5. Create New PHP Project
:: ========================================
:create_project
cls
echo ========================================
echo CREATE NEW PHP PROJECT
echo ========================================
echo.
set /p project_name="Enter project name: "
if "%project_name%"=="" goto menu

call :create_project_logic "%project_name%"
pause
goto menu

:: Function to create project
:create_project_logic
set "project_name=%~1"
set "project_path=%PHP_PROJECTS_PATH%\%project_name%"

if exist "%project_path%" (
    echo [ERROR] Project already exists!
    goto :eof
)

echo.
echo Creating project structure...
mkdir "%project_path%"
mkdir "%project_path%\css"
mkdir "%project_path%\js"
mkdir "%project_path%\images"
mkdir "%project_path%\includes"

:: Create index.php
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
echo     ^<p^>This is a PHP project.^</p^>
echo     ^<?php
echo         echo "Hello from PHP!";
echo         echo ^"^<p^>Server time: ^" . date('Y-m-d H:i:s') . ^"^</p^>";
echo         echo ^"^<p^>PHP Version: ^" . phpversion() . ^"^</p^>";
echo     ?^>
echo     ^<script src="js/script.js"^>^</script^>
echo ^</body^>
echo ^</html^>
) > "%project_path%\index.php"

:: Create CSS file
(
echo /* %project_name% - Main Styles */
echo body {
echo     font-family: Arial, sans-serif;
echo     margin: 20px;
echo     background-color: #f5f5f5;
echo }
echo h1 {
echo     color: #333;
echo     border-bottom: 2px solid #007bff;
echo     padding-bottom: 10px;
echo }
) > "%project_path%\css\style.css"

:: Create JS file
(
// %project_name% - Main JavaScript
console.log('%project_name% loaded successfully!');
document.addEventListener('DOMContentLoaded', function() {
    console.log('DOM ready');
});
) > "%project_path%\js\script.js"

:: Create README
(
# %project_name%
PHP Project

## Description
Your PHP project description here.

## Setup
1. Link to XAMPP using the PHP Linker
2. Access at: http://localhost/%project_name%/
3. Start coding!

## File Structure
- index.php - Main entry point
- css/style.css - Styles
- js/script.js - JavaScript
- images/ - Image assets
- includes/ - PHP includes

## Development
- Always edit files in: %PHP_PROJECTS_PATH%\%project_name%\
- Files are linked to XAMPP automatically
- Use Git for version control
) > "%project_path%\README.md"

:: Create test PHP file
(
^<?php
// Test PHP functionality
echo ^"^<h2^>PHP Info Test^</h2^>";
phpinfo();
?^>
) > "%project_path%\test.php"

echo [SUCCESS] Project created at: %project_path%
echo.
set /p link_now="Link to XAMPP now? (y/n): "
if /i "!link_now!"=="y" (
    echo Creating link...
    mklink /J "%HTDOCS_PATH%\%project_name%" "%project_path%" 2>nul
    if errorlevel 1 (
        echo Failed to create link. You can link it manually from the main menu.
    ) else (
        echo Linked! Access at: http://localhost/%project_name%/
    )
)
goto :eof

:: ========================================
:: 6. Test in Browser
:: ========================================
:test_browser
cls
echo ========================================
echo TEST IN BROWSER
echo ========================================
echo.

echo Available projects in htdocs:
echo -----------------------------
if exist "%HTDOCS_PATH%" (
    dir "%HTDOCS_PATH%" /b /ad
) else (
    echo No projects found!
    pause
    goto menu
)
echo.

set /p project_name="Enter project name to test: "
if "%project_name%"=="" goto menu

if exist "%HTDOCS_PATH%\%project_name%" (
    echo Opening: http://localhost/%project_name%/
    start http://localhost/%project_name%/
) else (
    echo Project not found in htdocs!
)

echo.
pause
goto menu

:: ========================================
:: 7. Start XAMPP
:: ========================================
:start_xampp
cls
echo ========================================
echo START XAMPP
echo ========================================
echo.

echo [1] Start Apache only
echo [2] Start MySQL only
echo [3] Start both (Apache + MySQL)
echo [4] Open XAMPP Control Panel
echo [5] Check if XAMPP is running
echo [B] Back to menu
echo.
set /p xampp_choice="Select option: "

if "%xampp_choice%"=="1" (
    echo Starting Apache...
    start "" "D:\Programfiles\Xampp\apache_start.bat" 2>nul
    if errorlevel 1 echo Could not start Apache.
) else if "%xampp_choice%"=="2" (
    echo Starting MySQL...
    start "" "D:\Programfiles\Xampp\mysql_start.bat" 2>nul
    if errorlevel 1 echo Could not start MySQL.
) else if "%xampp_choice%"=="3" (
    echo Starting Apache and MySQL...
    start "" "D:\Programfiles\Xampp\xampp_start.exe" 2>nul
    if errorlevel 1 echo Could not start XAMPP.
) else if "%xampp_choice%"=="4" (
    echo Opening XAMPP Control Panel...
    start "" "D:\Programfiles\Xampp\xampp-control.exe"
) else if "%xampp_choice%"=="5" (
    echo Checking XAMPP status...
    tasklist | findstr "httpd.exe" >nul
    if errorlevel 1 (
        echo Apache is NOT running.
    ) else (
        echo Apache is running.
    )
    tasklist | findstr "mysqld.exe" >nul
    if errorlevel 1 (
        echo MySQL is NOT running.
    ) else (
        echo MySQL is running.
    )
) else if /i "%xampp_choice%"=="b" (
    goto menu
)

echo.
pause
goto start_xampp

:: ========================================
:: 8. Fix Permission Issues
:: ========================================
:fix_permissions
cls
echo ========================================
echo FIX PERMISSION ISSUES
echo ========================================
echo.

echo Common fixes for XAMPP problems:
echo.
echo [1] Fix "Access denied" errors
echo [2] Fix port conflicts (Apache won't start)
echo [3] Reset XAMPP configuration
echo [4] Reinstall XAMPP
echo [B] Back to menu
echo.
set /p fix_choice="Select option: "

if "%fix_choice%"=="1" (
    echo.
    echo Fixing folder permissions...
    echo Run Command Prompt as Administrator and execute:
    echo   icacls "D:\Programfiles\Xampp\htdocs" /grant Users:(OI)(CI)F
    echo.
    echo This gives Users full control over htdocs folder.
) else if "%fix_choice%"=="2" (
    echo.
    echo Fixing port conflicts:
    echo 1. Open XAMPP Control Panel
    echo 2. Click Config button next to Apache
    echo 3. Select httpd.conf
    echo 4. Change "Listen 80" to "Listen 8080"
    echo 5. Save and restart Apache
    echo 6. Access via: http://localhost:8080/
) else if "%fix_choice%"=="3" (
    echo.
    echo WARNING: This will reset XAMPP to defaults!
    echo Backing up htdocs folder...
    xcopy "D:\Programfiles\Xampp\htdocs" "D:\Programfiles\Xampp\htdocs-backup-%date:~10,4%%date:~4,2%%date:~7,2%" /E /I /Y
    echo Backup created.
    echo.
    echo To reset XAMPP:
    echo 1. Stop all services
    echo 2. Delete files in: D:\Programfiles\Xampp\apache\conf\
    echo 3. Delete files in: D:\Programfiles\Xampp\mysql\data\
    echo 4. Reinstall XAMPP or restore from backup
) else if "%fix_choice%"=="4" (
    echo.
    echo To reinstall XAMPP:
    echo 1. Backup your htdocs folder
    echo 2. Uninstall XAMPP
    echo 3. Delete leftover folder: D:\Programfiles\Xampp\
    echo 4. Download fresh XAMPP from: https://www.apachefriends.org/
    echo 5. Install and restore htdocs backup
) else if /i "%fix_choice%"=="b" (
    goto menu
)

echo.
pause
goto fix_permissions

:: ========================================
:: End of Script
:: ========================================