# Kiro Workshop：用 Flappy Kiro 學 AI 輔助開發

<p align="center">
  <img src="starter-kit/img/example-ui.png" alt="Flappy Kiro" width="480">
</p>

這是一份**正體中文**的 Kiro 實作課程教材，改寫自 AWS 官方的 [Kiro Express workshop](https://catalog.workshops.aws/kiro-express/en-US/)。

你會從零建出 **Flappy Kiro** — 一款在瀏覽器中執行的街機風無盡跑酷遊戲，主角是友善的幽靈 **Ghosty**。過程中你會實際體驗 Kiro 的 **spec-driven development**：先定義需求，再與 AI 協作精修設計，然後引導 Kiro 逐項完成實作 — 而你全程掌握主導權。

---

## 課程資訊

| 項目 | 內容 |
|---|---|
| **時間** | 核心章節約 **90 分鐘**（第 1-7 章） |
| **難度** | 中階。有基本程式能力會更順，但 Kiro 會協助 |
| **費用** | **完全免費**。全程在本機執行，不建立任何 AWS 資源 |
| **適合對象** | 軟體工程師、low-code 轉型者，以及任何想體驗 AI 輔助開發的人 |
| **需要 AWS 帳號嗎** | **不需要**。只要一組免費的 AWS Builder ID 來登入 Kiro |

---

## 開始之前

**請先完成 [第 0 章：行前準備](docs/00-prerequisites.md)**，特別是 Kiro IDE 的安裝與登入。現場最常卡住的就是登入流程與企業防火牆。

快速檢查你的環境：

```bash
# macOS / Linux
bash scripts/check-prereqs.sh
```

```powershell
# Windows
.\scripts\check-prereqs.ps1
```

---

## 章節

| # | 章節 | 內容 | 時間 |
|---|---|---|---|
| 0 | [行前準備](docs/00-prerequisites.md) | 環境需求、防火牆設定、驗證清單 | 課前 |
| 1 | [開始 Workshop](docs/01-setup.md) | 安裝 Kiro、認識介面、取得 starter kit、`git init` | 10 分 |
| 2 | [產生需求規格](docs/02-requirements.md) | 用 Spec 產生並精修 `requirements.md` | 25 分<br>（2-4 合計） |
| 3 | [產生設計規格](docs/03-design.md) | 產生並精修 `design.md` | |
| 4 | [產生實作任務](docs/04-tasks.md) | 產生並精修 `tasks.md` | |
| 5 | [建立 Steering 檔案](docs/05-steering.md) | 定義專案慣例與程式標準 | 15 分<br>（5-6 合計） |
| 6 | [建構應用程式](docs/06-build.md) | 執行 tasks，讓 Kiro 把遊戲做出來 | |
| 7 | [執行 Flappy Kiro](docs/07-run.md) | 執行遊戲、修 bug、加功能 | — |
| 8 | [（選配）更進一步](docs/08-going-further.md) | Subagents、Checkpointing、Hooks、MCP、Skills | — |

---

## 你會學到的 Kiro 能力

| 能力 | 章節 |
|---|---|
| **Spec-driven development** — requirements → design → tasks 的結構化流程 | [2](docs/02-requirements.md) [3](docs/03-design.md) [4](docs/04-tasks.md) |
| **Steering** — 用持久的專案慣例約束 AI 產出 | [5](docs/05-steering.md) |
| **Agentic build** — 讓 Kiro 自主執行任務、自我檢查並迭代 | [6](docs/06-build.md) |
| **Subagents** — 獨立上下文的平行 agent | [8.1](docs/08-going-further.md#81-subagents) |
| **Checkpointing** — 安全實驗與回捲 | [8.2](docs/08-going-further.md#82-checkpointing) |
| **Hooks** — 事件驅動的自動化 | [8.3](docs/08-going-further.md#83-hooks) |
| **MCP** — 連接外部工具擴充能力 | [8.4](docs/08-going-further.md#84-mcp-servers) |
| **Skills** — 可攜、可分享的指令包 | [8.5](docs/08-going-further.md#85-skills) |

---

## Repo 結構

```
├── README.md                    # 本檔，課程索引
├── docs/                        # 課程章節（正體中文）
│   ├── 00-prerequisites.md
│   ├── 01-setup.md
│   ├── ...
│   └── 08-going-further.md
├── starter-kit/                 # 學員起始素材（約 1.6 MB）
│   ├── assets/                  # 角色圖 + 音效 + 背景音樂
│   ├── img/example-ui.png       # 遊戲介面示意圖
│   ├── README.md                # 素材規格說明
│   └── LICENCE.md               # MIT-0
└── scripts/
    ├── check-prereqs.sh         # 行前環境檢查（macOS / Linux）
    └── check-prereqs.ps1        # 行前環境檢查（Windows）
```

---

## 與 AWS 原版的差異

本教材在 AWS 原版的基礎上做了以下調整：

**移除的內容**

- **Deploy 章節** — 部署到 AWS / Vercel / Netlify
- **Clean up 章節** — 清理 AWS 資源（沒有部署就不需要）
- **Going further 的 Kiro CLI 與 Kiro Powers** — 兩者內容都聚焦在 AWS 部署

因此本課程**全程在本機執行、不需要 AWS 帳號與 AWS CLI、不會產生任何費用**。

**強化的內容**

- **更完整的音效素材** — 除了原版的 `ghosty.png`、`jump.wav`、`game_over.wav`，另外提供 `score.wav`（計分音）與 `bgm.wav`（可無縫循環的背景音樂），讓你在需求階段就能放心把音訊回饋寫進規格
- **Context7 MCP** — 原版未提及，本教材列為選配加分項，並說明教室環境的 rate limit 陷阱
- **實測過的行前準備細節** — Playwright MCP 的實際下載量、對系統 Chrome 的相依、以及它預設封鎖 `file://` 這個會影響 MCP 章節的行為
- **環境檢查腳本** — 兩個平台各一份，可在課前自我驗證

---

## 參考連結

- AWS 原版 workshop：<https://catalog.workshops.aws/kiro-express/en-US/>
- Kiro 官網：<https://kiro.dev/>
- Kiro 下載：<https://kiro.dev/downloads/>
- Kiro 文件：<https://kiro.dev/docs/>
- Kiro MCP Server Directory：<https://kiro.dev/docs/mcp/servers/>
- 防火牆設定：<https://kiro.dev/docs/privacy-and-security/firewalls/>
- AWS Builder ID：<https://profile.aws.amazon.com/>
- Kiro Discord 社群：<https://discord.gg/kirodotdev>
- Kiro GitHub 範例：<https://github.com/kirodotdev>

---

## 授權

Starter kit 素材為 **MIT-0**（詳見 [starter-kit/LICENCE.md](starter-kit/LICENCE.md)）。教材內容改寫自 AWS Kiro Express workshop。
