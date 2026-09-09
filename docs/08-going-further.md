# 第 8 章：（選配）更進一步

現在你已經掌握使用 Kiro 的基本功，可以探索更多能力，用進階的 agentic 功能進一步提升生產力。

**以下主題可以任意順序進行**，而且在 spec 或 vibe 模式下都能使用。

| 主題 | 內容 |
|---|---|
| [8.1 Subagents](#subagents) | 用平行執行與專門化 agent 加速開發 |
| [8.2 Checkpointing](#checkpointing) | 儲存與還原 agent 狀態 |
| [8.3 Hooks](#hooks) | 自動執行品質檢查與維護工作 |
| [8.4 MCP servers](#mcp) | 透過 Model Context Protocol 連接外部服務 |
| [8.5 Skills](#skills) | 打包可重用的指令，讓 Kiro 在相關時自動啟用 |

> **本課程範圍說明**：AWS 原版的 Going further 還有 **Kiro Powers** 與 **Kiro CLI** 兩節，內容都聚焦在 AWS 部署，因此本課程未納入。有興趣可自行參考 [Kiro 官方文件](https://kiro.dev/docs/)。

---

<a id="subagents"></a>

## 8.1 Subagents

[Subagents](https://kiro.dev/docs/subagents/) 讓 Kiro 能平行執行多個任務，或把特定任務委派給專門化的 agent。Kiro 會在適當時機自動啟動 subagent，你也可以用 `執行 subagents 來...` 這類 prompt 手動觸發。

Kiro 內建兩個 subagent：

| Subagent | 用途 |
|---|---|
| **Context gathering** | 探索專案、收集相關上下文 |
| **General purpose** | 平行處理其他所有任務 |

Subagent 並行執行，主 agent 會等所有 subagent 完成後才繼續。結果完成後會自動回傳給主 agent。

**每個 subagent 有自己獨立的 context window**，因此不會污染主 agent 的上下文。這是 subagent 最實際的價值 — 探索大量檔案這種會吃掉大量上下文的工作，交給 subagent 做，主 agent 只收到結論。

> Subagent **無法存取 Specs**，而且 **Hooks 不會在 subagent 中觸發**。

### 用 subagents 做平行分析

```
用 subagents 分析 Ghosty.js、Wall.js 和 GameEngine.js 的效能最佳化空間。
```

```
執行 subagents 平行檢查碰撞偵測、物理運算與繪製邏輯。
```

```
啟動 subagents 同時檢視遊戲狀態管理、輸入處理與動畫系統。
```

### 建立自訂的 code reviewer subagent

在工作區的 `.kiro/agents` 目錄下新增一個 markdown 檔案，即可建立專門的程式碼審查 subagent。

`.kiro/agents/code-reviewer.md` 範例：

```markdown
---
name: code-reviewer
description: 專業的程式碼審查助手。
tools: ["read", "@context7"]
model: claude-sonnet-4
---

你是一位資深程式碼審查者。

## 你的職責
- 審查程式碼的正確性、效能與安全性
...
```

建立後，你可以用 `用 code-reviewer subagent 找出我程式碼中的效能問題` 來呼叫它，或透過 `/code-reviewer` slash command。

<a id="doc-research"></a>

### 用 subagents 做文件研究

```
用 subagents 研究 Canvas API 最佳實務、requestAnimationFrame 最佳化，
以及碰撞偵測演算法。
```

```
執行 subagents 尋找關於遊戲主迴圈模式、sprite 動畫技巧，
以及瀏覽器效能分析的文件。
```

> 這一段搭配 [8.4 的 Context7 MCP](#context7) 效果最好 — subagent 負責平行化，Context7 負責提供各函式庫的即時文件。

### （選配）用 subagents 做測試

```
用 subagents 獨立測試 Ghosty 移動、牆面生成與碰撞偵測。
```

```
執行 subagents 平行驗證遊戲狀態一致性、計分邏輯與物理運算。
```

### 小結

你學會用 subagent 平行化任務、建立自訂的專門 agent，並透過並行執行大幅加速開發流程。

---

<a id="checkpointing"></a>

## 8.2 Checkpointing

[Checkpointing](https://kiro.dev/docs/checkpoints/) 讓你能把 Kiro 的變更回捲到開發過程中的任一時間點。Kiro 修改你的 codebase 時，會自動在對話歷史中建立 checkpoint 標記。每個 checkpoint 記錄了該次 session 中 Kiro 對檔案所做的具體變更。

> 請注意：
>
> - Checkpointing **只會回復本次 session 中由 Kiro 所做的檔案變更**
> - 還原 checkpoint 會回復**完整的檔案狀態**，而不只是 Kiro 的那部分變更

幾個實際的使用情境：

| 情境 | 說明 |
|---|---|
| **安全實驗** | 在 Kiro 中做改動，若結果不如預期就還原到 checkpoint |
| **迭代精修** | 在找到正確解法前嘗試幾種變化 — 試一種、評估、必要時還原再試下一種 |
| **探索不同實作** | 嘗試在架構中使用某些元件；若不合適就還原，改用其他元件再比較 |
| **從誤解中復原** | 當某個 prompt 不夠精確或不完整而導致錯誤變更時，可以回捲 |

### 進行一次實驗性變更

在 chat panel 中，請 Kiro 做一個實驗性的改動。

```
改用鍵盤上下鍵而不是空白鍵來操控 Ghosty。
```

```
執行遊戲時，以全螢幕模式啟動。
```

當你在 chat 中送出 prompt 時，可以看到系統已經設下一個 checkpoint。

### 還原變更

1. 在 chat panel 中回到最後一個 checkpoint，選 **Restore**

   會出現訊息提示：完成還原後，你將失去該 checkpoint 之後的所有變更。

2. 選 **Confirm**。你會看到最近的變更消失了

### 小結

你使用了 Kiro 的 checkpointing 功能來安全地實驗程式碼變更，並把檔案還原到先前的狀態。Checkpoint 讓你能嘗試不同做法、評估結果、必要時回捲 — 在不冒著失去可用程式碼的風險下進行迭代開發。

---

<a id="hooks"></a>

## 8.3 Hooks

[Agent Hooks](https://kiro.dev/docs/hooks/) 是強大的自動化工具，當 IDE 中發生特定事件時，自動執行預先定義的 agent 動作，藉此簡化你的開發流程。有了 hooks，你不需要手動要求例行工作，也能確保整個 codebase 的一致性。

Agent Hooks 可針對檔案變更、送出 prompt、工具調用、任務執行以及手動觸發等事件設定自動回應。

透過為常見工作設定 hooks，你可以：

- 維持一致的程式碼品質
- 預防安全漏洞
- 減少手動負擔
- 標準化團隊流程
- 加快開發循環

### 建立 Git 自動化 hook

讓 Kiro 完成任務時自動把所有變更 commit 到 Git repository。

```
當我儲存檔案時，自動 stage 並在本機 commit，
commit message 依實際變更內容產生描述性的說明。
未經我同意絕不 push 到遠端。
```

> **這個 hook 很值得做**。本 workshop 每個階段都要 commit，設好之後就不用再手動輸入 git 指令。注意 prompt 最後那句 — 明確禁止自動 push 是重要的安全邊界。

### 建立程式碼品質 hook

```
建立一個手動觸發的 hook，用來落實遊戲程式碼標準、類別命名慣例與效能模式。
```

```
產生程式碼品質 hook，檢查 Canvas API 用法、事件處理器最佳化與記憶體管理。
```

```
建立 hook 驗證遊戲架構模式、模組化設計與碰撞偵測演算法。
```

```
產生標準 hook，檢查 animation frame 處理、輸入反應性與素材管理效率。
```

### 建立文件同步 hook

監聽原始碼變更，自動更新 README 或 docs 資料夾中的專案文件。

```
當我儲存 `README.md` 或 docs 資料夾中的任何 `.md` 檔案時，
自動以 "docs: update [filename]" 為訊息 commit，並附上變更摘要。
```

### （選配）建立效能監控 hook

```
建立一個 hook，在遊戲檔案儲存時監控 frame rate、記憶體使用量與 Canvas 效能。
```

```
產生效能 hook，檢查 FPS 掉幀、碰撞偵測效率與繪製最佳化。
```

```
建立 hook 驗證遊戲效能是否達到 60 FPS 目標，並對 *.js 檔案做記憶體洩漏偵測。
```

```
產生效能監控 hook，檢查動畫流暢度、物理運算與素材載入時間。
```

### （選配）建立遊戲狀態驗證 hook

```
建立 hook，在 Ghosty、Wall 或 GameEngine 類別被修改時驗證遊戲狀態一致性。
```

```
產生驗證 hook，檢查碰撞邊界、物理常數與計分邏輯的完整性。
```

```
建立 hook 檢查遊戲機制的平衡性、難度遞增與牆面缺口尺寸的合理性。
```

```
產生遊戲狀態 hook，檢查 Ghosty 的移動邊界、牆面生成規則與分數計算正確性。
```

### 測試 hooks

體驗 hooks 如何融入你的遊戲開發流程：

1. 儲存一個遊戲元件 → 效能稽核執行
2. 修改遊戲機制 → 驗證 hook 觸發
3. 執行程式碼品質 hook → 檢查標準遵循情況

### 小結

你實作了自動化的品質保證 hooks，確保遊戲效能、驗證遊戲邏輯一致性，並在整個 Flappy Kiro 開發過程中維持程式碼品質標準。

---

<a id="mcp"></a>

## 8.4 MCP servers

[Model Context Protocol](https://kiro.dev/docs/mcp/)（MCP）透過連接專門的 server 來擴充 Kiro 的能力，讓它取得額外的工具與上下文。

有了 MCP，你可以：

- 存取專門的知識庫與文件
- 整合外部服務與 API
- 以特定領域的工具擴充 Kiro
- 為你自己的工作流打造自訂工具

### 前置需求

MCP server 大多以 `npx` 執行，因此需要 **Node.js 20 或以上**。Playwright MCP 另外需要系統已安裝 **Google Chrome**。兩者都在[行前準備的必備清單](00-prerequisites.md#items)裡，安裝指令見[一次裝完](00-prerequisites.md#oneshot)。

### 安裝 Playwright MCP Server

[Playwright](https://playwright.dev/) MCP server 讓你能在 Kiro 中進行自動化瀏覽器測試與網頁操作 — 以程式方式與網頁互動、擷取螢幕截圖，並驗證應用程式在不同瀏覽器中的功能。

1. 在瀏覽器中前往 [Kiro Server Directory](https://kiro.dev/docs/mcp/servers/)
2. 找到 **Playwright**，選 **＋ Add to Kiro**
3. 若出現提示，選 **Open Kiro**
4. MCP 設定檔會顯示出來，並已設定為啟用 Playwright server
5. 點 View 面板的 Kiro 圖示，你會在 **MCP SERVERS** 下看到 `playwright`，狀態為 **Disabled**
6. 用右鍵選單選 **Enable**。幾秒後狀態會變成 **Connected**
7. 展開 Playwright server 可看到可用的工具

> 如果 MCP server 連不上，選 **Ask Kiro** 把 log 送到 Kiro chat 視窗，Kiro 會協助排解。

### 使用 MCP server

用 Playwright MCP server 檢查你的應用程式是否正常運行且沒有錯誤。

```
執行 Flappy Kiro。用 Playwright 檢查應用程式正常運行，且沒有 console 錯誤。
```

```
啟動遊戲，並用 Playwright 擷取一張螢幕截圖。
```

出現提示時，選 **Auto-approve** 並接受。

> **重要：Playwright MCP 預設封鎖 `file://` 協定。**
>
> 如果你用瀏覽器直接開啟 `index.html`，Playwright MCP 會拒絕存取並回報錯誤。請改用本機靜態伺服器：
>
> ```bash
> npx -y serve -l 8000        # 推薦，跨平台一致
> # 或
> python3 -m http.server 8000 # macOS；Windows 不內建 Python
> ```
>
> 然後讓 Playwright 檢查 `http://localhost:8000`。

<a id="context7"></a>

### （選配）加裝 Context7

[Context7](https://context7.com/) 提供任何函式庫與框架的**即時最新文件**，同樣可從 [Kiro Server Directory](https://kiro.dev/docs/mcp/servers/) 一鍵安裝。

它和 [8.1 的 subagents 文件研究](#doc-research)搭配特別有用 — 想深入 Canvas 2D、Web Audio 或 `requestAnimationFrame` 的當前用法時，能拿到準確的資料而不是模型的舊記憶。

> **注意 rate limit**：不帶 API key 也能使用，但匿名額度是**按 IP** 計算。如果整間教室走同一個對外 IP，很容易撞到限制。建議在 [context7.com/dashboard](https://context7.com/dashboard) 申請免費 API key，設為環境變數 `CONTEXT7_API_KEY`。

### （選配）其他 MCP 探索方向

以下是原版 workshop 提供的探索方向。這些需要外部服務，**在課堂時間內不一定做得完**，可當作課後練習。

**Sprite 生成**

```
設定 Pixel API MCP，用來產生 Ghosty 角色 sprite、牆面材質與背景素材。
```

```
設定 sprite 生成 MCP，用於角色動畫影格、粒子效果與 UI 元素。
```

**音訊處理**

```
設定一個音訊 MCP server，產生拍翅、計分、碰撞的音效與背景音樂。
```

```
建立一個音訊處理 MCP server，具備格式轉換、壓縮與循環最佳化功能。
```

**遊戲分析與排行榜**

```
設定分析 MCP，追蹤玩家分數、遊玩時長與遊玩模式。
```

```
建立排行榜 MCP，具備最高分持久化、玩家排名與成就追蹤。
```

### 小結

你把 MCP server 整合進 Kiro，提供強大的擴充能力，Kiro 會在需要時自動使用它們。

---

<a id="skills"></a>

## 8.5 Skills

[Skills](https://kiro.dev/docs/skills/) 是可攜的指令包，把指令、腳本與範本打包成可重複使用的單位，Kiro 會在與你的任務相關時自動啟用。它們建立在開放的 [Agent Skills 標準](https://agentskills.io/specification) 之上，所以你能匯入社群或其他相容 AI 工具的 skill，也能把自己的 skill 分享給團隊。

> **Steering 與 Skills 互補**。[Steering](05-steering.md) 提供 Kiro 關於工作區的持久、隨時可用的知識。Skills 則是可攜的套件，只在任務與其描述相符時才按需載入。

Skills 採漸進式載入，因此只在需要時才消耗上下文：

| 階段 | 行為 |
|---|---|
| **Discovery** | 啟動時，Kiro 只讀取每個 skill 的名稱與描述 |
| **Activation** | 當請求與某個 skill 的描述相符時，Kiro 載入完整指令 |
| **Execution** | 腳本與參考檔案只在任務需要時才載入 |

Skills 可存放在兩個位置：

| 位置 | 路徑 | 適用情境 |
|---|---|---|
| **工作區** | `.kiro/skills/` | 只在該工作區可用。適合想與團隊共享的專案專屬流程 |
| **全域** | `~/.kiro/skills/` | 跨所有工作區可用。適合個人流程 |

若名稱衝突，工作區的 skill 優先。

Skill 定義在一個資料夾中，必須包含 `SKILL.md`，並可選擇性包含 `scripts`、`references`、`assets` 子資料夾。

### 建立一個 skill

請 Kiro 建立一個 skill，用來依照你 steering 檔案中的慣例，產生新的遊戲實體類別骨架。

```
建立一個 skill，依照我的 steering 檔案產生新的遊戲實體類別骨架，
包含 physics、render 與 collision 方法。
```

```
建立一個名為 entity-scaffold 的 skill，產生符合 Ghosty 與 Wall 結構的
新 Flappy Kiro 實體類別。
```

```
建立一個 skill，產生具備 update、draw、reset 方法以及一致 JSDoc 註解的
遊戲物件樣板。
```

Kiro 會建立 `.kiro/skills/entity-scaffold/SKILL.md`。**名稱必須與資料夾名稱相同**，且只能使用小寫字母、數字與連字號。

> **提示**：Kiro 依據 skill 的**描述**來決定何時啟用它。描述寫得精確、包含關鍵字，Kiro 才會在正確時機啟用。

`SKILL.md` 範例：

```markdown
---
name: entity-scaffold
description: 產生 Flappy Kiro 遊戲實體類別骨架，包含 physics、render 與 collision 方法。在建立新的遊戲物件或實體時使用。
---

## 產生遊戲實體骨架

1. 在 `Ghosty.js` 與 `Wall.js` 所在的同一目錄下建立新的類別檔案。
2. 加入 constructor，設定 position、velocity 與 size。
3. 實作 `update()` 處理物理、`draw(ctx)` 負責繪製、
   `getBounds()` 用於碰撞偵測。
4. 遵循 steering 檔案中定義的命名慣例與 JSDoc 風格。
5. 把該實體註冊到 game engine，使它每一幀都會被更新與繪製。
```

### 使用 skill

只要請求與 skill 的描述相符，Kiro 就會自動啟用它。請 Kiro 建立一個新實體，觀察它如何套用 skill 的指令。

```
建立一個新的 Coin 實體，Ghosty 可以收集它來獲得額外分數。
```

```
在背景加入一個會移動的 Cloud 實體。
```

你也可以明確呼叫 skill — 在 chat 輸入框打 `/`，會列出你的 skills 作為 slash command，選 `/entity-scaffold` 即可精確控制何時執行。

### （選配）匯入 skill

因為 skills 遵循開放的 Agent Skills 標準，你可以從 GitHub 或本機資料夾匯入並立即使用。

1. 在 Kiro panel 中開啟 **Agent Steering & Skills** 區塊
2. 選 **＋**，再選 agent skills
3. 選擇來源：
   - **GitHub** — 公開 repository 的 URL，需指向該 skill 的**子目錄**（不是 repository 根目錄）
   - **Local folder** — 從你的檔案系統匯入

匯入的 skill 會被複製到你的 skills 目錄，可立即使用。

### 小結

你建立了一個可重用的 skill，把「產生新 Flappy Kiro 實體」的慣例打包起來，看到 Kiro 在請求符合描述時自動啟用它，也學會如何明確呼叫與匯入 skill。Skills 讓你把重複出現的工作流捕捉一次，然後跨專案、跨團隊、跨其他相容 Agent Skills 的工具重複使用。

---

## 全課程總結

你完成了整個 Flappy Kiro workshop。回顧一下你實際體驗過的東西：

| 能力 | 你做了什麼 |
|---|---|
| **Spec-driven development** | 從一句話的想法，走過 requirements → design → tasks，再到可運行的遊戲 |
| **Steering** | 用持久的專案慣例約束 Kiro 的產出 |
| **Agentic build** | 讓 Kiro 自主執行任務、自我檢查並迭代修正 |
| **Subagents** | 用獨立上下文的平行 agent 加速分析與研究 |
| **Checkpointing** | 安全實驗，不滿意就回捲 |
| **Hooks** | 把例行工作自動化 |
| **MCP** | 連接外部工具擴充 Kiro 的能力 |
| **Skills** | 把重複流程打包成可攜、可分享的指令包 |

這些技巧不限於遊戲開發 — 同一套流程可以直接套用到任何領域的軟體專案。

### 延伸資源

- [Kiro 官方文件](https://kiro.dev/docs/)
- [Kiro Discord 社群](https://discord.gg/kirodotdev)
- [Kiro GitHub 範例](https://github.com/kirodotdev)
- [Spec-driven development 部落格文章](https://kiro.dev/blog/kiro-and-the-future-of-software-development)

---

[← 上一章：執行 Flappy Kiro](07-run.md) | [回到課程首頁](index.md)
