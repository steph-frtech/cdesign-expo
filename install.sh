#!/usr/bin/env bash
# install.sh
# Installation script for expo-design plugin on macOS/Linux/WSL2
# Usage: bash install.sh

set -e

echo ""
echo "Installing expo-design plugin..."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
SKILLS_DIR="$CLAUDE_DIR/skills"
COMMANDS_DIR="$CLAUDE_DIR/commands"
AGENTS_DIR="$CLAUDE_DIR/agents"

# Create directories
mkdir -p "$SKILLS_DIR" "$COMMANDS_DIR" "$AGENTS_DIR"

# Check Superpowers
echo ""
echo "Checking dependencies..."
if [ ! -d "$CLAUDE_DIR/plugins/superpowers" ]; then
  echo "Superpowers plugin not detected"
  echo "   Install it first via Claude Code: /plugin install superpowers@claude-plugins-official"
  read -p "Continue anyway? (y/N) " -n 1 -r
  echo ""
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 1
  fi
else
  echo "Superpowers detected"
fi

# Install skill
SKILL_DST="$SKILLS_DIR/expo-from-claude-design"
if [ -d "$SKILL_DST" ]; then
  echo ""
  echo "Skill already exists at $SKILL_DST"
  read -p "Overwrite? (y/N) " -n 1 -r
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -rf "$SKILL_DST"
  fi
fi

if [ ! -d "$SKILL_DST" ]; then
  cp -R "$SCRIPT_DIR/skills/expo-from-claude-design" "$SKILL_DST"
  echo "Installed skill: expo-from-claude-design"
fi

# Install commands
for cmd in "$SCRIPT_DIR/commands/"*.md; do
  if [ -f "$cmd" ]; then
    cp -f "$cmd" "$COMMANDS_DIR/"
    name=$(basename "$cmd" .md)
    echo "Installed command: /$name"
  fi
done

# Install agents
for agent in "$SCRIPT_DIR/agents/"*.md; do
  if [ -f "$agent" ]; then
    cp -f "$agent" "$AGENTS_DIR/"
    name=$(basename "$agent" .md)
    echo "Installed agent: $name"
  fi
done

echo ""
echo "Installation complete!"
echo ""
echo "Next steps:"
echo "  1. Restart Claude Code"
echo "  2. Open an Expo project (with CLAUDE.md, app/, NativeWind)"
echo "  3. Try: /design-to-expo \"a profile screen with avatar and stats\""
echo ""
