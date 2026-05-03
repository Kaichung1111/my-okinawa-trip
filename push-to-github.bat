@echo off
setlocal enabledelayedexpansion
title GitHub Pages Push Tool

echo.
echo ======================================
echo   GitHub Pages Push Tool
echo ======================================
echo.

git --version >nul 2>&1
if errorlevel 1 (
    echo Error: Git is not installed
    echo Download: https://git-scm.com/download/win
    pause
    exit /b 1
)

echo OK: Git is installed
echo.

if not exist ".git" (
    echo Initializing Git repository...
    call git init
    if errorlevel 1 (
        echo Error: Git init failed
        pause
        exit /b 1
    )
    echo OK: Git initialized
    echo.
)

for /f "delims=" %%i in ('git remote -v 2^>nul') do set "hasRemote=%%i"

if "!hasRemote!"=="" (
    echo ======================================
    echo WARNING: Need to set GitHub repo URL
    echo ======================================
    echo.
    echo Enter your GitHub repo URL
    echo Example: https://github.com/username/repo-name.git
    echo.
    set /p repoUrl="GitHub Repo URL: "
    
    if "!repoUrl!"=="" (
        echo Error: No URL provided
        pause
        exit /b 1
    )
    
    call git remote add origin !repoUrl!
    if errorlevel 1 (
        echo Error: Failed to add remote
        pause
        exit /b 1
    )
    echo OK: Remote repository set
    echo.
)

for /f "delims=" %%i in ('git rev-parse --abbrev-ref HEAD 2^>nul') do set "currentBranch=%%i"

if not "!currentBranch!"=="main" (
    echo Switching to main branch...
    call git checkout -b main 2>nul
    echo OK: Switched to main branch
    echo.
)

echo Adding files...
call git add .
if errorlevel 1 (
    echo Error: Failed to add files
    pause
    exit /b 1
)
echo OK: Files added
echo.

for /f "delims=" %%i in ('git status --porcelain 2^>nul') do set "hasChanges=%%i"

if "!hasChanges!"=="" (
    echo WARNING: No changes to commit
    echo.
    pause
    exit /b 0
)

set "commitMessage=Update website"
echo Enter commit message (default: 'Update website'):
set /p commitMessage="Commit message: "

if "!commitMessage!"=="" (
    set "commitMessage=Update website"
)

echo Committing changes...
call git commit -m "!commitMessage!"
if errorlevel 1 (
    echo Error: Commit failed
    pause
    exit /b 1
)
echo OK: Changes committed
echo.

echo Pushing to GitHub...
call git push -u origin main
if errorlevel 1 (
    echo Error: Push failed
    echo.
    echo Possible reasons:
    echo 1. GitHub authentication failed
    echo 2. Wrong repo URL
    echo 3. No internet connection
    echo.
    pause
    exit /b 1
)
echo OK: Pushed to GitHub
echo.

echo ======================================
echo SUCCESS: Deploy completed!
echo ======================================
echo.
echo Your website will be online in 2-3 minutes:
echo https://username.github.io/repo-name/
echo.
echo Check deployment status:
echo GitHub repo - Actions tab
echo.

pause
