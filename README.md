# Kiro Workshop：用 Flappy Kiro 學 AI 輔助開發

<p align="center">
  <img src="starter-kit/img/example-ui.png" alt="Flappy Kiro" width="480">
</p>

<p align="center">
  <b><a href="https://parinll.github.io/kiro-workshop-requirement/">📖 開始上課 → 課程網站</a></b>
</p>

正體中文的 Kiro 實作課程教材，改寫自 AWS 官方的 [Kiro Express workshop](https://catalog.workshops.aws/kiro-express/en-US/)。

從零建出 **Flappy Kiro** — 在瀏覽器中執行的街機風無盡跑酷遊戲，主角是幽靈 **Ghosty**。過程中實際體驗 Kiro 的 **spec-driven development**：先定義需求，再協作精修設計，然後引導 Kiro 逐項完成實作。

核心章節約 **90 分鐘**，**全程在本機執行、不需要 AWS 帳號、零費用**。

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
├── docs/                        # 課程章節（正體中文），同時是網站來源
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

**移除**：Deploy 與 Clean up 章節，以及 Going further 的 Kiro CLI 與 Kiro Powers（都聚焦在 AWS 部署）。因此全程本機執行、零費用。

**強化**：更完整的音效素材（多了計分音與可循環背景音樂）、Context7 MCP 的評估與 rate limit 提醒、實測過的 Playwright MCP 行前細節、兩個平台的環境檢查腳本。

詳見[課程首頁的完整說明](docs/index.md)。

---

## 授權

Starter kit 素材為 **MIT-0**（詳見 [starter-kit/LICENCE.md](starter-kit/LICENCE.md)）。教材內容改寫自 AWS Kiro Express workshop。
