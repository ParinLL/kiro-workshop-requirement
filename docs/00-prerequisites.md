# 第 0 章：行前準備

本章整理你在課程開始前需要準備的所有項目，每一項都附上各平台的實際安裝指令。

> **請在課程開始前完成「必備項目」**，特別是 Kiro IDE 的安裝與登入。登入流程與企業網路的防火牆設定最花時間，提早處理會順利很多。

---

## TL;DR

| # | 項目 | 為什麼需要 |
|---|---|---|
| 1 | 筆電 + 系統管理員權限 | 要安裝 Kiro IDE |
| 2 | AWS Builder ID | Kiro 登入用，不需 AWS 帳號 |
| 3 | Kiro IDE 已安裝且登入成功 | 主要工具 |
| 4 | Git（含 user.name / user.email） | 每個章節都會 commit |
| 5 | curl + 解壓工具 | 取得 starter kit（系統內建） |
| 6 | Google Chrome | 執行遊戲；Playwright MCP 也指定要它 |
| 7 | **Node.js 20+** | **Kiro 產出的程式常會用到**，MCP 章節也需要 |
| 8 | 耳機（建議） | 遊戲有音效，方便你聽自己做的音效回饋 |
| 9 | 防火牆 / Proxy 放行 | 企業或校園網路常需要事先申請 |
| 10 | 預先取得 starter kit | 課前抓好，開始時就能直接進入主題 |

<a id="credits"></a>

