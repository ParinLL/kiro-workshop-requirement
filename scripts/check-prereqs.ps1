#Requires -Version 5.1
<#
.SYNOPSIS
    Kiro Express workshop - 行前環境檢查 (Windows)
.EXAMPLE
    .\scripts\check-prereqs.ps1
#>

$ErrorActionPreference = 'Continue'
$ProgressPreference = 'SilentlyContinue'

$StarterKitUrl = 'https://static.us-east-1.prod.workshops.aws/public/27a20e39-291b-4a68-8f58-89575b985e47/assets/kiro-introduction-starter-kit.zip'

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

# --- starter kit ---
$code = Test-Endpoint -Url $StarterKitUrl -TimeoutSec 20
if ($code -eq 200) {
    Write-Ok "Starter kit 下載網址可連線 (HTTP $code)"
} else {
    Write-Bad "無法連線 starter kit (HTTP $code) — 檢查網路或防火牆"
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

Write-Head '選配項目 (Going further / Deploy)'

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
    Write-Note 'Node.js 未安裝 — MCP 章節需要（https://nodejs.org/）'
}

# --- Kiro CLI ---
if (Get-Command kiro-cli -ErrorAction SilentlyContinue) {
    Write-Ok 'kiro-cli 已安裝'
    kiro-cli whoami *>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Ok 'kiro-cli 已登入'
    } else {
        Write-Note 'kiro-cli 未登入 — 執行 kiro-cli login'
    }
} else {
    Write-Note 'kiro-cli 未安裝 — 見 https://kiro.dev/downloads/'
}

# --- AWS CLI ---
if (Get-Command aws -ErrorAction SilentlyContinue) {
    Write-Ok ("AWS CLI 已安裝 ({0})" -f ((aws --version 2>&1) -split ' ')[0])
} else {
    Write-Note 'AWS CLI 未安裝 — 只有自行做 Deploy 章節才需要'
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
