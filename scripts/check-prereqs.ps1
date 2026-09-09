#Requires -Version 5.1
<#
.SYNOPSIS
    Kiro Express workshop - 行前環境檢查 (Windows)
.EXAMPLE
    .\scripts\check-prereqs.ps1
#>

$ErrorActionPreference = 'Continue'
$ProgressPreference = 'SilentlyContinue'

# 讓中文在輸出被重導向時也不會變亂碼（預設會用 ANSI codepage，zh-TW 是 CP950）
try { [Console]::OutputEncoding = [System.Text.Encoding]::UTF8 } catch {}

$StarterKitUrl = 'https://github.com/ParinLL/kiro-workshop-requirement'

$script:Pass = 0
$script:Warn = 0
$script:Fail = 0

function Write-Ok   { param($m) Write-Host "  [OK]   $m"   -ForegroundColor Green;  $script:Pass++ }
function Write-Note { param($m) Write-Host "  [WARN] $m"   -ForegroundColor Yellow; $script:Warn++ }
function Write-Bad  { param($m) Write-Host "  [FAIL] $m"   -ForegroundColor Red;    $script:Fail++ }
function Write-Head { param($m) Write-Host ""; Write-Host $m -ForegroundColor White }

function Test-Endpoint {
    param([string]$Url, [int]$TimeoutSec = 10)
    try {
        $r = Invoke-WebRequest -Uri $Url -Method Head -TimeoutSec $TimeoutSec -UseBasicParsing
        return [int]$r.StatusCode
    } catch {
        if ($_.Exception.Response) { return [int]$_.Exception.Response.StatusCode }
        return 0
    }
}

Write-Host "Kiro Express workshop - 行前環境檢查" -ForegroundColor White
Write-Host "========================================="

Write-Head '系統'
$os = Get-CimInstance Win32_OperatingSystem
Write-Host ("  OS: {0} ({1})" -f $os.Caption, $os.OSArchitecture)

Write-Head '必備項目'

# --- Kiro IDE ---
$kiroPaths = @(
    "$env:LOCALAPPDATA\Programs\Kiro\Kiro.exe",
    "$env:ProgramFiles\Kiro\Kiro.exe",
    "${env:ProgramFiles(x86)}\Kiro\Kiro.exe"
)
$kiro = $kiroPaths | Where-Object { Test-Path $_ } | Select-Object -First 1
if ($kiro) {
    Write-Ok "Kiro IDE 已安裝 ($kiro)"
} else {
    Write-Bad 'Kiro IDE 未找到 — 請從 https://kiro.dev/downloads/ 安裝'
}

if (Test-Path "$env:USERPROFILE\.kiro") {
    Write-Ok '找到 ~\.kiro 設定目錄（Kiro 曾啟動過）'
} else {
    Write-Note '未找到 ~\.kiro — 請先開啟 Kiro 並以 AWS Builder ID 登入一次'
}

# --- git ---
if (Get-Command git -ErrorAction SilentlyContinue) {
    Write-Ok ("git 已安裝 ({0})" -f ((git --version) -split ' ')[2])
    $gname = git config --global user.name  2>$null
    $gmail = git config --global user.email 2>$null
    if ($gname -and $gmail) {
        Write-Ok "git 身分已設定 ($gname <$gmail>)"
    } else {
        Write-Bad 'git user.name / user.email 未設定 — 請執行 git config --global user.name "..." 與 user.email "..."'
    }
} else {
    Write-Bad 'git 未安裝 — https://git-scm.com/download/win'
}

# --- curl ---
if (Get-Command curl.exe -ErrorAction SilentlyContinue) {
    Write-Ok 'curl 已安裝'
} else {
    Write-Bad 'curl.exe 未找到（Windows 10 1803+ 內建）'
}

# --- Expand-Archive ---
if (Get-Command Expand-Archive -ErrorAction SilentlyContinue) {
    Write-Ok 'Expand-Archive 可用（解壓 starter kit 用）'
} else {
    Write-Bad 'Expand-Archive 不可用 — 需要 PowerShell 5.0 以上'
}

# --- 音訊輸出提醒 ---
Write-Note '遊戲有音效與背景音樂 — 教室環境建議自備耳機'

# --- starter kit ---
# 若腳本是從 repo 內執行，starter-kit\ 應該就在旁邊；否則檢查能否連上 GitHub
$skDir = Join-Path (Split-Path -Parent $PSScriptRoot) 'starter-kit'
if ((Test-Path (Join-Path $skDir 'assets\ghosty.png')) -and (Test-Path (Join-Path $skDir 'img\example-ui.png'))) {
    $n = (Get-ChildItem (Join-Path $skDir 'assets') -File | Where-Object { $_.Name -ne 'README.md' }).Count
    Write-Ok "Starter kit 已在本機 ($skDir, assets 共 $n 個素材檔)"
} else {
    $code = Test-Endpoint -Url $StarterKitUrl -TimeoutSec 20
    if ($code -eq 200) {
        Write-Note "本機未找到 starter-kit\, 但 GitHub 可連線 (HTTP $code) — 建議行前 git clone 下來"
    } else {
        Write-Bad "本機無 starter-kit\ 且無法連線 GitHub (HTTP $code) — 檢查網路或防火牆"
    }
}

