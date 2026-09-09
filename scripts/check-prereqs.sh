#!/usr/bin/env bash
# Kiro Express workshop - 行前環境檢查 (macOS / Linux)
# 用法: bash scripts/check-prereqs.sh

set -uo pipefail

STARTER_KIT_URL='https://github.com/ParinLL/kiro-workshop-requirement'

pass=0
warn=0
fail=0

ok()   { printf '  \033[32m[OK]\033[0m   %s\n' "$1"; pass=$((pass + 1)); }
note() { printf '  \033[33m[WARN]\033[0m %s\n' "$1"; warn=$((warn + 1)); }
bad()  { printf '  \033[31m[FAIL]\033[0m %s\n' "$1"; fail=$((fail + 1)); }
head1() { printf '\n\033[1m%s\033[0m\n' "$1"; }

printf '\033[1mKiro Express workshop - 行前環境檢查\033[0m\n'
printf '%s\n' '========================================='

head1 '系統'
printf '  OS: %s %s (%s)\n' "$(uname -s)" "$(uname -r)" "$(uname -m)"

head1 '必備項目'

# --- Kiro IDE ---
kiro_found=""
for p in "/Applications/Kiro.app" "$HOME/Applications/Kiro.app" "/usr/share/kiro" "/opt/kiro"; do
  [ -e "$p" ] && kiro_found="$p" && break
done
if [ -z "$kiro_found" ] && command -v kiro >/dev/null 2>&1; then
  kiro_found="$(command -v kiro)"
fi
if [ -n "$kiro_found" ]; then
  ok "Kiro IDE 已安裝 ($kiro_found)"
else
  bad 'Kiro IDE 未找到 — 請從 https://kiro.dev/downloads/ 安裝'
fi

# 是否曾登入過 (存在設定目錄即代表啟動過)
if [ -d "$HOME/.kiro" ]; then
  ok "找到 ~/.kiro 設定目錄（Kiro 曾啟動過）"
else
  note '未找到 ~/.kiro — 請先開啟 Kiro 並以 AWS Builder ID 登入一次'
fi

# --- git ---
if command -v git >/dev/null 2>&1; then
  ok "git 已安裝 ($(git --version | awk '{print $3}'))"
  gname="$(git config --global user.name  2>/dev/null || true)"
  gmail="$(git config --global user.email 2>/dev/null || true)"
  if [ -n "$gname" ] && [ -n "$gmail" ]; then
    ok "git 身分已設定 ($gname <$gmail>)"
  else
    bad 'git user.name / user.email 未設定 — 請執行 git config --global user.name "..." 與 user.email "..."'
  fi
else
  bad 'git 未安裝'
fi

# --- curl ---
if command -v curl >/dev/null 2>&1; then
  ok "curl 已安裝 ($(curl --version | head -1 | awk '{print $2}'))"
else
  bad 'curl 未安裝'
fi

# --- tar（starter kit 解壓用）---
if command -v tar >/dev/null 2>&1; then
  ok 'tar 已安裝'
else
  bad 'tar 未安裝'
fi

# --- 音訊輸出提醒 ---
note '遊戲有音效與背景音樂 — 教室環境建議自備耳機'

# --- starter kit ---
# 若腳本是從 repo 內執行，starter-kit/ 應該就在旁邊；否則檢查能否連上 GitHub
SK_DIR="$(cd "$(dirname "$0")/.." 2>/dev/null && pwd)/starter-kit"
if [ -f "$SK_DIR/assets/ghosty.png" ] && [ -f "$SK_DIR/img/example-ui.png" ]; then
  n="$(find "$SK_DIR/assets" -type f ! -name 'README.md' 2>/dev/null | wc -l | tr -d ' ')"
  ok "Starter kit 已在本機 (${SK_DIR}，assets 共 ${n} 個素材檔)"
elif command -v curl >/dev/null 2>&1; then
  code="$(curl -s -o /dev/null -m 20 -w '%{http_code}' "$STARTER_KIT_URL" || echo 000)"
  if [ "$code" = "200" ]; then
    note "本機未找到 starter-kit/，但 GitHub 可連線 (HTTP $code) — 建議行前 git clone 下來"
  else
    bad "本機無 starter-kit/ 且無法連線 GitHub (HTTP $code) — 檢查網路或防火牆"
  fi
fi

# --- Kiro 端點連線 ---
head1 'Kiro 網路端點'
for host in app.kiro.dev assets.app.kiro.dev prod.us-east-1.auth.desktop.kiro.dev runtime.us-east-1.kiro.dev q.us-east-1.amazonaws.com; do
  if command -v curl >/dev/null 2>&1; then
    code="$(curl -s -o /dev/null -m 10 -w '%{http_code}' "https://$host" || echo 000)"
    if [ "$code" = "000" ]; then
      bad "$host 無法連線（防火牆 / DNS 可能阻擋）"
    else
      ok "$host 可連線 (HTTP $code)"
    fi
  fi
