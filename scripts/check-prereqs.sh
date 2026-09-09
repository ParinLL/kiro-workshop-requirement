#!/usr/bin/env bash
# Kiro Express workshop - 行前環境檢查 (macOS / Linux)
# 用法: bash scripts/check-prereqs.sh

set -uo pipefail

STARTER_KIT_URL='https://static.us-east-1.prod.workshops.aws/public/27a20e39-291b-4a68-8f58-89575b985e47/assets/kiro-introduction-starter-kit.zip'

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

# --- unzip ---
if command -v unzip >/dev/null 2>&1; then
  ok 'unzip 已安裝'
else
  bad 'unzip 未安裝'
fi

# --- starter kit 連線 ---
if command -v curl >/dev/null 2>&1; then
  code="$(curl -s -o /dev/null -m 20 -w '%{http_code}' -r 0-0 "$STARTER_KIT_URL" || echo 000)"
  if [ "$code" = "200" ] || [ "$code" = "206" ]; then
    ok "Starter kit 下載網址可連線 (HTTP $code)"
  else
    bad "無法連線 starter kit (HTTP $code) — 檢查網路或防火牆"
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

head1 '選配項目 (Going further / Deploy)'

# --- Node.js ---
if command -v node >/dev/null 2>&1; then
  nv="$(node --version | tr -d 'v')"
  major="${nv%%.*}"
  if [ "$major" -ge 20 ] 2>/dev/null; then
    ok "Node.js v$nv (MCP 章節可用)"
  else
    note "Node.js v$nv 版本偏舊，建議升級到 20 LTS 以上"
  fi
else
  note 'Node.js 未安裝 — MCP 章節需要（https://nodejs.org/）'
fi

# --- Kiro CLI ---
if command -v kiro-cli >/dev/null 2>&1; then
  ok 'kiro-cli 已安裝'
  if kiro-cli whoami >/dev/null 2>&1; then
    ok 'kiro-cli 已登入'
  else
    note 'kiro-cli 未登入 — 執行 kiro-cli login'
  fi
else
  note 'kiro-cli 未安裝 — curl -fsSL https://cli.kiro.dev/install | bash'
fi

# --- AWS CLI ---
if command -v aws >/dev/null 2>&1; then
  ok "AWS CLI 已安裝 ($(aws --version 2>&1 | awk '{print $1}'))"
else
  note 'AWS CLI 未安裝 — 只有自行做 Deploy 章節才需要'
fi

printf '\n%s\n' '========================================='
printf '結果: \033[32m%d 通過\033[0m / \033[33m%d 提醒\033[0m / \033[31m%d 未通過\033[0m\n' "$pass" "$warn" "$fail"

if [ "$fail" -gt 0 ]; then
  printf '\n\033[31m有必備項目未通過，請於活動前補齊。\033[0m\n'
  exit 1
fi
printf '\n\033[32m必備項目都已就緒。\033[0m\n'
