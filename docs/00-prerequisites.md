# 第 0 章：行前準備

本章整理學員在活動前需要準備的所有項目。

> **請務必在活動前完成「必備項目」**，特別是 Kiro IDE 安裝 + 登入。現場最常卡住的就是登入與企業防火牆。

---

## TL;DR

| # | 項目 | 為什麼需要 |
|---|---|---|
| 1 | 筆電 + 系統管理員權限 | 要安裝 Kiro IDE |
| 2 | AWS Builder ID（免費） | Kiro 登入用，不需 AWS 帳號 |
| 3 | Kiro IDE 已安裝且登入成功 | 主要工具 |
| 4 | Git（含 user.name / user.email） | 每個章節都會 commit |
| 5 | curl + 解壓工具 | 取得 starter kit |
| 6 | 現代瀏覽器 | 遊戲跑在瀏覽器裡 |
| 7 | 耳機（建議） | 遊戲有音效，教室裡會很吵 |
| 8 | 防火牆 / Proxy 放行 | 企業筆電常見卡點 |
| 9 | （建議）預先取得 starter kit | 避免現場網路壅塞 |

選配的 [Going further 章節](08-going-further.md)另需 Node.js 20+ 與 **Google Chrome** — 見下方[選配項目](#optional)。

**若會做 MCP 章節，強烈建議行前跑一次 `npx -y @playwright/mcp@latest --version` 暖機**，可省下現場每人 57 MB 的下載。

> **費用提醒**：本課程**全程在本機執行，完全免費**。不會建立任何 AWS 資源，因此不需要 AWS 帳號、AWS CLI，也沒有部署環節。你只需要一組免費的 AWS Builder ID 來登入 Kiro。

---

## 必備項目

### 1. 筆電與作業系統

需要**可安裝軟體的系統管理員權限**。Kiro IDE 支援：

- **macOS** — Intel 或 Apple Silicon
- **Windows** — 10 / 11（64-bit）
- **Linux** — Ubuntu 24+、Debian 13+、Fedora 40+、Arch、Mint 22+

建議規格：8 GB 以上 RAM、10 GB 以上可用磁碟空間。

### 2. AWS Builder ID

本課程使用 **AWS Builder ID** 登入 Kiro。

- 免費，**不需要 AWS 帳號**，也不會產生任何費用
- 建立 / 檢視：<https://profile.aws.amazon.com/>
- 也可以用 Google / GitHub 登入，但教材步驟是以 Builder ID 為主

**請在活動前先建好帳號並確認能登入。**

### 3. Kiro IDE

從 <https://kiro.dev/downloads/> 下載對應平台的安裝檔（撰寫時最新版為 IDE 1.0.437）。

行前請完成：

1. 安裝 Kiro
2. 開啟 Kiro，選擇 **AWS Builder ID** 登入，確認登入成功
3. 看到 welcome 畫面即代表安裝正常

（可選）第一次啟動時可以匯入你的 VS Code 設定與擴充套件。

### 4. Git

本課程每完成一個階段都會 commit（`git init` / `git add` / `git commit`）。

```bash
git --version
git config --global user.name   # 需有值
git config --global user.email  # 需有值
```

若尚未設定：

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

### 5. curl 與解壓工具

用來取得並解開 starter kit。兩個平台都是系統內建，通常不需額外安裝。

- **macOS / Linux** — 內建 `curl` 與 `tar`
- **Windows** — 內建 `curl`，解壓用 PowerShell 的 `Expand-Archive`

### 6. 現代瀏覽器

Flappy Kiro 是網頁遊戲，需要瀏覽器執行與測試。Chrome、Edge、Safari、Firefox 皆可。若要做選配的 Playwright MCP 章節，**必須安裝 Chrome**。

### 7. 耳機（建議）

遊戲有拍翅、計分、碰撞三種音效，還有循環播放的背景音樂。**一整間教室同時開音效會很吵**，建議自備耳機，這樣你才聽得出自己做的音效回饋對不對。

### 8. 網路 / 防火牆 / Proxy

企業或校園網路請先請 IT 放行以下網域。清單依據 Kiro 官方文件 [Firewalls, proxies, and data perimeters](https://kiro.dev/docs/privacy-and-security/firewalls/)。

**核心（必要）**

```
app.kiro.dev                                # 登入入口
assets.app.kiro.dev                         # 應用資源
```

**Kiro IDE**

```
prod.us-east-1.auth.desktop.kiro.dev        # Token 交換 / 更新 / 登出
prod.us-east-1.telemetry.desktop.kiro.dev   # Telemetry
prod.download.desktop.kiro.dev              # 自動更新、Powers registry
q.us-east-1.amazonaws.com                   # Kiro 服務（legacy，仍需放行）
runtime.us-east-1.kiro.dev                  # Kiro 服務
management.us-east-1.kiro.dev               # 設定與存取管理
telemetry.us-east-1.kiro.dev                # Telemetry
```

歐洲區使用者請改用 / 併同放行 `*.eu-central-1.*` 對應端點。

**若支援 wildcard 規則，可簡化為**

```
*.kiro.dev
*.app.kiro.dev
*.amazonaws.com
```

> 注意：部分防火牆的 wildcard 只比對單層子網域，`*.kiro.dev` 可能不涵蓋 `assets.app.kiro.dev`，需另外加上 `*.app.kiro.dev`。

**用 Google / GitHub 登入才需要**

```
cognito-identity.us-east-1.amazonaws.com
```

**教材與 starter kit**

```
github.com
raw.githubusercontent.com
```

**選配的 MCP 章節**

```
registry.npmjs.org                          # npx 取得 MCP server 套件
open-vsx.org                                # 擴充套件
openvsx.eclipsecontent.org
```

**重要**：登入會開啟你的**預設瀏覽器**，這段流量走的是作業系統網路堆疊，**不受 Kiro 內的 proxy 設定影響**。防火牆必須在網路層放行。

Kiro IDE 支援標準 proxy 環境變數 `HTTP_PROXY` / `HTTPS_PROXY` / `NO_PROXY`，也可在 Settings > Proxy 設定。

### 9. （建議）預先取得 starter kit

Starter kit 就在本 repo 的 [`starter-kit/`](https://github.com/ParinLL/kiro-workshop-requirement/tree/main/starter-kit) 目錄，約 1.6 MB。現場才下載可能因網路壅塞而卡住，建議行前先抓。

最簡單的方式是直接 clone 整個 repo（教材與素材一次到手）：

```bash
git clone https://github.com/ParinLL/kiro-workshop-requirement.git
```

內容：

```
assets/ghosty.png       # 主角 Ghosty 的角色圖
assets/jump.wav         # 拍翅 / 跳躍音效
assets/score.wav        # 計分音效
assets/game_over.wav    # 碰撞 / 遊戲結束音效
assets/bgm.wav          # 背景音樂（可無縫循環）
assets/favicon.ico      # 瀏覽器頁籤圖示
img/example-ui.png      # 遊戲介面示意圖（會當成 prompt 的參考圖）
LICENCE.md
.gitignore
```

課程中會在 Kiro 裡建一個名為 `kiro-introduction` 的資料夾，把上述檔案放進去。素材的詳細規格見 [starter-kit/README.md](https://github.com/ParinLL/kiro-workshop-requirement/blob/main/starter-kit/README.md)。

---

<a id="optional"></a>

## 選配項目（Going further 章節）

以下只有做[延伸章節](08-going-further.md)才需要。若時間有限可略過，但**若打算做，請一併行前準備**。

### MCP 章節：Playwright（建議預裝）+ Context7（加分）

MCP 章節指定使用 **Playwright MCP server**，從 [Kiro Server Directory](https://kiro.dev/docs/mcp/servers/) 按 **+ Add to Kiro** 一鍵加入，不需手動編輯設定檔。

兩者在 Server Directory 都標註 **Requires Node installed**，因此先裝 Node.js：

- 建議 **Node.js 20 LTS 或以上**
- 驗證：`node --version`、`npx --version`

#### Playwright MCP — 建議行前預裝

實測過的三件事（避免現場踩雷）：

| 項目 | 實測結果 |
|---|---|
| 套件冷啟動下載量 | **約 57 MB**（npx 快取） |
| 是否下載瀏覽器 binary | **不會**。把 `PLAYWRIGHT_BROWSERS_PATH` 指向空目錄後仍能正常操作網頁，該目錄維持 0 B |
| 沒裝 Chrome 的後果 | 第一次呼叫工具就失敗：`Chromium distribution 'chrome' is not found ... Run "npx playwright install chrome"` |

所以真正的相依是 **系統要有 Google Chrome**，不是下載 Chromium。行前請完成：

1. 安裝 Node.js 20+
2. 安裝 **Google Chrome**
3. 暖機 npx 快取（省下現場 57 MB × 全班的下載量）：

```bash
npx -y @playwright/mcp@latest --version
```

> 教室網路是最大瓶頸：57 MB 乘上 30 人約 1.7 GB，乘上 100 人約 5.7 GB。這一步預先做完，MCP 章節可以從「等下載」變成「幾秒內 Connected」。

> **另一個現場陷阱**：Playwright MCP **預設封鎖 `file://` 協定**。若學員用瀏覽器直接開 `index.html`，MCP 會拒絕存取。做 MCP 章節時必須改用本機靜態伺服器 — 見下方[本機靜態伺服器](#local-server)。

<a id="local-server"></a>

### 本機靜態伺服器（做 MCP 章節才需要）

遊戲本身用瀏覽器直接開 `index.html` 就能跑。但 Playwright MCP 預設封鎖 `file://`，所以**只有做 MCP 章節時**才需要一個本機伺服器。

實測結果：`file://` 被 MCP 拒絕，`http://localhost` 正常存取。

三種做法，依推薦順序：

| 做法 | 指令 | 成本與限制 |
|---|---|---|
| **`npx serve`**（推薦） | `npx -y serve -l 8000` | 需要 Node。冷啟動下載約 **16 MB**，跨平台一致 |
| **Python** | `python3 -m http.server 8000` | macOS / Linux 通常已有。**Windows 不內建 Python** |
| **Kiro 擴充套件** | 從 Open VSX 安裝 Live Server 類擴充 | 不用碰終端機，但屬第三方套件，課堂上多一個變數 |

**為什麼推薦 `npx serve`**：做 MCP 章節本來就得裝 Node（Playwright MCP 需要），所以不必再多裝 Python。一個相依打兩件事。

若要走 Python 路線，注意兩個平台差異：

- **Windows** — 完全不內建 `python3`，需另外安裝
- **macOS** — `/usr/bin/python3` 是 Xcode Command Line Tools 提供的。若機器沒裝過 CLT，第一次執行會跳出安裝對話框，那個下載不小。可先用 `python3 --version` 確認

行前暖機（和 Playwright MCP 一起做）：

```bash
npx -y serve --version
```

#### Context7 MCP — 原版沒提到，但值得加

[Context7](https://context7.com/) 提供**函式庫的即時最新文件**給 AI agent 用，同樣在 Kiro Server Directory 裡可一鍵安裝。

**加分在哪：**

- [Going further 的 subagents 章節](08-going-further.md#doc-research)明確要「平行抓取多個文件來源」，Context7 正好是這個用途
- 學員若讓 Kiro 改用遊戲框架（Phaser、Kaboom.js、PixiJS），Context7 能給到當前版本的 API。實測查 `phaser` 會回 `/phaserjs/phaser`，2296 個 code snippets
- 想深入某個瀏覽器 API（Canvas 2D、Web Audio、`requestAnimationFrame`）時，能拿到當前版本的用法

**但核心 90 分鐘章節其實不需要它。** Flappy Kiro 是原生 HTML5 Canvas + JavaScript，沒有函式庫版本漂移問題，Kiro 內建知識就夠。

**要用就注意 rate limit（重要）：**

- 不帶 API key 也能跑（實測未設 `CONTEXT7_API_KEY` 可正常回應），但官方明載 API key 才有較高 rate limit
- 匿名額度是**按 IP** 計算。整間教室走同一個 NAT 出口，30～100 人共用一個額度，**很可能撞 429，反而變成 lab 的卡點**
- 因此若要在課堂使用，請**每位學員各自申請免費 key**：<https://context7.com/dashboard>，設為環境變數 `CONTEXT7_API_KEY`

**結論**：Playwright 建議預裝（MCP 章節指定用到）；Context7 列為選配加分，若要開就一定要配自己的 free API key，否則建議課堂上別開。

---

## 行前驗證

本 repo 提供檢查腳本，執行後會列出各項目狀態。

**macOS / Linux**

```bash
bash scripts/check-prereqs.sh
```

**Windows（PowerShell）**

```powershell
.\scripts\check-prereqs.ps1
```

手動確認清單：

- [ ] Kiro IDE 已安裝，且能用 AWS Builder ID 成功登入
- [ ] Kiro 的 Chat panel（`Cmd+L` / `Ctrl+L`）可以開啟並回應
- [ ] `git --version` 有輸出，且 `user.name` / `user.email` 已設定
- [ ] `curl --version` 有輸出
- [ ] Starter kit 已取得（或確認能連上 GitHub）
- [ ] 瀏覽器可正常開啟本機頁面
- [ ] （選配）`node --version` ≥ 20
- [ ] （選配）Google Chrome 已安裝（Playwright MCP 需要）
- [ ] （選配）已執行 `npx -y @playwright/mcp@latest --version` 暖機
- [ ] （選配）已執行 `npx -y serve --version` 暖機（本機靜態伺服器）
- [ ] （選配）Context7 free API key 已取得並設為 `CONTEXT7_API_KEY`

> 若你用 nvm / fnm / volta / asdf 管理 Node，注意這些版本管理器在非互動 shell 中不會載入，Kiro 的 MCP 設定可能需要填 node 的**絕對路徑**。檢查腳本會偵測並提醒。

---

## 背景知識

這是**中階**課程。有應用程式設計概念與基本程式能力會比較順，但不是硬性要求 — 過程中 Kiro 會協助。

有以下經驗會更容易上手：

- 用過 VS Code、JetBrains 或 Visual Studio 等開發環境
- 基本 Git 操作
- 基本終端機操作

---

[回到課程首頁](index.md) | [下一章：開始 Workshop →](01-setup.md)
