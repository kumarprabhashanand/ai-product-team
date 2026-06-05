#!/bin/bash

set -e

AGENTS_DIR="$HOME/.claude/agents"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo ""
echo "══════════════════════════════════════════════════════"
echo "   Installing AI Agent Team → Claude Code"
echo "══════════════════════════════════════════════════════"
echo ""

mkdir -p "$AGENTS_DIR"

AGENTS=(
  "chief-of-staff.md"
  "task-intake.md"
  "principal-engineer.md"
  "senior-pm.md"
  "senior-uiux.md"
  "senior-fullstack.md"
  "code-reviewer.md"
  "senior-qa.md"
  "security-auditor.md"
  "growth-marketer.md"
)

installed=0
skipped=0

for agent in "${AGENTS[@]}"; do
  src="$SCRIPT_DIR/$agent"
  dst="$AGENTS_DIR/$agent"
  if [ -f "$src" ]; then
    cp "$src" "$dst"
    echo "  ✓  $agent"
    ((installed++))
  else
    echo "  ✗  $agent (not found, skipped)"
    ((skipped++))
  fi
done

echo ""
echo "══════════════════════════════════════════════════════"
echo "  Installed $installed agent(s) to: $AGENTS_DIR"
[ $skipped -gt 0 ] && echo "  Skipped $skipped (files not found)"
echo ""
echo "  Your team:"
echo ""
echo "  ⭐ chief-of-staff      Opus    — Orchestrator: start here"
echo "  🔍 task-intake         Opus    — Intake & clarification before every task"
echo "  🏗  principal-engineer  Opus    — Architecture & technical decisions"
echo "  📋 senior-pm           Sonnet  — Product strategy & PRDs"
echo "  🎨 senior-uiux         Sonnet  — UI/UX design & design system"
echo "  💻 senior-fullstack    Sonnet  — Feature implementation"
echo "  👁  code-reviewer       Sonnet  — Code review after dev, before QA"
echo "  🧪 senior-qa           Sonnet  — Testing & quality gates"
echo "  🔒 security-auditor    Sonnet  — Security review & hardening"
echo "  📈 growth-marketer     Sonnet  — GTM, SEO, copy & launch"
echo ""
echo "  ➜  Restart Claude Code to activate the agents."
echo "  ➜  Then try: @\"chief-of-staff (agent)\" [describe your goal]"
echo ""
echo "  Optional — enable parallel Agent Teams:"
echo "  export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1"
echo "══════════════════════════════════════════════════════"
echo ""
