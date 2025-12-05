@echo off
title Git Manager for Code Portfolio
color 0A
setlocal enabledelayedexpansion

:: ========================================
:: Detect system and set paths
:: ========================================
set "pc_path=D:\code_portfolio"
set "laptop_path=D:\code-Portfolio"
set "repo_url=https://github.com/Flirnz/code_portfolio.git"

:: Auto-detect current system
if exist "D:\code_portfolio\.git" (
    set "repo_root=D:\code_portfolio"
    set "system_name=PC"
) else if exist "D:\code-Portfolio\.git" (
    set "repo_root=D:\code-Portfolio"
    set "system_name=Laptop"
) else (
    echo ❌ Git repository not found!
    echo Searching for Git repository...
    
    :: Try to find .git folder in current directory or parent
    cd /d "%~dp0"
    for %%i in (.) do set "current_dir=%%~fi"
    
    :find_git
    if exist "!current_dir!\.git" (
        set "repo_root=!current_dir!"
        echo ✅ Found Git repository at: !repo_root!
        timeout /t 2
        goto :git_found
    )
    
    :: Move up one directory
    set "parent_dir=!current_dir!\.."
    cd /d "!parent_dir!"
    for %%i in (.) do set "current_dir=%%~fi"
    
    if not "!current_dir!"=="!parent_dir!" goto :find_git
    
    :: Ask user for path
    echo Could not auto-detect Git repository.
    set /p repo_root="Enter path to your code portfolio: "
    
    if not exist "!repo_root!\.git" (
        echo ❌ Not a Git repository!
        pause
        exit /b 1
    )
)

:git_found
cd /d "!repo_root!"

:: ========================================
:: Main Menu
:: ========================================
:main_menu
cls
echo ========================================
echo GIT MANAGER - Code Portfolio
echo ========================================
echo System: !system_name!
echo Repository: !repo_root!
echo Remote: %repo_url%
echo ========================================
echo.
echo [1]  Push to GitHub (Sync UP)
echo [2]  Pull from GitHub (Sync DOWN)
echo [3]  Sync Both Ways (Pull then Push)
echo [4]  Status Check
echo [5]  Commit Changes
echo [6]  View Log / History
echo [7]  Branch Operations
echo [8]  Fix Common Issues
echo [9]  Setup / Configure
echo [10] PHP Projects Manager
echo [11] Backup & Restore
echo [0]  Exit
echo.
set /p choice="Select option (0-11): "

if "%choice%"=="1" goto push_git
if "%choice%"=="2" goto pull_git
if "%choice%"=="3" goto sync_git
if "%choice%"=="4" goto status_git
if "%choice%"=="5" goto commit_git
if "%choice%"=="6" goto log_git
if "%choice%"=="7" goto branch_git
if "%choice%"=="8" goto fix_git
if "%choice%"=="9" goto setup_git
if "%choice%"=="10" goto php_manager
if "%choice%"=="11" goto backup_git
if "%choice%"=="0" exit /b

echo Invalid choice!
timeout /t 2
goto main_menu

:: ========================================
:: 1. Push to GitHub
:: ========================================
:push_git
cls
echo ========================================
echo PUSH to GitHub
echo ========================================
echo.
echo Current branch: 
git branch --show-current
echo.
echo Step 1: Checking status...
git status

echo.
echo Step 2: Adding all changes...
git add .

echo.
echo Step 3: Committing...
set /p commit_msg="Enter commit message: "
if "%commit_msg%"=="" set "commit_msg=Update: %date% %time%"
git commit -m "%commit_msg%"

echo.
echo Step 4: Pushing to GitHub...
git push origin main

if !errorlevel! equ 0 (
    echo.
    echo ✅ Push successful!
    echo Changes sent to: %repo_url%
) else (
    echo.
    echo ❌ Push failed!
    echo Error code: !errorlevel!
)

echo.
pause
goto main_menu

:: ========================================
:: 2. Pull from GitHub
:: ========================================
:pull_git
cls
echo ========================================
echo PULL from GitHub
echo ========================================
echo.
echo This will download changes from GitHub.
echo Make sure you have committed your local changes first!
echo.
set /p confirm="Continue? (y/n): "
if /i not "%confirm%"=="y" goto main_menu

echo.
echo Pulling changes from GitHub...
git pull origin main

