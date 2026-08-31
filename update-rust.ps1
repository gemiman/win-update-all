# ================================
# Rust / Cargo 全量更新脚本
# ================================

$ErrorActionPreference = "Stop"

Write-Host "`n🦀 开始更新 Rust 工具链..." -ForegroundColor Cyan

# 1. 更新 rustup 自身
Write-Host "`n[1/5] 更新 rustup..." -ForegroundColor Yellow
rustup self update
if ($LASTEXITCODE -ne 0) {
    Write-Warning "rustup self update 失败，请检查网络或权限"
}

# 2. 更新所有已安装 toolchain
Write-Host "`n[2/5] 更新 toolchain（stable / beta / nightly）..." -ForegroundColor Yellow
rustup update
if ($LASTEXITCODE -ne 0) {
    Write-Warning "rustup update 失败"
}

# 3. 更新 rustup 组件（clippy / rustfmt / rust-src 等）
Write-Host "`n[3/5] 更新 rustup 组件..." -ForegroundColor Yellow
rustup component list --installed | ForEach-Object {
    $component = ($_ -split " ")[0]
    Write-Host "  └─ 更新组件: $component"
    rustup component add $component
}

# 4. 更新所有 cargo 安装的二进制工具
Write-Host "`n[4/5] 更新 cargo 安装的组件..." -ForegroundColor Yellow
# $cargoPackages = cargo install --list | Where-Object { $_ -match '^(\S+) v' } | ForEach-Object { $matches[1] }

# if (-not $cargoPackages) {
#     Write-Host "  └─ 未检测到 cargo 安装的组件，跳过"
# }
# else {
#     foreach ($pkg in $cargoPackages) {
#         Write-Host "  └─ 更新: $pkg"
#         cargo install $pkg --force
#     }
# }

cargo install-update -a

Write-Host "`n[5/5] 清理 cargo 缓存..." -ForegroundColor Red
cargo cache --autoclean

Write-Host "`n[6/6] ✅ Rust / Cargo 更新完成！`n" -ForegroundColor Green

rustc --version
cargo --version

topgrade

# 不要用--silent，手动升级这两个包
winget upgrade Microsoft.Outlook
winget upgrade Microsoft.WindowsAppRuntime.1.5