!!! info "關於用量"

    本課程**全程在本機執行**，不會建立任何 AWS 資源，所以不需要 AWS 帳號，也沒有 AWS 費用。

    但 **Kiro 本身的使用會消耗你方案的 credits**。Credits 是依每次請求的規模分次扣用 — 簡短的編輯扣得少，複雜或冗長的任務扣得多。本課程屬於 agent 密集的類型（產生規格、逐項執行實作任務），用量不算小。

    [Kiro Free 方案](https://kiro.dev/pricing/)每月包含 50 credits。**課前請先確認你的 credit 餘額**：點 Kiro 右下角的使用量指示，或到 [app.kiro.dev](https://app.kiro.dev/) 查看。如果餘額偏低，可以先做完第 1-4 章的規格階段，把第 5-7 章的實作留到餘額恢復後再進行。

---

<a id="oneshot"></a>

## 一次裝完（複製貼上）

以下指令中的套件名稱與 ID 都經過實機查證。若你想一項一項來，往下看[逐項說明](#items)。

=== "macOS"

    需要 [Homebrew](https://brew.sh/)。若尚未安裝：

    ```bash
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```

    然後一次裝完：

    ```bash
    brew install --cask kiro           # Kiro IDE
    brew install --cask google-chrome  # Playwright MCP 需要系統 Chrome
    brew install git node              # Git 與 Node.js
    ```

    設定 Git 身分（首次使用才需要）：

    ```bash
    git config --global user.name "你的名字"
    git config --global user.email "you@example.com"
    ```

=== "Windows"

    Windows 10 / 11 內建 `winget`（來自「應用程式安裝程式」）。以一般 PowerShell 執行：

    ```powershell
    winget install Amazon.Kiro          # Kiro IDE
    winget install Google.Chrome        # Playwright MCP 需要系統 Chrome
    winget install Git.Git              # Git
    winget install OpenJS.NodeJS.LTS    # Node.js LTS
    ```

    裝完 Node 後**請關閉並重開 PowerShell**，讓 PATH 生效。

    設定 Git 身分（首次使用才需要）：

    ```powershell
    git config --global user.name "你的名字"
    git config --global user.email "you@example.com"
    ```

---

<a id="items"></a>

## 必備項目（逐項說明）

### 1. 筆電與作業系統

需要**可安裝軟體的系統管理員權限**。Kiro IDE 支援：

- **macOS** — Intel 或 Apple Silicon
- **Windows** — 10 / 11（64-bit）

建議規格：8 GB 以上 RAM、10 GB 以上可用磁碟空間。

### 2. AWS Builder ID

本課程使用 **AWS Builder ID** 登入 Kiro。

- 建立帳號不需付費，也**不需要 AWS 帳號**
- 建立 / 檢視：<https://profile.aws.amazon.com/>
- 也可以用 Google / GitHub 登入，但教材步驟是以 Builder ID 為主

**請在活動前先建好帳號並確認能登入。**

### 3. Kiro IDE

=== "macOS"

    ```bash
    brew install --cask kiro
    ```

=== "Windows"

    ```powershell
    winget install Amazon.Kiro
    ```

不想用套件管理器的話，直接到 <https://kiro.dev/downloads/> 下載安裝檔即可（撰寫時為 IDE 1.0.437）。

行前請完成：

1. 安裝 Kiro
2. 開啟 Kiro，選擇 **AWS Builder ID** 登入，確認登入成功
3. 看到 welcome 畫面即代表安裝正常

（可選）第一次啟動時可以匯入你的 VS Code 設定與擴充套件。

### 4. Git

本課程每完成一個階段都會 commit（`git init` / `git add` / `git commit`）。

=== "macOS"

    ```bash
    brew install git
    ```

    或用 Xcode Command Line Tools 附帶的版本：

    ```bash
    xcode-select --install
    ```

=== "Windows"

    ```powershell
    winget install Git.Git
    ```

裝完後**必須設定身分**，否則 commit 會失敗：

```bash
git config --global user.name "你的名字"
git config --global user.email "you@example.com"
```

確認：

```bash
git --version
git config --global user.name    # 需有值
git config --global user.email   # 需有值
```

### 5. curl 與解壓工具

用來取得並解開 starter kit。各平台都是系統內建，**通常不需額外安裝**。

- **macOS** — 內建 `curl` 與 `tar`
- **Windows** — 內建 `curl.exe` 與 `tar.exe`（bsdtar），解壓也可用 PowerShell 的 `Expand-Archive`

確認：

=== "macOS"

    ```bash
    curl --version
    tar --version
    ```

=== "Windows"

    ```powershell
    curl.exe --version
    tar --version
    ```

!!! warning "Windows 必讀：`curl` 不是 curl"

    在 Windows PowerShell 5.1 中，`curl` 是 `Invoke-WebRequest` 的**別名**，不是真正的 curl。

    它不認得 `-L`、`-o` 這些參數，會把 `--version` 當成網址去連，直接擲出
    `無法解析遠端名稱: '--version'`；用在下載指令上則是靜默失敗、什麼都沒下載。

    **教材裡的 Windows 指令都寫成 `curl.exe`，請照抄，不要簡寫成 `curl`。**

    （`tar` 沒有這個問題，Windows 的 `tar` 就是真正的 bsdtar。）

### 6. Google Chrome

Flappy Kiro 是網頁遊戲，需要瀏覽器執行與測試。Chrome、Edge、Safari、Firefox 都能跑遊戲。

但若你要做選配的 **Playwright MCP** 章節，**必須是 Google Chrome** — Playwright MCP 預設直接使用系統安裝的 Chrome，缺少時第一次呼叫工具就會失敗。

=== "macOS"

    ```bash
    brew install --cask google-chrome
    ```

=== "Windows"

    ```powershell
    winget install Google.Chrome
    ```

### 7. Node.js 20 或以上

**建議一定要裝**，有三個地方會用到，只有第三個是選配：

1. **Kiro 產出的程式很可能需要 Node** — 你在設計與實作階段會請 Kiro 寫測試、加工具、跑檢查。以本課程的技術選型（原生 HTML5 Canvas + JavaScript）來說，Kiro 產生的單元測試與 property-based test 通常會用 Node 內建的 `node:test` 執行。沒有 Node，這些任務就只能跳過
2. **本機靜態伺服器** — `npx serve` 是跨平台最省事的做法，見[本機靜態伺服器](#local-server)
3. **MCP 章節** — Playwright 與 Context7 兩個 MCP server 在 Kiro Server Directory 都標註 *Requires Node installed*

=== "macOS"

    ```bash
    brew install node
    ```

=== "Windows"

    ```powershell
    winget install OpenJS.NodeJS.LTS
    ```

    裝完請**關閉並重開 PowerShell**，PATH 才會生效。

確認（需 v20 以上，撰寫時 LTS 為 v24）：

```bash
node --version
npx --version
```

> **用版本管理器要注意**：nvm / fnm / volta / asdf 只在互動式 shell 載入。Kiro 的 MCP 設定檔若直接寫 `node` 可能找不到，需要填**絕對路徑**。用 `command -v node` 取得實際路徑。行前檢查腳本會偵測這個狀況並提醒。

### 8. 耳機（建議）

遊戲有拍翅、計分、碰撞三種音效，還有循環播放的背景音樂。戴耳機你才聽得清楚自己做出來的音效回饋對不對，也不會影響旁邊的人。

### 9. 網路 / 防火牆 / Proxy

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
codeload.github.com                         # GitHub 下載 zip / tarball 的實際來源
```

**安裝與 MCP 章節**

```
registry.npmjs.org                          # npx 取得 MCP server 套件
open-vsx.org                                # Kiro 擴充套件
openvsx.eclipsecontent.org
formulae.brew.sh                            # macOS 用 Homebrew 安裝時
cdn.winget.microsoft.com                    # Windows 用 winget 安裝時
```

**重要**：登入會開啟你的**預設瀏覽器**，這段流量走的是作業系統網路堆疊，**不受 Kiro 內的 proxy 設定影響**。防火牆必須在網路層放行。

Kiro IDE 支援標準 proxy 環境變數 `HTTP_PROXY` / `HTTPS_PROXY` / `NO_PROXY`，也可在 Settings > Proxy 設定。

### 10. 預先取得 starter kit

Starter kit 就在本 repo 的 [`starter-kit/`](https://github.com/ParinLL/kiro-workshop-requirement/tree/main/starter-kit) 目錄，約 1.6 MB。建議課前先抓下來，開始時就能直接進入主題。

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

前提是[第 7 項的 Node.js](#7-nodejs-20-或以上) 與[第 6 項的 Google Chrome](#6-google-chrome) 已裝好。

### Playwright MCP

MCP 章節使用 **Playwright MCP server**，從 [Kiro Server Directory](https://kiro.dev/docs/mcp/servers/) 按 **+ Add to Kiro** 一鍵加入，不需手動編輯設定檔。

有兩個行為值得先知道：

| 項目 | 說明 |
|---|---|
| 首次啟動會下載套件 | 約 **57 MB**。設定檔寫的是 `npx @playwright/mcp@latest`，套件在 MCP server 第一次啟動時才下載，需要幾十秒 |
| 使用的是系統 Chrome | 它**不會**另外下載 Chromium，而是直接用你系統上安裝的 Google Chrome。沒裝 Chrome 的話，第一次呼叫工具就會失敗並顯示 `Chromium distribution 'chrome' is not found` |

所以這一節真正的前置條件是**系統要有 Google Chrome**，先裝好就不會卡住。


<a id="local-server"></a>

### 本機靜態伺服器（做 MCP 章節才需要）

遊戲本身用瀏覽器直接開 `index.html` 就能跑。但 Playwright MCP 封鎖 `file://`，所以**只有做 MCP 章節時**才需要一個本機伺服器，把遊戲改用 `http://localhost` 開啟。

三種做法，依推薦順序：

| 做法 | 指令 | 說明 |
|---|---|---|
| **`npx serve`**（推薦） | `npx -y serve -l 8000` | 需要 Node，兩個平台指令一致。首次執行會下載約 **16 MB** |
| **Python** | `python3 -m http.server 8000` | macOS 通常已有。**Windows 不內建** |
| **Kiro 擴充套件** | 從 Open VSX 安裝 Live Server 類擴充 | 不用碰終端機，但屬第三方套件 |

**為什麼推薦 `npx serve`**：Node 本來就在必備清單上，不必再多裝 Python。第一次執行會下載約 16 MB。

### Context7 MCP（選配加分）

[Context7](https://context7.com/) 提供**函式庫的即時最新文件**給 AI agent 用，同樣在 Kiro Server Directory 裡可一鍵安裝。

**什麼時候派得上用場：**

- [第 8 章的 subagents 段落](08-going-further.md#doc-research)會請 Kiro 平行抓取多個文件來源，Context7 正好是這個用途
- 如果你想讓 Kiro 改用遊戲框架（Phaser、Kaboom.js、PixiJS），它能提供當前版本的 API。例如查 `phaser` 會回傳 `/phaserjs/phaser`，含 2296 個程式碼範例
- 想深入某個瀏覽器 API（Canvas 2D、Web Audio、`requestAnimationFrame`）時，能拿到當前版本的用法

**核心章節不需要它。** Flappy Kiro 是原生 HTML5 Canvas + JavaScript，沒有函式庫版本落差的問題，Kiro 內建知識就足夠。

**要用的話請先申請自己的 API key：**

- 不帶 API key 也能運作，但官方說明 API key 才有較高的 rate limit
- 未帶 key 時的額度是**按 IP** 計算，所以多人共用同一個對外網路時容易一起撞到上限
- 在 <https://context7.com/dashboard> 申請你自己的 key，然後設為環境變數：

=== "macOS"

    ```bash
    export CONTEXT7_API_KEY="你的 key"
    # 要永久生效就寫進 ~/.zshrc 或 ~/.bashrc
    ```

=== "Windows"

    ```powershell
    [Environment]::SetEnvironmentVariable('CONTEXT7_API_KEY', '你的 key', 'User')
    # 設定後需重開 Kiro 才會讀到
    ```

**小結**：Playwright 是 MCP 章節會實際用到的；Context7 屬於選配加分，要用就先配好自己的 free API key。

---

## 行前驗證

本 repo 提供檢查腳本，執行後會列出各項目狀態。

=== "macOS"

    ```bash
    git clone https://github.com/ParinLL/kiro-workshop-requirement.git
    cd kiro-workshop-requirement
    bash scripts/check-prereqs.sh
    ```

=== "Windows"

    ```powershell
    git clone https://github.com/ParinLL/kiro-workshop-requirement.git
    cd kiro-workshop-requirement
    .\scripts\check-prereqs.ps1
    ```

    若出現執行原則的錯誤，改用：

    ```powershell
    powershell -ExecutionPolicy Bypass -File .\scripts\check-prereqs.ps1
    ```

手動確認清單：

- [ ] Kiro IDE 已安裝，且能用 AWS Builder ID 成功登入
- [ ] Kiro 的 Chat panel（`Cmd+L` / `Ctrl+L`）可以開啟並回應
- [ ] `git --version` 有輸出，且 `user.name` / `user.email` 已設定
- [ ] `curl --version`（Windows 用 `curl.exe --version`）與 `tar --version` 有輸出
- [ ] `node --version` ≥ 20
- [ ] Google Chrome 已安裝
- [ ] Starter kit 已取得（或確認能連上 GitHub）

- [ ] （選配）Context7 free API key 已取得並設為 `CONTEXT7_API_KEY`

---

## 背景知識

這是**中階**課程。有應用程式設計概念與基本程式能力會比較順，但不是硬性要求 — 過程中 Kiro 會協助。

有以下經驗會更容易上手：

- 用過 VS Code、JetBrains 或 Visual Studio 等開發環境
- 基本 Git 操作
- 基本終端機操作

---

[回到課程首頁](index.md) | [下一章：開始 Workshop →](01-setup.md)