done

head1 '開發工具'

# --- Node.js ---
# 注意: nvm / fnm / volta / asdf 管理的 Node 在非互動 shell 中不會出現在 PATH,
# 因此除了 command -v 之外, 也直接探測常見安裝路徑。
resolve_node() {
  if command -v node >/dev/null 2>&1; then
    command -v node
    return 0
  fi
  local c
  for c in \
    "${NVM_DIR:-$HOME/.nvm}"/versions/node/*/bin/node \
    "$HOME"/.fnm/node-versions/*/installation/bin/node \
    "$HOME"/.local/share/fnm/node-versions/*/installation/bin/node \
    "$HOME"/.volta/bin/node \
    "$HOME"/.asdf/shims/node \
    /opt/homebrew/bin/node \
    /usr/local/bin/node
  do
    [ -x "$c" ] && printf '%s\n' "$c" && return 0
  done
  return 1
}

NODE_BIN="$(resolve_node || true)"
if [ -n "$NODE_BIN" ]; then
  nv="$("$NODE_BIN" --version | tr -d 'v')"
  major="${nv%%.*}"
  if [ "$major" -ge 20 ] 2>/dev/null; then
    ok "Node.js v$nv — $NODE_BIN"
  else
    note "Node.js v$nv 版本偏舊，建議升級到 20 LTS 以上"
  fi
  if ! command -v node >/dev/null 2>&1; then
    note 'node 不在預設 PATH（版本管理器如 nvm 造成）— Kiro 的 MCP 設定可能需要填絕對路徑'
  fi
else
  note 'Node.js 未安裝 — Kiro 產出的測試與 MCP 章節都會用到。macOS: brew install node / Windows: winget install OpenJS.NodeJS.LTS'
fi

# --- Google Chrome (Playwright MCP 預設使用系統 Chrome) ---
chrome_found=""
for p in "/Applications/Google Chrome.app" "$HOME/Applications/Google Chrome.app" \
         "/usr/bin/google-chrome" "/usr/bin/google-chrome-stable" "/opt/google/chrome/chrome"; do
  [ -e "$p" ] && chrome_found="$p" && break
done
if [ -n "$chrome_found" ]; then
  ok "Google Chrome 已安裝 ($chrome_found) — Playwright MCP 可直接使用"
else
  note 'Google Chrome 未找到 — Playwright MCP 預設走系統 Chrome。macOS: brew install --cask google-chrome'
fi

# --- Playwright MCP 套件快取是否已暖機 ---
if [ -n "$NODE_BIN" ]; then
  if find "$HOME/.npm/_npx" -maxdepth 3 -type d -name '*playwright*' 2>/dev/null | grep -q . \
     || find "$HOME/.npm/_npx" -maxdepth 4 -path '*@playwright*' 2>/dev/null | grep -q .; then
    ok 'Playwright MCP 套件已在 npx 快取中（現場不需重新下載）'
  else
    note 'Playwright MCP 尚未快取（首次啟動需下載約 57 MB）— 建議行前執行: npx -y @playwright/mcp@latest --version'
  fi
fi

# --- 本機靜態伺服器（MCP 章節需要，因 Playwright MCP 封鎖 file://）---
srv_found=''
if [ -n "$NODE_BIN" ] && find "$HOME/.npm/_npx" -maxdepth 4 -type d -name 'serve' 2>/dev/null | grep -q .; then
  srv_found='npx serve（已快取）'
fi
if [ -z "$srv_found" ]; then
  for p in "$(command -v python3 2>/dev/null)" /usr/bin/python3 /opt/homebrew/bin/python3; do
    if [ -n "$p" ] && [ -x "$p" ]; then
      srv_found="python3 ($("$p" --version 2>&1 | awk '{print $2}'))"
      break
    fi
  done
fi
if [ -n "$srv_found" ]; then
  ok "本機靜態伺服器可用 — ${srv_found}"
else
  note '找不到本機靜態伺服器 — MCP 章節需要（Playwright MCP 封鎖 file://）。建議行前執行: npx -y serve --version'
fi

printf '\n%s\n' '========================================='
printf '結果: \033[32m%d 通過\033[0m / \033[33m%d 提醒\033[0m / \033[31m%d 未通過\033[0m\n' "$pass" "$warn" "$fail"

if [ "$fail" -gt 0 ]; then
  printf '\n\033[31m有必備項目未通過，請於活動前補齊。\033[0m\n'
  exit 1
fi
printf '\n\033[32m必備項目都已就緒。\033[0m\n'
