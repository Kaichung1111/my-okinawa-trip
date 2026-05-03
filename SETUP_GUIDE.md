# 沖繩旅遊網頁 - GitHub Pages 部署完整指南

## 📋 目錄
1. [環境準備](#環境準備)
2. [GitHub 設定](#github-設定)
3. [本地設定](#本地設定)
4. [一鍵部署](#一鍵部署)
5. [驗證上線](#驗證上線)
6. [常見問題](#常見問題)

---

## 🔧 環境準備

### 步驟 1：安裝 Git（如未安裝）

1. 訪問 https://git-scm.com/download/win
2. 下載 Windows 版本
3. 執行安裝程式
4. **重要**：在「Adjusting your PATH environment」步驟，選擇 **Use Git from the Windows Command Prompt**
5. 完成安裝

### 步驟 2：驗證 Git 安裝

開啟 **PowerShell**（按 `Win + X`，選 Windows PowerShell）

```powershell
git --version
```

如果看到版本號（例如 `git version 2.40.0`），表示安裝成功 ✓

### 步驟 3：設定 Git 用戶資訊

在 PowerShell 輸入（用你真實的名字和 email）：

```powershell
git config --global user.name "你的名字"
git config --global user.email "你的GitHub@email.com"
```

---

## 🌐 GitHub 設定

### 步驟 4：建立 GitHub 倉庫

1. 登入 https://github.com
2. 點擊右上角 **+** 號 → **New repository**
3. 填寫以下資訊：
   - **Repository name**: `okinawa-trip`（或任意名稱，不要用空格）
   - **Description**: Okinawa 2026 Mobile Trip（可選）
   - **Public**: ✓ 打勾（重要！GitHub Pages 需要 Public）
   - **不要勾選** "Add a README file"、"Add .gitignore"、"Choose a license"

4. 點擊 **Create repository**

### 步驟 5：複製倉庫 URL

建立完後，你會看到一個頁面。找到綠色的 **Code** 按鈕，複製 HTTPS URL（看起來像）：
```
https://github.com/你的用戶名/okinawa-trip.git
```

**保存這個 URL，稍後會用到！**

---

## 📁 本地設定

### 步驟 6：準備你的專案資料夾

在 Windows 資源管理器中：

1. 打開你的專案資料夾：`C:\沖繩旅遊網頁\`
2. 在這個資料夾裡建立一個新資料夾：`.github`（注意前面有個點）
   - 右鍵 → 新增 → 資料夾
   - 輸入 `.github`
   - 如果看到「檔案名不能為空」，在檔案總管打開「檢視」→ 勾選「隱藏項目」

3. 在 `.github` 資料夾內再建立 `workflows` 資料夾

### 步驟 7：新增 GitHub Actions 工作流

1. 我已經為你建立了 `deploy.yml` 檔案
2. 將它複製到：`C:\沖繩旅遊網頁\.github\workflows\deploy.yml`

或者手動建立：

1. 在 `.github\workflows\` 資料夾內，新建文字檔
2. 複製下面的內容：

```yaml
name: Deploy to GitHub Pages

on:
  push:
    branches: [ main ]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

jobs:
  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Setup Pages
        uses: actions/configure-pages@v4

      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: '.'

      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v2
```

3. 將檔案存為 `deploy.yml`（確保副檔名是 `.yml` 不是 `.txt`）

### 步驟 8：新增 .gitignore（可選但推薦）

在 `C:\沖繩旅遊網頁\` 資料夾建立一個文字檔，名稱改為 `.gitignore`，內容：

```
.DS_Store
Thumbs.db
*.log
node_modules/
```

---

## 🚀 一鍵部署

### 步驟 9：執行推送腳本

1. 開啟 **PowerShell**
2. 進入你的專案資料夾：

```powershell
cd C:\沖繩旅遊網頁
```

3. 執行推送腳本：

```powershell
powershell -ExecutionPolicy Bypass -File push-to-github.ps1
```

如果看到「執行原則」的警告，輸入：

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

然後再次執行推送腳本

4. **第一次執行時**，腳本會提示你輸入 GitHub 倉庫 URL
   - 貼上你在「步驟 5」複製的 URL
   - 按 Enter

5. 輸入提交訊息（或按 Enter 使用預設訊息）

6. **GitHub 認證**：
   - 第一次推送時，PowerShell 會要求認證
   - 選擇 **Device flow** 或 **Personal Access Token**（推薦用 GitHub CLI 認證）
   - 按照指示完成認證

### 步驟 10（推薦）：GitHub 認證設定

為了避免每次都要認證，建議設定 SSH 或 Personal Access Token。

**簡單方式（使用 PAT）：**

1. 上 https://github.com/settings/tokens
2. 點 **Generate new token** → **Generate new token (classic)**
3. 選擇 `repo` 權限
4. 複製生成的 token
5. 以後推送時，用這個 token 作為密碼

---

## ✅ 驗證上線

### 步驟 11：檢查部署狀態

1. 上你的 GitHub 倉庫
2. 點擊 **Actions** 標籤
3. 應該看到一個名為「Deploy to GitHub Pages」的工作流
4. 等待它完成（綠色勾勾 ✓）

### 步驟 12：訪問你的網頁

部署完成後（通常 2-3 分鐘），你的網頁在：

```
https://你的GitHub用戶名.github.io/okinawa-trip/
```

例如：
```
https://john-doe.github.io/okinawa-trip/
```

---

## 🔄 以後如何更新網頁

只需要在 PowerShell 執行：

```powershell
cd C:\沖繩旅遊網頁
powershell -ExecutionPolicy Bypass -File push-to-github.ps1
```

輸入提交訊息，就會自動：
1. ✓ 上傳檔案到 GitHub
2. ✓ 觸發 GitHub Actions
3. ✓ 自動部署到你的網站

---

## ❓ 常見問題

### Q1: 執行腳本時出現「權限拒絕」

**解決方案：**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Q2: 推送時要求密碼，但我不知道密碼

**解決方案：**
使用 GitHub Personal Access Token 代替密碼：
1. 上 https://github.com/settings/tokens
2. 點 **Generate new token (classic)**
3. 勾選 `repo` 和 `workflow`
4. 複製 token，用它作為密碼

### Q3: 部署後看不到網頁

**檢查清單：**
1. ✓ 倉庫是否為 Public？
2. ✓ GitHub Actions 是否成功執行？（Actions 標籤看部署狀態）
3. ✓ 檔案名稱是否為 `index.html` 或你的 HTML 檔案在根目錄？
4. ✓ 等待 5 分鐘後重新整理頁面

### Q4: 想要自訂域名

GitHub Pages 預設域名是 `username.github.io/repo-name`。

如果想用自訂域名（例如 `mytrip.com`）：
1. 購買域名
2. 在倉庫 Settings → Pages → Custom domain
3. 輸入你的域名
4. 在域名提供商設定 DNS 記錄

### Q5: 如何刪除已發布的網站

1. 進入倉庫 **Settings** → **Pages**
2. 在「Source」選擇 **None**

---

## 📞 需要幫助？

- GitHub Pages 官方文檔：https://docs.github.com/en/pages
- Git 新手教學：https://github.com/skills/introduction-to-git
- 遇到問題？在 GitHub Discussions 提問：https://github.com/orgs/community/discussions/categories/github-pages

---

## 檔案結構參考

完成後你的資料夾應該看起來像這樣：

```
C:\沖繩旅遊網頁\
├── .github\
│   └── workflows\
│       └── deploy.yml
├── .gitignore
├── okinawa_2026_mobile_trip.html
└── [其他 CSS、JS、圖片等]
```

祝你部署順利！🎉
