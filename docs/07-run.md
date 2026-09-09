# 第 7 章：執行 Flappy Kiro

本章你要執行 Flappy Kiro，並讓 Kiro 修正問題、實作你想要的強化功能。

---

<a id="run-game"></a>

## 7.1 執行遊戲

在 Kiro chat panel 中，指示 Kiro 啟動應用程式並確認它正在運行。

```
啟動 Flappy Kiro，並確認應用程式正常運行。
```

### 兩種執行方式

Flappy Kiro 是純前端的網頁遊戲，有兩種跑法：

| 方式 | 做法 | 注意事項 |
|---|---|---|
| **直接開檔** | 用瀏覽器開啟 `index.html` | 最簡單。前提是程式沒有使用 ES module（`import` / `export`），因為 `file://` 下的 module 載入在各瀏覽器行為不一致 |
| **本機靜態伺服器** | `npx -y serve -l 8000` 或 `python3 -m http.server 8000`，然後開 `http://localhost:8000` | 比較保險，`localStorage` 與音訊載入的行為和正式環境一致 |

> **如果你打算做[第 8 章的 MCP 章節](08-going-further.md#mcp)，請用本機靜態伺服器**。Playwright MCP 預設封鎖 `file://` 協定，直接開檔的話 MCP 無法檢查你的頁面。用 `http://localhost` 就沒這個問題。

---

## 7.2 修正問題並重試

如果 Flappy Kiro 沒有正常運行，指示 Kiro 調查並解決問題。

> 如果你不確定該怎麼修，用自然語言把問題描述給 Kiro，請它給建議。

---

## 7.3 （選配）用 Bugfix spec 修 bug

遇到難纏的 bug 時，可以啟動 **BugFix Spec**，而不是單純在 chat 中提出請求。Kiro 會帶你走過根因分析、針對性的修正，以及避免該 bug 再次出現的步驟 — 讓改動維持精準，不動到遊戲中原本正常的部分。

```
Ghosty 有時會穿過上方的牆面。啟動一個 bugfix spec 找出根因並修正，
不要改動其他碰撞行為。
```

---

## 7.4 （選配）擴充遊戲

有哪裡不滿意嗎？請 Kiro 擴充它！

```
把雲朵改成半透明，較近的雲朵以不同速度移動。
```

```
加入一個「不可能模式」，會反轉重力。它由通過一道紅色閘門觸發。
左上角要顯示一個 10 秒的倒數計時器，顯示效果剩餘時間。
```

```
給 Ghosty 一把雷射，可以在水管上打洞。充能需要 20 秒，
倒數計時器顯示在左下角。
```

```
為應用程式加上完整的 README，包含 mermaid 圖表說明程式碼如何組合在一起。
```

> 這一段是整個 workshop 最能體現 Kiro 價值的地方。前面的規格流程已經讓 Kiro 掌握了專案的完整脈絡，所以這種「加一個全新遊戲機制」的請求，它能一次做對的機率遠高於從零開始 vibe coding。試著提出一個規格裡完全沒提過的功能，看看它怎麼接。

---

## 7.5 完成你的遊戲

把應用程式 commit 到本機 Git repository。

```bash
git add .
git commit -m 'Flappy Kiro complete'
```

---

## 本章小結

你做出了一款 Flappy Kiro！看著 Ghosty 穿越水管、閃避障礙、對抗重力。加上你自訂的調整與強化功能，你已經完成一款可以拿去挑戰其他玩家的遊戲。

Game on! 🎮🚀

---

[← 上一章：建構應用程式](06-build.md) | [下一章：（選配）更進一步 →](08-going-further.md)