Write-Head 'Kiro 網路端點'
$hosts = @(
    'app.kiro.dev',
    'assets.app.kiro.dev',
    'prod.us-east-1.auth.desktop.kiro.dev',
    'runtime.us-east-1.kiro.dev',
    'q.us-east-1.amazonaws.com'
)
foreach ($h in $hosts) {
    $c = Test-Endpoint -Url "https://$h"
    if ($c -eq 0) {
        Write-Bad "$h 無法連線（防火牆 / DNS 可能阻擋）"
    } else {
        Write-Ok "$h 可連線 (HTTP $c)"
    }
}

Write-Head '選配項目 (Going further)'

# --- Node.js ---
if (Get-Command node -ErrorAction SilentlyContinue) {
    $nv = (node --version).TrimStart('v')
    $major = [int]($nv -split '\.')[0]
    if ($major -ge 20) {
        Write-Ok "Node.js v$nv (MCP 章節可用)"
    } else {
        Write-Note "Node.js v$nv 版本偏舊，建議升級到 20 LTS 以上"
    }
} else {
    Write-Note 'Node.js 未安裝 — Playwright / Context7 MCP 章節需要（https://nodejs.org/）'
}

# --- Google Chrome (Playwright MCP 預設使用系統 Chrome) ---
$chromePaths = @(
    "$env:ProgramFiles\Google\Chrome\Application\chrome.exe",
    "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe",
    "$env:LOCALAPPDATA\Google\Chrome\Application\chrome.exe"
)
$chrome = $chromePaths | Where-Object { Test-Path $_ } | Select-Object -First 1
if ($chrome) {
    Write-Ok "Google Chrome 已安裝 ($chrome) — Playwright MCP 可直接使用"
} else {
    Write-Note 'Google Chrome 未找到 — Playwright MCP 預設走系統 Chrome，缺少時首次呼叫會失敗並要求 npx playwright install chrome'
}

# --- Playwright MCP 套件快取是否已暖機 ---
$npxCache = "$env:APPDATA\npm-cache\_npx"
if (Test-Path $npxCache) {
    $cached = Get-ChildItem $npxCache -Recurse -Depth 3 -Directory -ErrorAction SilentlyContinue |
              Where-Object { $_.Name -like '*playwright*' } | Select-Object -First 1
    if ($cached) {
        Write-Ok 'Playwright MCP 套件已在 npx 快取中（現場不需重新下載）'
    } else {
        Write-Note 'Playwright MCP 尚未快取（首次啟動需下載約 57 MB）— 建議行前執行: npx -y @playwright/mcp@latest --version'
    }
} else {
    Write-Note 'Playwright MCP 尚未快取（首次啟動需下載約 57 MB）— 建議行前執行: npx -y @playwright/mcp@latest --version'
}

# --- 本機靜態伺服器（MCP 章節需要，因 Playwright MCP 封鎖 file://）---
# 注意：Windows 的 python3.exe 常常是 0 byte 的 App Execution Alias stub
# （C:\Users\<user>\AppData\Local\Microsoft\WindowsApps\python3.exe）。
# Get-Command 會成功，但實際執行回 exit code 9009 且無輸出。
# 因此必須真的執行一次並驗證輸出，不能只看 Get-Command。
function Get-RealPython {
    foreach ($name in 'python3', 'python') {
        $cmd = Get-Command $name -ErrorAction SilentlyContinue
        if (-not $cmd) { continue }
        # 0 byte 的可執行檔一定是 App Execution Alias stub
        if ($cmd.Source -and (Test-Path $cmd.Source) -and (Get-Item $cmd.Source).Length -eq 0) { continue }
        $ver = & $name --version 2>&1
        if ($LASTEXITCODE -eq 0 -and "$ver" -match '(\d+\.\d+\.\d+)') {
            return "$name ($($Matches[1]))"
        }
    }
    return $null
}

$srv = $null
if ((Test-Path $npxCache) -and (Get-ChildItem $npxCache -Recurse -Depth 4 -Directory -ErrorAction SilentlyContinue |
      Where-Object { $_.Name -eq 'serve' } | Select-Object -First 1)) {
    $srv = 'npx serve（已快取）'
} else {
    $srv = Get-RealPython
}
if ($srv) {
    Write-Ok "本機靜態伺服器可用 — $srv"
} else {
    Write-Note '找不到本機靜態伺服器 — MCP 章節需要（Playwright MCP 封鎖 file://）。Windows 不內建 Python，建議行前執行: npx -y serve --version'
}

Write-Host ""
Write-Host "========================================="
Write-Host ("結果: {0} 通過 / {1} 提醒 / {2} 未通過" -f $script:Pass, $script:Warn, $script:Fail)

if ($script:Fail -gt 0) {
    Write-Host ""
    Write-Host '有必備項目未通過，請於活動前補齊。' -ForegroundColor Red
    exit 1
}
Write-Host ""
Write-Host '必備項目都已就緒。' -ForegroundColor Green
