# ⚡ GitHub Pages 一鍵部署 - 快速參考

## 🎯 核心 5 步驟

### 1️⃣ 安裝 Git
```powershell
# 訪問並下載安裝
https://git-scm.com/download/win

# 驗證安裝
git --version
```

### 2️⃣ 設定 Git
```powershell
git config --global user.name "你的名字"
git config --global user.email "your@email.com"
```

### 3️⃣ 在 GitHub 建立倉庫
- 上 github.com
- New repository
- 名稱：`okinawa-trip`
- ✓ Public
- Create repository
- 複製 HTTPS URL

### 4️⃣ 在本地準備檔案

在 `C:\沖繩旅遊網頁\` 建立：

```
.github/
  workflows/
    deploy.yml
```

deploy.yml 內容（見下方）

### 5️⃣ 一鍵推送
```powershell
cd C:\沖繩旅遊網頁
powershell -ExecutionPolicy Bypass -File push-to-github.ps1
```

---

## 📝 deploy.yml 內容（複製貼上）

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

---

## ✅ 部署完成後

你的網頁將在此地址上線（2-3 分鐘後）：

```
https://你的GitHub用戶名.github.io/okinawa-trip/
```

---

## 🔄 下次更新

只需執行：
```powershell
cd C:\沖繩旅遊網頁
powershell -ExecutionPolicy Bypass -File push-to-github.ps1
```

---

## ⚠️ 常見錯誤

| 錯誤 | 解決方案 |
|------|--------|
| 「執行原則」警告 | `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser` |
| 認證失敗 | 使用 [Personal Access Token](https://github.com/settings/tokens) |
| 找不到 .github 資料夾 | 在檔案總管「檢視」勾選「隱藏項目」 |
| Actions 失敗 | 檢查 GitHub 倉庫 → Actions 標籤查看錯誤訊息 |

---

**🎉 就這樣！完全自動化部署！**
