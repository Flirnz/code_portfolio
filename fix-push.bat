@echo off
echo ========================================
echo Fixing Large Push Timeout
echo ========================================
echo.

echo Step 1: Optimizing Git for large pushes...
git config http.postBuffer 524288000
git config http.lowSpeedLimit 0
git config http.lowSpeedTime 999999

echo.
echo Step 2: Checking what was already pushed...
git fsck
git count-objects -v

echo.
echo Step 3: Trying incremental push...
echo Pushing in smaller chunks...

REM Try pushing commits in batches
git log --oneline -10
echo.
set /p choice="Push last 5 commits? (y/n): "
if /i "%choice%"=="y" (
    git push origin HEAD~5:master --force
    timeout /t 5
    git push origin master --force
) else (
    echo Trying full push with compression...
    git push origin master --force --verbose
)

echo.
if %ERRORLEVEL% EQU 0 (
    echo ✅ Push successful!
) else (
    echo ❌ Push failed. Trying alternative method...
    echo.
    echo Step 4: Using Git LFS for large files...
    git lfs install
    git lfs track "*.psd"
    git lfs track "*.zip"
    git lfs track "*.exe"
    git add .gitattributes
    git commit -m "Add Git LFS tracking"
    git push origin master --force
)

echo.
pause