if !errorlevel! equ 0 (
    echo.
    echo ✅ Pull successful!
    echo Local repository updated.
) else (
    echo.
    echo ❌ Pull failed!
    echo Try: git stash, then git pull
    echo.
    set /p stash="Stash changes and try again? (y/n): "
    if /i "%stash%"=="y" (
        git stash
        git pull origin main
        git stash pop
    )
)

echo.
pause
goto main_menu

:: ========================================
:: 3. Sync Both Ways
:: ========================================
:sync_git
cls
echo ========================================
echo SYNC Both Ways (Pull then Push)
echo ========================================
echo.
echo This will:
echo 1. Pull changes from GitHub
echo 2. Push your changes to GitHub
echo.
set /p confirm="Continue? (y/n): "
if /i not "%confirm%"=="y" goto main_menu

echo.
echo Step 1: Pulling from GitHub...
git pull origin main

echo.
echo Step 2: Checking for changes...
git status

echo.
set /p has_changes="Any changes to commit? (y/n): "
if /i "%has_changes%"=="y" (
    echo Adding changes...
    git add .
    set /p sync_msg="Enter commit message: "
    if "%sync_msg%"=="" set "sync_msg=Sync: %date% %time%"
    git commit -m "%sync_msg%"
)

echo.
echo Step 3: Pushing to GitHub...
git push origin main

echo.
echo ✅ Sync complete!
echo.
pause
goto main_menu

:: ========================================
:: 4. Status Check
:: ========================================
:status_git
cls
echo ========================================
echo GIT STATUS
echo ========================================
echo.
echo Repository: !repo_root!
echo Remote: %repo_url%
echo.
echo Current branch:
git branch --show-current
echo.
echo Status:
git status
echo.
echo Recent commits:
git log --oneline -5
echo.
pause
goto main_menu

:: ========================================
:: 5. Commit Changes
:: ========================================
:commit_git
cls
echo ========================================
echo COMMIT Changes
echo ========================================
echo.
echo Step 1: Showing changes...
git status
echo.
echo Step 2: What to commit?
echo [1] All changes
echo [2] Specific files
echo [3] Only staged changes
echo.
set /p commit_choice="Select (1-3): "

if "%commit_choice%"=="1" (
    git add .
) else if "%commit_choice%"=="2" (
    echo.
    echo Available files:
    git status --porcelain
    echo.
    set /p files="Enter file paths (space separated): "
    git add %files%
) else if "%commit_choice%"=="3" (
    echo Using already staged files...
)

echo.
echo Step 3: Committing...
git status
echo.
set /p commit_msg="Enter commit message: "
if "%commit_msg%"=="" (
    echo Commit message cannot be empty!
    timeout /t 2
    goto commit_git
)

git commit -m "%commit_msg%"

echo.
echo ✅ Commit created!
echo.
set /p push_now="Push to GitHub now? (y/n): "
if /i "%push_now%"=="y" (
    git push origin main
)

echo.
pause
goto main_menu

:: ========================================
:: 6. View Log / History
:: ========================================
:log_git
cls
echo ========================================
echo GIT LOG / History
echo ========================================
echo.
echo [1] Last 10 commits
echo [2] Full history
echo [3] Graph view
echo [4] Search commits
echo [5] File history
echo.
set /p log_choice="Select option (1-5): "

if "%log_choice%"=="1" (
    git log --oneline -10
) else if "%log_choice%"=="2" (
    git log --oneline -30
) else if "%log_choice%"=="3" (
    git log --oneline --graph -20
) else if "%log_choice%"=="4" (
    set /p search_term="Search term: "
    git log --oneline --grep="%search_term%" -20
) else if "%log_choice%"=="5" (
    echo.
    echo Available files in current directory:
    dir /b
    echo.
    set /p file_name="Enter filename: "
    if exist "%file_name%" (
        git log --oneline -- "%file_name%"
    ) else (
        echo File not found!
    )
) else (
    goto log_git
)

echo.
pause
goto main_menu

:: ========================================
:: 7. Branch Operations
:: ========================================
:branch_git
cls
echo ========================================
echo BRANCH Operations
echo ========================================
echo.
echo Current branches:
git branch -a
echo.
echo [1] Switch branch
echo [2] Create new branch
echo [3] Delete branch
echo [4] Merge branch
echo [5] Back to main menu
echo.
set /p branch_choice="Select option (1-5): "

