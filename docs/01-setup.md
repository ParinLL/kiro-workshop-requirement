# 第 1 章：開始 Workshop

**預估時間**：10 分鐘

本章目標：

- 下載並設定 Kiro IDE
- 認識 Kiro 的介面與核心功能
- 下載 Flappy Kiro starter kit，準備好開發環境

---

## 1.1 安裝 Kiro 並認識它

> 如果你已經在這台機器上安裝並使用過 Kiro，可直接跳到 [1.2 初始化專案](#12-初始化專案)。

### 用 AWS Builder ID 登入

本 workshop 使用 **AWS Builder ID** 連線 Kiro。

**AWS Builder ID** 是一組個人身分，讓你在**沒有 AWS 帳號**的情況下使用部分工具與服務。它與任何既有 AWS 帳號的憑證和資料互相獨立，而且免費。

> 用免費方案的 Builder ID 登入時，你不會建立任何資源，也不會產生任何費用。

可在 [AWS Builder ID 個人頁面](https://profile.aws.amazon.com/) 查看你的帳號資訊。

### 安裝 Kiro

1. 前往 [Kiro 下載頁](https://kiro.dev/downloads/)，選擇對應你平台的 **Download** 按鈕
2. 依指示下載並開啟 Kiro
3. 開啟後看到歡迎畫面，即代表安裝正常

### 首次開啟 Kiro

第一次開啟 Kiro 時，它會請你選擇一個登入提供者。本 workshop 使用 AWS Builder ID。

1. 選擇 **AWS Builder ID**
2. 依畫面指示完成授權
3. 登入後，可選擇是否匯入你的 VS Code 設定與擴充套件

其他登入方式（Google、GitHub、組織身分）請參考 [Authentication methods](https://kiro.dev/docs/) 文件。

---

## 1.2 認識 Kiro 介面

Kiro 的介面主要由這幾塊組成：

| 區塊 | 說明 |
|---|---|
| **Editor** | 中央的工作區，寫程式與編輯檔案的地方 |
| **Chat panel** | 與 AI 互動的專用面板：提問、要求修改程式、接收回應。點右上角的對話泡泡圖示開啟 |
| **Views** | 側邊欄，管理專案檔案、搜尋、版本控制 |
| **Status bar** | 顯示目前檔案、Git 狀態、錯誤與警告數量 |
| **Kiro panel** | Kiro 的 AI 功能區。點側邊欄的 Kiro 幽靈圖示開啟 |

**Command Palette** 可快速存取常用動作與 AI 工具：從 **View > Command Palette...** 選單開啟，或按 `Cmd+Shift+P`（Mac）/ `Ctrl+Shift+P`（Windows / Linux）。

### Chat panel

[Chat panel](https://kiro.dev/docs/) 是用自然語言操作程式碼的地方，可以用來：

- 詢問程式碼相關問題
- 要求產生或修改程式碼
- 協助除錯與排查問題
- 請它做程式碼審查與最佳化建議
- 產生樣板程式碼與範本

**Autopilot** 開關預設是開啟的。Autopilot 模式讓 agent 能跨整個 codebase 修改程式、在最少干預下完成複雜任務。若你想要細緻控制，可切換到 **Supervised** 模式 — Kiro 每輪結束後會停下來，讓你逐項接受、拒絕或討論個別變更。

在 chat panel 中可用 `#` 指定上下文（檔案、資料夾等），詳見 Context Providers 文件。

開啟 chat 的三種方式：

- **快捷鍵**：`Cmd+L`（Mac）/ `Ctrl+L`（Windows / Linux）
- **Command Palette**：`Cmd+Shift+P` / `Ctrl+Shift+P`，搜尋 `Kiro: Open Chat`
- **側邊欄**：`Cmd+Opt+B`（Mac）/ `Ctrl+Alt+B`，切換右側的 Kiro chat 圖示

### Kiro panel

Kiro panel 集中了 AI 專屬功能：

- **Specs** 總覽與管理
- **Agent Hooks** 管理
- **Agent Steering & Skills** 設定
- **MCP** servers

以下是這幾個概念的簡介，後續章節會實際操作：

**Specs（規格）** — 把複雜功能的開發流程正式化的結構化產出物。它提供一套系統性的方法，把高階想法轉換成可追蹤、可負責的詳細實作計畫。

**Agent Hooks** — 當 IDE 中發生特定事件時，自動執行預先定義的 agent 動作。與其每次手動要求例行工作，hooks 讓你針對檔案變更、送出 prompt、工具調用、任務執行等事件設定自動回應。

**Agent Steering & Skills** — [Steering](https://kiro.dev/docs/) 用 markdown 檔案給 Kiro 關於你工作區的持久知識。不必每次對話都重述你的慣例，steering 檔案能確保 Kiro 一致遵循你既有的模式、函式庫與標準。[Skills](https://kiro.dev/docs/) 則是可攜的指令包，把指令、腳本與範本打包成可重複使用的單位，Kiro 會在與任務相關時自動啟用。Kiro 支援開放的 Agent Skills 標準，所以你能匯入社群或其他相容 AI 工具的 skill，也能把自己的 skill 分享給團隊。

**MCP** — [Model Context Protocol](https://kiro.dev/docs/mcp/) 透過連接專門的 server 來擴充 Kiro 的能力，讓它取得額外的工具與上下文。用 MCP 你可以存取專門的知識庫與文件、整合外部服務與 API、以特定領域工具擴充 Kiro，或為自己的工作流打造自訂工具。

---

## 1.3 初始化專案

### 建立空白專案

<details open>
<summary><b>macOS</b></summary>

1. 在 Kiro 中，用 **File > Open Folder...** 開啟新資料夾
2. 切換到你要放專案的目錄，選 **New Folder**
3. 命名為 `kiro-introduction`，選 **Create**
4. 選 **Open**
5. 若出現提示，勾選 **Trust the authors**，再選 **Yes, I trust the authors**

</details>

<details>
<summary><b>Windows</b></summary>

1. 在 Kiro 中，用 **File > Open Folder...** 開啟新資料夾
2. 切換到你要放專案的目錄，右鍵選 **New > Folder**
3. 命名為 `kiro-introduction`
4. 選 **Select Folder**
5. 若出現提示，勾選 **Trust the authors**，再選 **Yes, I trust the authors**

</details>

### 下載專案素材

Starter kit 放在本 repo 的 [`starter-kit/`](../starter-kit/) 目錄，約 1.6 MB。

<details open>
<summary><b>macOS / Linux</b></summary>

1. 用 **Terminal > New Terminal** 選單開啟新的終端機視窗
2. 取得 starter kit 並把內容搬進你的專案資料夾：

```bash
curl -L https://github.com/ParinLL/kiro-workshop-requirement/archive/refs/heads/main.tar.gz \
  | tar -xz --strip-components=2 '*/starter-kit'
```

</details>

<details>
<summary><b>Windows（PowerShell）</b></summary>

1. 用 **Terminal > New Terminal** 選單開啟新的終端機視窗
2. 取得 starter kit 並把內容搬進你的專案資料夾：

```powershell
curl -L https://github.com/ParinLL/kiro-workshop-requirement/archive/refs/heads/main.zip -o repo.zip
Expand-Archive -Path repo.zip -DestinationPath tmp
Copy-Item -Path tmp\*\starter-kit\* -Destination . -Recurse -Force
Remove-Item -Recurse -Force tmp, repo.zip
```

</details>

> **行前已下載過的話**：直接把 `starter-kit/` 裡的 `assets/`、`img/`、`README.md`、`LICENCE.md`、`.gitignore` 複製進 `kiro-introduction` 資料夾即可，不用重新抓。

### 檢視初始專案

點 View 面板的 **Explorer** 圖示，檢視取得的檔案。

`assets` 資料夾是遊戲資源目錄，包含：

| 檔案 | 用途 |
|---|---|
| `ghosty.png` | 主角 Ghosty 的角色圖 (sprite) |
| `jump.wav` | 拍翅 / 跳躍音效 |
| `score.wav` | 計分音效 |
| `game_over.wav` | 碰撞 / 遊戲結束音效 |
| `bgm.wav` | 遊玩中的背景音樂（可無縫循環） |
| `favicon.ico` | 瀏覽器頁籤圖示 |

`img` 資料夾包含 `example-ui.png`，是 Flappy Kiro 遊戲介面的示意圖 — 下一章會把它附加到 prompt 裡。

素材的詳細規格（尺寸、長度、格式）見 [starter-kit/README.md](../starter-kit/README.md)。

> 音效已備妥三種可聽覺區分的提示音，加上一段可循環的背景音樂。這代表你在需求階段就可以放心地把「音效回饋」與「背景音樂」寫進規格 — 素材都在。

### 初始化本機 Git repository

1. 用 **Terminal > New Terminal** 開啟新終端機
2. 把 `kiro-introduction` 資料夾初始化成一個空的本機 Git repository：

```bash
git init
```

3. 建立第一個 commit：

```bash
git add .
git commit -m 'Initial commit'
```

> 本 workshop 中，每完成一個階段你都會 commit 一次。
>
> 這件事可以讓 Kiro 自動化，連 commit message 都幫你產生 — 詳見[第 8 章的 Hooks 段落](08-going-further.md#83-hooks)。

---

## 本章小結

你已完成 IDE 設定，包含建立專案目錄、下載 workshop 檔案，並初始化了本機 Git repository。

接下來要用 Kiro 來規格化並建構應用程式。

---

[← 行前準備](00-prerequisites.md) | [下一章：產生需求規格 →](02-requirements.md)
