@echo off
setlocal enabledelayedexpansion
title GitHub Pages Setup Tool

echo.
echo ======================================
echo   GitHub Pages Setup
echo ======================================
echo.

if not exist ".github" (
    echo Creating .github folder...
    mkdir .github
    echo OK: .github created
) else (
    echo OK: .github already exists
)

if not exist ".github\workflows" (
    echo Creating .github\workflows folder...
    mkdir .github\workflows
    echo OK: .github\workflows created
) else (
    echo OK: .github\workflows already exists
)

echo Creating deploy.yml...

(
echo name: Deploy to GitHub Pages
echo.
echo on:
echo   push:
echo     branches: [ main ]
echo   workflow_dispatch:
echo.
echo permissions:
echo   contents: read
echo   pages: write
echo   id-token: write
echo.
echo concurrency:
echo   group: "pages"
echo   cancel-in-progress: false
echo.
echo jobs:
echo   deploy:
echo     environment:
echo       name: github-pages
echo       url: ${{ steps.deployment.outputs.page_url }}
echo     runs-on: ubuntu-latest
echo     steps:
echo       - name: Checkout
echo         uses: actions/checkout@v4
echo.
echo       - name: Setup Pages
echo         uses: actions/configure-pages@v4
echo.
echo       - name: Upload artifact
echo         uses: actions/upload-pages-artifact@v3
echo         with:
echo           path: '.'
echo.
echo       - name: Deploy to GitHub Pages
echo         id: deployment
echo         uses: actions/deploy-pages@v2
) > .github\workflows\deploy.yml

if exist ".github\workflows\deploy.yml" (
    echo OK: deploy.yml created
) else (
    echo Error: Failed to create deploy.yml
    pause
    exit /b 1
)

if not exist ".gitignore" (
    echo Creating .gitignore...
    (
    echo .DS_Store
    echo Thumbs.db
    echo *.log
    echo node_modules/
    ) > .gitignore
    echo OK: .gitignore created
) else (
    echo OK: .gitignore already exists
)

echo.
echo ======================================
echo SUCCESS: Setup completed!
echo ======================================
echo.
echo Created folder structure:
echo   .github\
echo   .github\workflows\
echo   .github\workflows\deploy.yml
echo   .gitignore
echo.
echo Next step:
echo 1. Make sure okinawa_2026_mobile_trip.html is in this folder
echo 2. Run push-to-github.bat to deploy
echo.

pause