if "%branch_choice%"=="1" (
    echo.
    echo Available branches:
    git branch
    echo.
    set /p branch_name="Enter branch name: "
    git checkout %branch_name%
) else if "%branch_choice%"=="2" (
    echo.
    set /p new_branch="New branch name: "
    git checkout -b %new_branch%
) else if "%branch_choice%"=="3" (
    echo.
    echo Available branches:
    git branch
    echo.
    set /p del_branch="Branch to delete: "
    git branch -d %del_branch%
) else if "%branch_choice%"=="4" (
    echo.
    echo Current branch: 
    git branch --show-current
    echo.
    set /p merge_branch="Branch to merge into current: "
    git merge %merge_branch%
) else if "%branch_choice%"=="5" (
    goto main_menu
)

echo.
pause
goto branch_git

:: ========================================
:: 8. Fix Common Issues
:: ========================================
:fix_git
cls
echo ========================================
echo FIX Common Git Issues
echo ========================================
echo.
echo [1] Fix merge conflicts
echo [2] Undo last commit
echo [3] Reset to remote
echo [4] Clean untracked files
echo [5] Fix nested Git repos
echo [6] Fix line endings
echo [7] Fix push/pull errors
echo [8] Back to main menu
echo.
set /p fix_choice="Select option (1-8): "

if "%fix_choice%"=="1" (
    echo.
    echo MERGE CONFLICT RESOLUTION
    echo.
    echo Steps to resolve:
    echo 1. Find conflicted files: git status
    echo 2. Edit files to resolve conflicts
    echo 3. Mark as resolved: git add [file]
    echo 4. Continue merge: git commit
    echo.
    echo Current conflicted files:
    git status | findstr "both"
    echo.
    pause
) else if "%fix_choice%"=="2" (
    echo.
    echo UNDO LAST COMMIT (keep changes)
    echo git reset --soft HEAD~1
    echo.
    set /p confirm="Undo last commit? (y/n): "
    if /i "%confirm%"=="y" (
        git reset --soft HEAD~1
        echo ✅ Last commit undone, changes kept.
    )
) else if "%fix_choice%"=="3" (
    echo.
    echo RESET TO REMOTE (WARNING: loses local changes!)
    echo This will make local match remote exactly.
    echo.
    set /p confirm="Continue? (y/n): "
    if /i "%confirm%"=="y" (
        git fetch origin
        git reset --hard origin/main
        echo ✅ Reset to remote version.
    )
) else if "%fix_choice%"=="4" (
    echo.
    echo CLEAN UNTRACKED FILES
    echo This removes files not tracked by Git.
    echo.
    echo Untracked files:
    git clean -n
    echo.
    set /p confirm="Remove these files? (y/n): "
    if /i "%confirm%"=="y" (
        git clean -f
        echo ✅ Untracked files removed.
    )
) else if "%fix_choice%"=="5" (
    echo.
    echo FIX NESTED GIT REPOSITORIES
    echo This removes .git folders inside subdirectories.
    echo.
    echo Searching for nested .git folders...
    for /r %%i in (.git) do (
        if not "%%i"=="!repo_root!\.git" (
            echo Found: %%i
        )
    )
    echo.
    set /p confirm="Remove all nested .git folders? (y/n): "
    if /i "%confirm%"=="y" (
        for /r %%i in (.git) do (
            if not "%%i"=="!repo_root!\.git" (
                rmdir /s /q "%%i" 2>nul
                echo Removed: %%i
            )
        )
        echo ✅ Nested Git repos removed.
    )
) else if "%fix_choice%"=="6" (
    echo.
    echo FIX LINE ENDINGS
    echo Configures Git for Windows line endings.
    echo.
    git config --global core.autocrlf true
    echo ✅ Line ending configuration updated.
    echo Run: git add --renormalize .
) else if "%fix_choice%"=="7" (
    echo.
    echo FIX PUSH/PULL ERRORS
    echo.
    echo [1] Force push (overwrites remote)
    echo [2] Pull with overwrite
    echo.
    set /p push_fix="Select (1-2): "
    
    if "%push_fix%"=="1" (
        git push origin main --force
        echo ✅ Force push completed.
    ) else if "%push_fix%"=="2" (
        git fetch origin
        git reset --hard origin/main
        echo ✅ Pull with overwrite completed.
    )
) else if "%fix_choice%"=="8" (
    goto main_menu
)

echo.
pause
goto fix_git

