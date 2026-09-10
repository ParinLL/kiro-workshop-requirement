# 第 2 章：產生需求規格

**預估時間**：本章與第 3、4 章合計約 25 分鐘

---

## 2.1 你要做什麼

你要建立 **Flappy Kiro** — 一款街機風格的無盡跑酷遊戲，玩家操控友善的幽靈角色 **Ghosty** 穿越一連串牆面障礙。

## 2.2 Vibe session 與 Spec session

在 chat 視窗與 Kiro 互動時，Kiro 會以 **Vibe** 或 **Spec** 兩種 session 模式運作：

- **Vibe session** — 互動式問答導向，適合快速提問、解釋說明，以及用較口語的方式建構專案
- **Spec session** — 引導你以結構化方式處理複雜開發任務，把軟體開發流程正式化。它會將高階想法轉換成有系統性執行與清楚追蹤的詳細實作計畫

啟動新 session 時可用 session 選擇器切換兩者，挑選最適合當下任務的互動風格。

## 2.3 Kiro 的 spec-driven development

Kiro 用三份規格檔案來架構開發流程：

| 檔案 | 內容 |
|---|---|
| **requirements.md** | 定義「要做什麼」— 使用者故事與驗收條件 |
| **design.md** | 說明技術方向與實作細節 |
| **tasks.md** | 把工作拆解成離散、可執行的步驟 |

流程是三個階段依序推進，每個階段都有你的確認關卡：

```
開始 Spec → requirements.md → 滿意？ ──否──→ 編輯 / 要求修改 ─┐
                                  │                        │
                                  是                       └─→ 回到 requirements.md
                                  ↓
                              design.md → 滿意？ ──否──→ 編輯 / 要求修改
                                  │
                                  是
                                  ↓
                              tasks.md → 滿意？ ──否──→ 編輯 / 要求修改
                                  │
                                  是
                                  ↓
                                 完成
```

> **提示**：如果你已經很清楚範圍，可以改用 **Quick Spec** 流程節省時間。Kiro 會先一次問清楚需要澄清的問題，然後單次產生 requirements、design 與 tasks，跳過階段之間的確認關卡 — 省去每個階段來回審核、等待的時間，適合範圍明確、不需要逐階段把關的小功能或修改。

### 可隨時中斷、續作

用 markdown 檔案來建立、更新與參照規格的一大好處是：你可以隨時停止再重啟 Kiro，並回到軟體設計流程中原本的位置。

> 若 Kiro 出現任何問題，直接關掉再重開，就能接續你的 workshop 進度。

---

## 2.4 建立應用程式規格

本節你要開始為 Flappy Kiro 撰寫規格，從初始需求開始。

你會用 **spec 模式**產生 Kiro 的 requirements 檔案。這些需求以使用者故事的形式撰寫，驗收條件採用 [EARS](https://alistairmavin.com/ears/)（Easy Approach to Requirements Syntax）記法。

在 Kiro chat panel 中：

- 可以用自然語言描述你想做的程式
- 可以用 `#` 提供額外上下文，例如指向既有的檔案或資料夾
- 甚至可以用 **Attach image or document** 圖示把圖片加進 prompt

操作步驟：

1. 選擇 **Spec**

2. 給 Kiro 一些關於 Flappy Kiro 的基本資訊。要把 UI 草稿一起放進 prompt，請選 **Add images** 圖示，選擇 `img/example-ui.png` 檔案

   範例 prompt：

   ```
   我想做一款叫 `Flappy Kiro` 的復古遊戲，在瀏覽器中執行。
   這是一款無盡卷軸遊戲，玩家要引導一個幽靈角色穿過一連串水管。
   外觀大致像附上的截圖。
   ```

3. 對 prompt 滿意後，按 `Enter` 送出

4. 因為這是新的應用程式，確認 **Build a Feature** 已選取，然後選 **Submit answer**

5. 當它問 **What do you want to start with?** 時，選 **Requirements**，再選 **Submit answer**

稍等一下，Kiro 會產生 `requirements.md` 檔案，建立需求草稿。關鍵項目的摘要也會顯示在 Kiro chat panel 中。

### 檢視需求草稿

`requirements.md` 位於 `.kiro/specs` 資料夾。點 View 面板的 Kiro 圖示，就能在 Kiro panel 的 **Specs** 區塊看到需求內容。

---

## 2.5 精修需求

檢視規格後，你可以請 Kiro 強化它。

### 調整雲朵

寫一個 prompt 來調整雲朵的呈現方式。

範例 prompt：

```
雲朵應該要半透明，並以不同速度移動，營造出景深感。
```

Kiro 會更新 `requirements.md`，並在 chat panel 摘要變更。要看更新內容，選 **View changes (1)**。

這會顯示更新後的檔案，以紅色標示刪除、綠色標示新增。

你也可以用 **Revert changes (1)** 撤銷更新。

### 繼續精修

持續精修需求，直到你對整體規格滿意。

> 以下是展示「精修需求有多大彈性」的範例 prompt — **不需要全部做完！**

```
加入完整的物理系統，包含：Ghosty 的重力常數、按下空白鍵時的上升速度、
終端速度上限、動量守恆，以及平滑的移動插值。
```

```
納入詳細的障礙物生成規則：成對牆面的間距、缺口大小、缺口位置隨機化、
牆面移動速度，以及速度的漸進遞增。
```

```
強化碰撞偵測：精確的 hitbox 定義、牆面碰撞邊界、地板與天花板偵測、
碰撞反應動畫，以及無敵幀 (invincibility frames)。
```

```
擴充遊戲狀態管理：主選單顯示最高分、遊玩狀態即時計分、暫停功能、
遊戲結束畫面含重新開始選項，以及分數持久化儲存。
```

```
加入音效與視覺回饋：拍翅、計分、碰撞的音效、背景音樂、碰撞時的畫面震動、
Ghosty 的粒子軌跡，以及視覺化分數指示。
```

每次調整後檢視結果，滿意再繼續。

---

## 2.6 （選配）分析需求

進入設計階段前，可以請 Kiro 分析需求中的不一致、模糊與缺口。Kiro 會針對**整份需求集合**進行推理 — 而不是逐條獨立看 — 因此能抓到單純逐條閱讀容易漏掉的問題。

1. 選 **Analyze Requirements**，請 Kiro 做深度分析
2. 對每個被指出的項目，選擇保留原規格，或是擴充規格納入建議的變更

---

## 2.7 完成需求

1. 在 IDE 終端機視窗中，把需求 commit 到本機 Git repository：

```bash
git add .
git commit -m 'Produced requirements'
```

2. 選 **Generate Tech Design**，告訴 Kiro 進入設計階段

---

## 本章小結

你已完成需求文件。

接下來要產生、審查、迭代並完成詳細的系統設計。

---

[← 上一章：開始 Workshop](01-setup.md) | [下一章：產生設計規格 →](03-design.md)
