# install.ps1
# Installation script for expo-design plugin on Windows
# Usage: .\install.ps1

$ErrorActionPreference = "Stop"

Write-Host "`nInstalling expo-design plugin..." -ForegroundColor Cyan

# Detect script location
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$claudeDir = "$env:USERPROFILE\.claude"

# Create target directories
$skillsDir = Join-Path $claudeDir "skills"
$commandsDir = Join-Path $claudeDir "commands"
$agentsDir = Join-Path $claudeDir "agents"

foreach ($dir in @($skillsDir, $commandsDir, $agentsDir)) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Force -Path $dir | Out-Null
        Write-Host "Created $dir" -ForegroundColor Green
    }
}

# Check Superpowers dependency
Write-Host "`nChecking dependencies..." -ForegroundColor Cyan

$superpowersDir = Join-Path $claudeDir "plugins\superpowers"
if (-not (Test-Path $superpowersDir)) {
    Write-Host "Superpowers plugin not detected at $superpowersDir" -ForegroundColor Yellow
    Write-Host "   This plugin depends on Superpowers. Install it first:" -ForegroundColor Yellow
    Write-Host "   In Claude Code, run: /plugin install superpowers@claude-plugins-official" -ForegroundColor Yellow
    $confirm = Read-Host "`nContinue anyway? (y/N)"
    if ($confirm -ne "y") {
        Write-Host "Aborted." -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "Superpowers detected" -ForegroundColor Green
}

# Copy the skill
$skillSrc = Join-Path $scriptDir "skills\expo-from-claude-design"
$skillDst = Join-Path $skillsDir "expo-from-claude-design"

if (Test-Path $skillDst) {
    Write-Host "`nSkill 'expo-from-claude-design' already exists at $skillDst" -ForegroundColor Yellow
    $overwrite = Read-Host "Overwrite? (y/N)"
    if ($overwrite -eq "y") {
        Remove-Item -Recurse -Force $skillDst
    } else {
        Write-Host "Skipping skill install." -ForegroundColor Yellow
    }
}

if (-not (Test-Path $skillDst)) {
    Copy-Item -Recurse -Path $skillSrc -Destination $skillDst
    Write-Host "Installed skill: expo-from-claude-design" -ForegroundColor Green
}

# Copy commands
$commandsSrc = Join-Path $scriptDir "commands"
Get-ChildItem -Path $commandsSrc -Filter "*.md" | ForEach-Object {
    $dst = Join-Path $commandsDir $_.Name
    Copy-Item -Force -Path $_.FullName -Destination $dst
    $name = [System.IO.Path]::GetFileNameWithoutExtension($_.Name)
    Write-Host "Installed command: /$name" -ForegroundColor Green
}

# Copy agents
$agentsSrc = Join-Path $scriptDir "agents"
Get-ChildItem -Path $agentsSrc -Filter "*.md" | ForEach-Object {
    $dst = Join-Path $agentsDir $_.Name
    Copy-Item -Force -Path $_.FullName -Destination $dst
    $name = [System.IO.Path]::GetFileNameWithoutExtension($_.Name)
    Write-Host "Installed agent: $name" -ForegroundColor Green
}

# Final report
Write-Host "`nInstallation complete!" -ForegroundColor Green
Write-Host "`nNext steps:" -ForegroundColor Cyan
Write-Host "  1. Restart Claude Code to load the new components" -ForegroundColor White
Write-Host "  2. Open an Expo project (must have CLAUDE.md, app/ directory, NativeWind)" -ForegroundColor White
Write-Host "  3. Try: /design-to-expo `"a profile screen with avatar and stats`"" -ForegroundColor White
Write-Host "`nFor full documentation, see README.md`n" -ForegroundColor Cyan
