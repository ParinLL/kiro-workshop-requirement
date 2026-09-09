# Flappy Kiro — Starter Kit

這是 Flappy Kiro workshop 的起始資料夾，包含遊戲所需的素材資源。

你**不需要**自己準備任何素材，也不需要有美術或音效能力 — 全部都已備妥。你的工作是用 Kiro 把遊戲做出來。

## 遊戲介面示意

![Flappy Kiro UI](img/example-ui.png)

在[第 2 章產生需求規格](../docs/02-requirements.md)時，你會把這張圖附加到 prompt 裡，讓 Kiro 理解你想要的外觀。

## 資源清單

### `img/`

| 檔案 | 尺寸 | 用途 |
|---|---|---|
| `example-ui.png` | 809 × 655 | 遊戲介面示意圖，供 prompt 附圖使用 |

### `assets/`

| 檔案 | 規格 | 用途 |
|---|---|---|
| `ghosty.png` | 1290 × 1567 PNG (RGBA) | 主角 Ghosty 的角色圖 |
| `jump.wav` | 0.37 秒 | 拍翅 / 跳躍音效 |
| `score.wav` | 0.28 秒 | 計分音效，明亮的「叮咚」兩個上升音 |
| `game_over.wav` | 0.49 秒 | 碰撞 / 遊戲結束音效，短促的上升琶音 |
| `bgm.wav` | 3.75 秒 | 遊玩中的背景音樂，可無縫循環 |
| `favicon.ico` | 32 × 32 | 瀏覽器頁籤圖示 |

音訊全部是 44.1 kHz、16-bit、雙聲道 WAV。

## 幾點說明

**三個音效彼此在聽覺上可明確區分**，這是刻意設計的 — 玩家不用看畫面也能分辨「我拍翅了」、「我得分了」、「我撞到了」。

**`bgm.wav` 可無縫循環**。它的開頭與結尾都刻意做成接近靜音，所以用 `loop = true` 播放時銜接處不會有爆音。

**為什麼是 WAV 而不是 MP3 / OGG**：目前所有主流瀏覽器（Chrome、Firefox、Safari、Edge）都支援透過 `<audio>` / `Audio()` 播放 WAV，對本 workshop 而言功能上完全等價，而且不需要任何編碼工具。若你想改用 MP3 或 OGG，自行重新編碼並更新程式中的載入路徑即可，不需要改動其他程式。

**`ghosty.png` 解析度遠大於遊戲中的顯示尺寸**。你可以請 Kiro 在繪製時縮放，或是切出 sprite sheet — 這屬於設計決策，交給你和 Kiro 在設計階段討論。

## 授權與來源

授權為 **MIT-0**（MIT No Attribution），詳見 [LICENCE.md](LICENCE.md)，可自由使用、修改與散布。

`ghosty.png`、`jump.wav`、`img/example-ui.png` 來自 AWS 原版 Kiro workshop starter kit。`score.wav`、`bgm.wav`、`favicon.ico` 與現行的 `game_over.wav` 是本課程為了讓音效更完整而重新製作的。
