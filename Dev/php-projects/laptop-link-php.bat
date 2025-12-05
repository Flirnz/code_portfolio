@echo off
echo ========================================
echo Link PHP Projects to XAMPP
echo ========================================
echo.

echo Your paths:
echo XAMPP htdocs: D:\Programfiles\Xampp\htdocs
echo PHP Projects: D:\code-Portfolio\Dev\php-projects
echo.

REM Check if folders exist
if not exist "D:\Programfiles\Xampp\htdocs" (
    echo ❌ XAMPP htdocs folder not found!
    echo Please check if XAMPP is installed at: D:\Programfiles\Xampp\
    pause
    exit /b 1
)

if not exist "D:\code-Portfolio\Dev\php-projects" (
    echo Creating php-projects folder...
    mkdir "D:\code-Portfolio\Dev\php-projects"
)

echo Step 1: Listing current PHP projects...
echo.
echo In your portfolio (php-projects folder):
dir "D:\code-Portfolio\Dev\php-projects" /b /ad
echo.

echo In XAMPP htdocs:
dir "D:\Programfiles\Xampp\htdocs" /b /ad
echo.

echo Step 2: Creating links...
echo.
set /p choice="Create links for ALL projects? (y/n): "

if /i "%choice%"=="y" (
    echo Creating links for all projects...
    for /d %%i in ("D:\code-Portfolio\Dev\php-projects\*") do (
        set "project=%%~nxi"
        set "target_path=D:\Programfiles\Xampp\htdocs\!project!"
        
        if exist "!target_path!" (
            echo !project! already exists in htdocs
        ) else (
            echo Creating link for !project!...
            
            REM Try different methods
            REM Method 1: Symlink (requires admin)
            REM mklink /D "!target_path!" "%%i"
            
            REM Method 2: Junction (works without admin on same drive)
            mklink /J "!target_path!" "%%i" 2>nul
            
            if errorlevel 1 (
                echo ❌ Failed to create link for !project!
                echo Trying to copy instead...
                xcopy "%%i" "!target_path!\" /E /I /Y
                echo ✅ Copied !project! to htdocs
            ) else (
                echo ✅ Created junction: !project!
            )
        )
    )
) else (
    echo.
    echo Step 3: Select project to link...
    echo Available projects:
    dir "D:\code-Portfolio\Dev\php-projects" /b /ad
    echo.
    set /p project_name="Enter project name: "
    
    if not exist "D:\code-Portfolio\Dev\php-projects\%project_name%" (
        echo ❌ Project not found!
        pause
        exit /b 1
    )
    
    set "target_path=D:\Programfiles\Xampp\htdocs\%project_name%"
    
    if exist "!target_path!" (
        echo ❌ Project already exists in htdocs!
        set /p overwrite="Overwrite? (y/n): "
        if /i "!overwrite!"=="y" (
            rmdir /s /q "!target_path!" 2>nul
        ) else (
            echo Cancelled.
            pause
            exit /b
        )
    )
    
    echo Creating link for %project_name%...
    
    REM Try junction first (no admin needed)
    mklink /J "!target_path!" "D:\code-Portfolio\Dev\php-projects\%project_name%"
    
    if errorlevel 1 (
        echo Failed to create junction. Trying to copy instead...
        xcopy "D:\code-Portfolio\Dev\php-projects\%project_name%" "!target_path!\" /E /I /Y
        echo ✅ Copied %project_name% to htdocs
    ) else (
        echo ✅ Created junction for %project_name%
    )
)

echo.
echo Step 4: Testing setup...
echo.
echo Your PHP projects are now accessible at:
for /d %%i in ("D:\Programfiles\Xampp\htdocs\*") do (
    echo   http://localhost/%%~nxi/
)

echo.
echo Important notes:
echo 1. Always save your PHP files in: D:\code-Portfolio\Dev\php-projects\
echo 2. The htdocs folder will show them via links
echo 3. Run this script again if you add new projects
echo 4. Make sure XAMPP Apache is running
echo.
echo To test, open browser and go to: http://localhost/
echo.
pause