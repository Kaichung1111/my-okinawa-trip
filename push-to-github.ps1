# GitHub Pages 一鍵推送腳本 (Windows PowerShell)
# 使用方式: 在 PowerShell 中執行 .\push-to-github.ps1

# 設定顏色輸出
function Write-Success { Write-Host $args -ForegroundColor Green }
function Write-Info { Write-Host $args -ForegroundColor Cyan }
function Write-Error-Custom { Write-Host $args -ForegroundColor Red }

Write-Info "======================================"
Write-Info "GitHub Pages 一鍵推送工具"
Write-Info "======================================"

# 檢查 Git 是否已安裝
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Error-Custom "❌ Git 未安裝！請先安裝 Git: https://git-scm.com/download/win"
    exit 1
}

Write-Success "✓ Git 已安裝"

# 取得當前目錄
$currentPath = Get-Location
Write-Info "📁 專案目錄: $currentPath"

# 檢查是否已初始化 Git
if (-not (Test-Path ".git")) {
    Write-Info ""
    Write-Info "初始化 Git 倉庫..."
    git init
    if ($LASTEXITCODE -ne 0) {
        Write-Error-Custom "❌ Git 初始化失敗"
        exit 1
    }
    Write-Success "✓ Git 倉庫已初始化"
}

# 檢查遠端倉庫
$hasRemote = git remote -v
if (-not $hasRemote) {
    Write-Info ""
    Write-Info "======================================"
    Write-Info "⚠️  需要設定遠端 GitHub 倉庫"
    Write-Info "======================================"
    Write-Info ""
    Write-Info "請輸入你的 GitHub 倉庫 URL"
    Write-Info "格式: https://github.com/你的帳號/倉庫名稱.git"
    Write-Info ""
    $repoUrl = Read-Host "GitHub 倉庫 URL"
    
    if ([string]::IsNullOrWhiteSpace($repoUrl)) {
        Write-Error-Custom "❌ 未輸入倉庫 URL"
        exit 1
    }
    
    git remote add origin $repoUrl
    if ($LASTEXITCODE -ne 0) {
        Write-Error-Custom "❌ 新增遠端倉庫失敗"
        exit 1
    }
    Write-Success "✓ 遠端倉庫已設定"
}

# 檢查分支
$currentBranch = git rev-parse --abbrev-ref HEAD 2>$null
if ($currentBranch -ne "main") {
    Write-Info ""
    Write-Info "正在轉換到 main 分支..."
    git checkout -b main 2>$null
    Write-Success "✓ 已切換到 main 分支"
}

# 新增所有檔案
Write-Info ""
Write-Info "新增檔案..."
git add .
if ($LASTEXITCODE -ne 0) {
    Write-Error-Custom "❌ 新增檔案失敗"
    exit 1
}
Write-Success "✓ 檔案已新增"

# 檢查是否有變更
$status = git status --porcelain
if ([string]::IsNullOrWhiteSpace($status)) {
    Write-Info ""
    Write-Info "⚠️  沒有新的變更要提交"
    exit 0
}

# 提交變更
Write-Info ""
Write-Info "請輸入提交訊息 (預設: 'Update website'):"
$commitMessage = Read-Host "提交訊息"
if ([string]::IsNullOrWhiteSpace($commitMessage)) {
    $commitMessage = "Update website"
}

Write-Info "提交變更..."
git commit -m $commitMessage
if ($LASTEXITCODE -ne 0) {
    Write-Error-Custom "❌ 提交失敗"
    exit 1
}
Write-Success "✓ 變更已提交"

# 推送到 GitHub
Write-Info ""
Write-Info "推送到 GitHub..."
git push -u origin main
if ($LASTEXITCODE -ne 0) {
    Write-Error-Custom "❌ 推送失敗"
    Write-Info "可能是因為："
    Write-Info "1. GitHub 帳號認證失敗"
    Write-Info "2. 倉庫 URL 錯誤"
    Write-Info "3. 沒有網路連接"
    exit 1
}
Write-Success "✓ 已推送到 GitHub"

Write-Info ""
Write-Info "======================================"
Write-Success "✅ 部署完成！"
Write-Info "======================================"
Write-Info ""
Write-Info "你的網頁將在 2-3 分鐘內上線："
Write-Info "https://github用戶名.github.io/倉庫名稱"
Write-Info ""
Write-Info "查看部署狀態："
Write-Info "進入 GitHub 倉庫 → Actions 標籤"
Write-Info ""