:: ========================================
:: 9. Setup / Configure
:: ========================================
:setup_git
cls
echo ========================================
echo SETUP & Configure
echo ========================================
echo.
echo [1] Initialize new repository
echo [2] Clone from GitHub
echo [3] Set up remotes
echo [4] Configure Git user
echo [5] Generate SSH key
echo [6] Back to main menu
echo.
set /p setup_choice="Select option (1-6): "

if "%setup_choice%"=="1" (
    echo.
    echo INITIALIZE NEW REPOSITORY
    echo.
    if exist ".git" (
        echo ❌ Already a Git repository!
    ) else (
        git init
        echo ✅ Git repository initialized.
    )
) else if "%setup_choice%"=="2" (
    echo.
    echo CLONE FROM GITHUB
    echo.
    set /p clone_url="GitHub URL: "
    if "%clone_url%"=="" set "clone_url=%repo_url%"
    set /p clone_dir="Destination folder: "
    if "%clone_dir%"=="" set "clone_dir=."
    git clone "%clone_url%" "%clone_dir%"
    echo ✅ Repository cloned.
) else if "%setup_choice%"=="3" (
    echo.
    echo SET UP REMOTES
    echo.
    echo Current remotes:
    git remote -v
    echo.
    echo [1] Add remote
    echo [2] Remove remote
    echo [3] Change URL
    echo.
    set /p remote_choice="Select (1-3): "
    
    if "%remote_choice%"=="1" (
        set /p remote_name="Remote name (e.g., origin): "
        set /p remote_url="Remote URL: "
        git remote add %remote_name% %remote_url%
        echo ✅ Remote added.
    ) else if "%remote_choice%"=="2" (
        echo Current remotes:
        git remote
        echo.
        set /p remote_name="Remote to remove: "
        git remote remove %remote_name%
        echo ✅ Remote removed.
    ) else if "%remote_choice%"=="3" (
        echo Current remotes:
        git remote -v
        echo.
        set /p remote_name="Remote name: "
        set /p new_url="New URL: "
        git remote set-url %remote_name% %new_url%
        echo ✅ Remote URL updated.
    )
) else if "%setup_choice%"=="4" (
    echo.
    echo CONFIGURE GIT USER
    echo.
    echo Current config:
    git config --list | findstr "user"
    echo.
    set /p user_name="Your name: "
    set /p user_email="Your email: "
    if not "%user_name%"=="" git config --global user.name "%user_name%"
    if not "%user_email%"=="" git config --global user.email "%user_email%"
    echo ✅ User configured.
) else if "%setup_choice%"=="5" (
    echo.
    echo GENERATE SSH KEY
    echo.
    echo This creates SSH key for GitHub authentication.
    echo.
    set /p ssh_email="Your email (for SSH key): "
    ssh-keygen -t rsa -b 4096 -C "%ssh_email%"
    echo.
    echo SSH key generated!
    echo Public key location: %USERPROFILE%\.ssh\id_rsa.pub
    echo Copy this to GitHub: Settings → SSH and GPG keys
) else if "%setup_choice%"=="6" (
    goto main_menu
)

echo.
pause
goto setup_git

:: ========================================
:: 10. PHP Projects Manager
:: ========================================
:php_manager
cls
echo ========================================
echo PHP PROJECTS MANAGER
echo ========================================
echo.
echo [1] List PHP projects
echo [2] Create new PHP project
echo [3] Link to XAMPP
echo [4] Open in browser
echo [5] Open in editor
echo [6] Back to main menu
echo.
set /p php_choice="Select option (1-6): "

