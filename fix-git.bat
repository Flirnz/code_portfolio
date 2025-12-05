@echo off
echo ===========================================
echo Fixing Git Setup for code-Protfolio
echo ===========================================
echo.

echo 1. Removing existing remote if any...
git remote remove origin 2>nul

echo 2. Adding GitHub remote...
git remote add origin https://github.com/Flirnz/code-Portfolio.git

echo 3. Verifying remote...
git remote -v

echo 4. Checking current status...
git status

echo 5. Trying to pull from GitHub (with merge if needed)...
git pull origin main --allow-unrelated-histories --no-edit

if %ERRORLEVEL% NEQ 0 (
    echo Pull failed or not needed, trying force push...
    echo 6. Force pushing to GitHub...
    git push -u origin main --force
) else (
    echo 6. Pushing changes...
    git push origin main
)

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ✅ SUCCESS! Your repository is now synced with GitHub.
    echo.
    echo Your GitHub URL: https://github.com/Flirnz/code-Portfolio
    echo.
    echo On your laptop, run:
    echo   git clone https://github.com/Flirnz/code-Portfolio.git
) else (
    echo.
    echo ❌ Something went wrong. Trying alternative approach...
    echo.
    echo Trying direct force push...
    git push -u origin main --force
)

pause