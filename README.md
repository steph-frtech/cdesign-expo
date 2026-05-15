# expo-design plugin

**Claude Code plugin** that converts Claude Design handoffs (or any HTML/image/Figma mockup) into production-ready Expo React Native code, orchestrated through the Superpowers methodology.

## What it does

This plugin gives Claude Code three new slash commands:

- **`/design-to-expo`** — Full workflow: brainstorm → spec → plan → implement → review
- **`/expo-screen`** — Fast path: skip brainstorm, generate a single screen
- **`/expo-component`** — Generate a single reusable component

It also bundles:

- **1 skill**: `expo-from-claude-design` (auto-triggers on design input in Expo projects)
- **2 agents**: `expo-converter` (generates code) + `expo-reviewer` (audits it)

## Requirements

- **Claude Code** (>= 1.10)
- **Superpowers plugin** (required dependency)
- An **Expo project** with NativeWind configured

## Installation

### Windows (PowerShell)

```powershell
cd path\to\expo-design-plugin
.\install.ps1
```

### macOS/Linux/WSL

```bash
cd path/to/expo-design-plugin
bash install.sh
```

## Usage

### Full workflow

```
/design-to-expo cd_abc123xyz
```

### Faster (skip brainstorm)

```
/expo-screen [paste-screenshot] profile
```

### Single component

```
/expo-component "primary button with icon" Button
```

## Project setup (one-time)

Add to your Expo project's `CLAUDE.md`:

```markdown
## Stack
- Expo SDK 55+
- React Native 0.82+
- React 19
- TypeScript strict
- Expo Router
- NativeWind

## Always
- pnpm typecheck && pnpm test before claiming done
- accessibility labels on all Pressable
- testID on interactive elements
- expo-image instead of Image
```

## License

MIT
