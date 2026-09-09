# 第 5 章：建立 Steering 檔案

**預估時間**：本章與第 6 章合計約 15 分鐘

本章你要建立 agent steering 檔案，確保 Flappy Kiro 開發過程中的程式碼模式保持一致。

---

## 5.1 什麼是 Steering

[Steering 檔案](https://kiro.dev/docs/steering/) 是 markdown 檔案，在你與 Kiro 的全部或部分互動中提供額外的上下文與指令。它們適合用來定義團隊標準、專案慣例，或是關於「如何建置、測試、操作這個 codebase」的有用資訊 — 讓 Kiro 一致遵循你的偏好，而不需要你在每次對話中重複交代。

Steering 檔案的作用範圍可以是專案層級或工作區層級。

Steering 檔案支援不同的納入模式：

| 模式 | 行為 |
|---|---|
| `always` | 預設值，一律納入 |
| `fileMatch` | 依檔案模式條件式納入 |
| `manual` | 在 chat 中用 `#` 手動納入 |
| `auto` | 當描述與當前任務相符時自動納入 |

---

## 5.2 基礎 steering 檔案

Kiro 可以自動產生 steering 檔案 — 使用 **Agent Steering & Skills** 面板上的 **＋** 圖示。Kiro 會建立三個基礎檔案：

| 檔案 | 內容 |
|---|---|
| `product.md` | 產品context — 這個專案是什麼、為誰而做 |
| `tech.md` | 技術棧與模式 |
| `structure.md` | 專案的目錄與檔案佈局 |

這三份檔案讓 Kiro 在你加入任何自訂 steering 之前，就先具備關於專案的基本認識。

> **建議先做這一步**。基礎 steering 是後面所有自訂 steering 的地基 — 例如 `tech.md` 一旦寫明「vanilla Canvas、不用框架、不用打包工具」，Kiro 後續就不會擅自引入 npm 套件。

---

## 5.3 自訂 steering 檔案

自訂 steering 檔案可以針對特定的流程、情境或標準。

### 建立遊戲程式碼標準

建立一個 steering 檔案來指定程式碼標準，協助 Kiro 在整個工作區維持一致的寫法。

在 chat panel 中，請 Kiro 建立遊戲開發程式碼標準的 steering 檔案：

```
建立一個程式碼標準 steering 檔案，包含 JavaScript 遊戲設計模式、
類別命名慣例，以及效能最佳化準則。
```

```
建立 steering 檔案，包含 Canvas API 使用模式、animation frame 處理方式，
以及有效率的碰撞偵測演算法。
```

```
為 Flappy Kiro 產生遊戲架構標準，包含模組化系統、事件處理模式，
以及狀態管理方式。
```

---

## 5.4 （選配）建立其他自訂 steering 檔案

### 遊戲機制與物理

```
建立 `.kiro/steering/game-mechanics.md`，包含 Flappy Kiro 的物理常數、
移動演算法與碰撞偵測模式。
```

```
產生遊戲機制 steering，包含 Ghosty 的移動物理、牆面生成演算法，
以及計分系統模式。
```

```
建立 steering 檔案，包含重力模擬、輸入處理的反應性，以及障礙物生成邏輯。
```

```
產生物理 steering，包含精確的碰撞邊界、動量計算，以及平滑的動畫插值。
```

### 視覺與音訊設計

```
建立 `.kiro/steering/visual-design.md`，包含 sprite 繪製模式、動畫系統，
以及粒子效果準則。
```

```
產生視覺設計 steering，包含 Ghosty 的角色動畫、牆面材質，
以及背景的視差效果。
```

```
建立 steering 檔案，包含 Canvas 繪製最佳化、sprite atlas 的使用，
以及視覺回饋模式。
```

```
產生視聽 steering，包含音效整合、畫面震動機制，以及 UI 動畫模式。
```

### Flappy Kiro 領域專屬

```
建立 `.kiro/steering/flappy-kiro-domain.md`，包含遊戲狀態管理、
分數持久化，以及難度遞增模式。
```

```
產生 Flappy Kiro 領域 steering，包含障礙物生成規則、缺口尺寸演算法，
以及速度的漸進遞增。
```

```
建立 steering 檔案，包含遊戲場次管理、最高分追蹤，以及重新開始功能的模式。
```

```
產生領域 steering，包含 Ghosty 的行為模式、牆面碰撞反應，
以及遊戲結束狀態的處理。
```

---

## 5.5 測試 steering 檔案

透過建立遊戲元件來驗證你的 steering 檔案是否生效。

檢視產出的程式碼，確認它符合你的要求。

```
建立一個 Ghosty 角色類別，包含物理屬性、動畫狀態與碰撞偵測，
並遵循遊戲標準。
```

```
產生一個 `WallObstacle` 類別，包含定位、移動與碰撞邊界，並遵循程式碼準則。
```

```
建立一個 `GameEngine` 類別，包含主迴圈、狀態管理與繪製系統，
並遵循我們的架構模式。
```

> **怎麼判斷 steering 有生效**：看產出的程式碼是否自動符合你寫在 steering 裡的慣例 — 命名風格、註解格式、有沒有用你禁止的東西。如果沒有生效，通常是 steering 檔案的描述太模糊，或納入模式設成了 `manual` 而沒有用 `#` 引用。

---

## 本章小結

你已建立完整的 steering 檔案，它們會自動落實一致的遊戲開發標準。這些檔案會引導後續所有的程式碼產生，讓程式遵循遊戲架構最佳實務、效能最佳化模式，以及 Flappy Kiro 專屬的領域邏輯。

---

[← 上一章：產生實作任務](04-tasks.md) | [下一章：建構應用程式 →](06-build.md)
