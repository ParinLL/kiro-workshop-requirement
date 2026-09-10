# Kiro Workshop：用 Flappy Kiro 學 AI 輔助開發

<p align="center">
  <img src="starter-kit/img/example-ui.png" alt="Flappy Kiro" width="480">
</p>

<p align="center">
  <b><a href="https://parin.dev/kiro">📖 開始上課 → parin.dev/kiro</a></b>
</p>

<p align="center">
  <sub>課程網站：<a href="https://kiro-workshop.parinl.com/">kiro-workshop.parinl.com</a></sub>
</p>

Kiro 實作課程教材，改寫自 AWS 官方的 [Kiro Express workshop](https://catalog.workshops.aws/kiro-express/en-US/)。

從零建出 **Flappy Kiro** — 在瀏覽器中執行的街機風無盡跑酷遊戲，主角是幽靈 **Ghosty**。過程中實際體驗 Kiro 的 **spec-driven development**：先定義需求，再協作精修設計，然後引導 Kiro 逐項完成實作。

核心章節約 **90 分鐘**，**全程在本機執行、不需要 AWS 帳號、不建立任何 AWS 資源**。

---

## 快速開始

1. 完成 **[第 0 章：行前準備](docs/00-prerequisites.md)** — 特別是 Kiro IDE 的安裝與登入
2. 跑一次環境檢查腳本：

   ```bash
   # macOS
   bash scripts/check-prereqs.sh
   ```

   ```powershell
   # Windows
   .\scripts\check-prereqs.ps1
   ```

3. 從 **[第 1 章](docs/01-setup.md)** 開始

---

## 章節

| # | 章節 | 時間 |
|---|---|---|
| 0 | [行前準備](docs/00-prerequisites.md) | 課前 |
| 1 | [開始 Workshop](docs/01-setup.md) | 10 分 |
| 2 | [產生需求規格](docs/02-requirements.md) | 25 分<br>（2-4 合計） |
| 3 | [產生設計規格](docs/03-design.md) | |
| 4 | [產生實作任務](docs/04-tasks.md) | |
| 5 | [建立 Steering 檔案](docs/05-steering.md) | 15 分<br>（5-6 合計） |
| 6 | [建構應用程式](docs/06-build.md) | |
| 7 | [執行 Flappy Kiro](docs/07-run.md) | — |
| 8 | [（選配）更進一步](docs/08-going-further.md) | — |

---

## Repo 結構

```
├── docs/                        # 課程章節，同時是網站來源
├── starter-kit/                 # 學員起始素材（約 1.6 MB）
│   ├── assets/                  # 角色圖 + 音效 + 背景音樂
│   ├── img/example-ui.png       # 遊戲介面示意圖
│   ├── README.md                # 素材規格說明
│   └── LICENCE.md               # MIT-0
├── scripts/
│   ├── check-prereqs.sh         # 行前環境檢查（macOS）
│   └── check-prereqs.ps1        # 行前環境檢查（Windows）
├── mkdocs.yml                   # 網站設定
└── requirements-docs.txt        # 建站相依套件
```

---

## 本機預覽課程網站

網站用 [MkDocs Material](https://squidfunk.github.io/mkdocs-material/) 建置，推送到 `main` 時由 GitHub Actions 自動部署。

```bash
# 需要 uv（https://docs.astral.sh/uv/）
uvx --with-requirements requirements-docs.txt --from mkdocs mkdocs serve
```

或用 pip：

```bash
pip install -r requirements-docs.txt
mkdocs serve
```

然後開 <http://127.0.0.1:8000>。

建置檢查（`--strict` 會讓失效的內部連結直接失敗）：

```bash
mkdocs build --strict
```

---

## 與 AWS 原版的差異

**移除**：Deploy 與 Clean up 章節，以及 Going further 的 Kiro CLI 與 Kiro Powers（都聚焦在 AWS 部署）。因此全程本機執行、不建立任何 AWS 資源。

**強化**：更完整的音效素材（多了計分音與可循環背景音樂）、Context7 MCP 的評估與 rate limit 提醒、實測過的 Playwright MCP 行前細節、兩個平台的環境檢查腳本。

---

## 開課須知

以下是規劃課程時需要知道的事，`docs/` 裡的教材維持學員視角，不含這些內容。

**要給學員的網址**

`parin.dev/kiro` — 短、好唸、好打，適合放在投影片或口述。它 302 轉到 `kiro-workshop.parinl.com`（GitHub Pages 自訂網域）。

**頻寬**

MCP 章節的 Playwright server 設定是 `npx @playwright/mcp@latest`，套件在 server 第一次啟動時才下載，**每台機器約 57 MB**。30 人約 1.7 GB、100 人約 5.7 GB，且集中在同一時段。可考慮把 MCP 章節排在後段、分批進行，或事先確認場地頻寬。

「先暖機 npx 快取」不是可靠的解法：`@latest` 每次都會重新向 registry 解析版本，只要活動前套件發了新版就會重新下載（實測換版本後多抓 22 MB）。全域 `npm install -g` 也沒用 — 已全域安裝 0.0.80 的機器，`npx` 仍下載了 57 MB。若真要求確定性，做法是在 `mcp.json` 裡把版本釘死。

**Kiro credits**

這是排課時最該先確認的一項。Kiro Free 方案每月 **50 credits**，credits 依每次請求的規模分次扣用，而本課程屬 agent 密集型（產生規格 + 逐項執行實作任務），用量不小。付費方案為 Pro $20（1,000 credits）起，另可加購 credits（$0.04/credit）。

實務建議：請學員課前確認 credit 餘額；若多數人用 Free 方案，可考慮把第 5-7 章的實作段落縮短或改為講師示範。最新方案內容見 <https://kiro.dev/pricing/>。

**Context7 的 rate limit**

未帶 API key 時的額度按 IP 計算，整班走同一個 NAT 出口會共用額度、容易撞 429。若要在課堂開啟，請要求每位學員各自申請自己的 key。

**已在實機驗證過的行為**

| 項目 | 結果 |
|---|---|
| Playwright MCP 是否下載 Chromium | 不會。把 `PLAYWRIGHT_BROWSERS_PATH` 指到空目錄仍能操作網頁，該目錄維持 0 B — 它用的是系統 Chrome |
| Playwright MCP 對 `file://` | 拒絕存取；`http://localhost` 正常。所以 MCP 章節必須起本機伺服器 |
| Windows 的 `curl` | PowerShell 5.1 把它設為 `Invoke-WebRequest` 別名，`--version` 會被當網址。教材一律寫 `curl.exe` |
| Windows 的 `python3` | 預設是 0 byte 的 App Execution Alias，執行回 exit 9009。檢查腳本會跳過它 |
| `check-prereqs.ps1` 編碼 | 必須存成 **UTF-8 with BOM**，否則 PS 5.1 以 ANSI 解讀中文導致語法錯誤 |

驗證環境：Windows 11 (26200) / PowerShell 5.1、macOS 15 (arm64)。

---

## 授權

Starter kit 素材為 **MIT-0**（詳見 [starter-kit/LICENCE.md](starter-kit/LICENCE.md)）。教材內容改寫自 AWS Kiro Express workshop。