if "%php_choice%"=="1" (
    echo.
    echo PHP Projects in: !repo_root!\Dev\php-projects\
    if exist "!repo_root!\Dev\php-projects\" (
        dir "!repo_root!\Dev\php-projects\" /b /ad
    ) else (
        echo No php-projects folder found!
    )
) else if "%php_choice%"=="2" (
    echo.
    set /p php_name="New PHP project name: "
    set "php_path=!repo_root!\Dev\php-projects\%php_name%"
    
    if not exist "!php_path!" (
        mkdir "!php_path!"
        echo ^<!DOCTYPE html^> > "!php_path!\index.php"
        echo ^<html^> >> "!php_path!\index.php"
        echo ^<body^> >> "!php_path!\index.php"
        echo     ^<h1^>Welcome to %php_name%^</h1^> >> "!php_path!\index.php"
        echo     ^<?php phpinfo(); ?^> >> "!php_path!\index.php"
        echo ^</body^> >> "!php_path!\index.php"
        echo ^</html^> >> "!php_path!\index.php"
        
        echo ✅ PHP project created: !php_path!
        echo.
        echo Add to Git? (y/n)
        set /p add_git=
        if /i "!add_git!"=="y" (
            git add "Dev/php-projects/%php_name%"
            git commit -m "Add PHP project: %php_name%"
        )
    ) else (
        echo ❌ Project already exists!
    )
) else if "%php_choice%"=="3" (
    echo.
    echo LINK TO XAMPP
    echo.
    echo This creates a junction/symlink to XAMPP htdocs.
    echo Requires admin privileges.
    echo.
    if exist "!repo_root!\Dev\php-projects\" (
        echo Available projects:
        dir "!repo_root!\Dev\php-projects\" /b /ad
        echo.
        set /p link_project="Project to link: "
        
        if exist "!repo_root!\Dev\php-projects\%link_project%\" (
            echo Creating link...
            mklink /J "D:\Programfiles\Xampp\htdocs\%link_project%" "!repo_root!\Dev\php-projects\%link_project%" 2>nul
            if errorlevel 1 (
                echo ❌ Failed. Try running as administrator.
            ) else (
                echo ✅ Linked: http://localhost/%link_project%/
            )
        ) else (
            echo ❌ Project not found!
        )
    ) else (
        echo No PHP projects found!
    )
) else if "%php_choice%"=="4" (
    echo.
    echo OPEN IN BROWSER
    echo.
    set /p browser_project="Project name: "
    start http://localhost/%browser_project%/
    echo ✅ Opening: http://localhost/%browser_project%/
) else if "%php_choice%"=="5" (
    echo.
    echo OPEN IN EDITOR
    echo.
    if exist "!repo_root!\Dev\php-projects\" (
        echo Available projects:
        dir "!repo_root!\Dev\php-projects\" /b /ad
        echo.
        set /p editor_project="Project name: "
        
        if exist "!repo_root!\Dev\php-projects\%editor_project%\" (
            :: Try to open in default editor or VS Code
            code "!repo_root!\Dev\php-projects\%editor_project%\" 2>nul || (
                start "!repo_root!\Dev\php-projects\%editor_project%\"
            )
            echo ✅ Opening project...
        ) else (
            echo ❌ Project not found!
        )
    )
) else if "%php_choice%"=="6" (
    goto main_menu
)

echo.
pause
goto php_manager

:: ========================================
:: 11. Backup & Restore
:: ========================================
:backup_git
cls
echo ========================================
echo BACKUP & Restore
echo ========================================
echo.
echo [1] Create backup ZIP
echo [2] Restore from backup
echo [3] Export to another location
echo [4] Back to main menu
echo.
set /p backup_choice="Select option (1-4): "

if "%backup_choice%"=="1" (
    echo.
    echo CREATING BACKUP ZIP
    echo.
    set "backup_file=code-portfolio-backup-%date:~10,4%-%date:~4,2%-%date:~7,2%.zip"
    echo Creating: %backup_file%
    
    :: Using PowerShell for ZIP (Windows 10+)
    powershell -Command "Compress-Archive -Path '!repo_root!\*' -DestinationPath '%backup_file%' -Force"
    
    if exist "%backup_file%" (
        echo ✅ Backup created: %backup_file%
    ) else (
        echo ❌ Backup failed!
    )
) else if "%backup_choice%"=="2" (
    echo.
    echo RESTORE FROM BACKUP
    echo.
    echo WARNING: This will overwrite existing files!
    echo.
    set /p backup_file="Backup file path: "
    
    if exist "%backup_file%" (
        echo Extracting to: !repo_root!
        powershell -Command "Expand-Archive -Path '%backup_file%' -DestinationPath '!repo_root!' -Force"
        echo ✅ Restore completed!
    ) else (
        echo ❌ Backup file not found!
    )
) else if "%backup_choice%"=="3" (
    echo.
    echo EXPORT TO ANOTHER LOCATION
    echo.
    set /p export_path="Export path: "
    
    if not exist "%export_path%" mkdir "%export_path%"
    xcopy "!repo_root!\*" "%export_path%\" /E /I /Y
    echo ✅ Exported to: %export_path%
) else if "%backup_choice%"=="4" (
    goto main_menu
)

echo.
pause
goto backup_git

:: ========================================
:: End of script
:: ========================================
:end
echo Goodbye!
pause
exit /b