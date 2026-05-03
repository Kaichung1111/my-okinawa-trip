# 🚀 BAT 檔一鍵部署 - 超簡單版

## 你現在有 2 個 BAT 檔

### 1️⃣ setup-github-pages.bat
**作用**：自動建立所有必要的資料夾和配置檔

### 2️⃣ push-to-github.bat
**作用**：一鍵推送到 GitHub 並自動部署

---

## 📋 使用步驟（只需 4 步）

### 第一次使用：

#### 步驟 1：安裝 Git
- 下載：https://git-scm.com/download/win
- 執行安裝（全程按 Next）

#### 步驟 2：在 GitHub 建立倉庫
1. 上 https://github.com 登入
2. New repository
3. 倉庫名稱：`okinawa-trip`
4. ✓ Public
5. Create repository
6. 複製 HTTPS URL（綠色 Code 按鈕）

#### 步驟 3：準備檔案
1. 把所有 BAT 檔複製到：`C:\沖繩旅遊網頁\`
2. 確保 `okinawa_2026_mobile_trip.html` 也在這個資料夾

#### 步驟 4：執行初始化
1. 在 `C:\沖繩旅遊網頁\` 資料夾內
2. **雙擊** `setup-github-pages.bat`
3. 等它完成（會自動關閉）

#### 步驟 5：執行推送
1. **雙擊** `push-to-github.bat`
2. 第一次執行會問你 GitHub 倉庫 URL
3. 貼上你在「步驟 2」複製的 URL
4. 輸入提交訊息（或按 Enter）
5. 可能要認證 GitHub（按照提示完成）

#### 步驟 6：完成！
2-3 分鐘後，你的網頁在線：
```
https://你的GitHub用戶名.github.io/okinawa-trip/
```

---

## 🔄 以後怎麼更新網頁

只要修改了 HTML 檔，就：

1. **雙擊** `push-to-github.bat`
2. 輸入提交訊息
3. 完成！自動部署 ✨

---

## 📁 最終資料夾結構

完成後會看到：

```
C:\沖繩旅遊網頁\
├── setup-github-pages.bat
├── push-to-github.bat
├── okinawa_2026_mobile_trip.html
├── .github\
│   └── workflows\
│       └── deploy.yml
└── .gitignore
```

---

## ⚠️ 常見問題

### Q: 雙擊 BAT 檔沒反應
**A**: 可能是關聯被改了。右鍵 → 開啟方式 → 選擇「命令提示字元」或「PowerShell」

### Q: GitHub 認證失敗
**A**: 
1. 使用 Personal Access Token（推薦）
2. 上 https://github.com/settings/tokens
3. Generate new token (classic)
4. 勾選 `repo` 和 `workflow`
5. 複製 token，用它作為密碼

### Q: 看不到 .github 資料夾
**A**: 這個資料夾是隱藏的
- 在檔案總管「檢視」勾選「隱藏項目」即可看到

### Q: BAT 檔執行後立即關閉
**A**: 這是正常的。如果要看輸出，改為右鍵 → 編輯，在最後加上：
```batch
pause
```

---

## 🎯 一句話總結

1. ✓ 下載 Git
2. ✓ 建立 GitHub 倉庫
3. ✓ 複製 BAT 檔到資料夾
4. ✓ 雙擊 `setup-github-pages.bat`
5. ✓ 雙擊 `push-to-github.bat`
6. ✓ 完成！網頁自動上線 🎉

---

**需要幫助嗎？** 看看 SETUP_GUIDE.md 的詳細步驟
