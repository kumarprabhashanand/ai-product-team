# AI Agent Team — Claude Code SaaS Squad

11 specialized Claude Code sub-agents forming a complete, self-coordinating SaaS team. One install. Works in every project.

---

## The Team

| Agent | Model | Color | Role |
|---|---|---|---|
| `chief-of-staff` ⭐ | Opus | Orange | **Orchestrator** — your proxy. Discovers the team, routes everything, enforces quality gates, maintains project spine, runs retrospectives |
| `task-intake` | Opus | Cyan | **Intake & Clarification** — interrogates every task before work starts |
| `principal-engineer` | Opus | Purple | Architecture, technical decisions, system design |
| `senior-pm` | Sonnet | Yellow | PRDs, product strategy, requirements, roadmap |
| `senior-uiux` | Sonnet | Pink | UI/UX design, design system, user psychology |
| `senior-fullstack` | Sonnet | Blue | Feature implementation, code, integrations |
| `code-reviewer` | Opus | Red | Adversarial code review — after dev, before QA |
| `senior-qa` | Sonnet | Green | Tests, quality gates, bug discovery, release sign-off |
| `security-auditor` | Opus | Red | Security review, pre-launch hardening, vulnerability finding |
| `devops-engineer` | Sonnet | Teal | CI/CD, deployment, environments, backups, monitoring, incidents, runbook |
| `growth-marketer` | Sonnet | Orange | GTM strategy, SEO, copywriting, launch, conversion |

---

## Install

```bash
chmod +x claude-agents/install.sh
./claude-agents/install.sh
```

Restart Claude Code, then run `/agents` to confirm they loaded.

---

## Agent Nesting Limitation & Architecture

**Important:** Claude Code only supports one level of agent nesting. The chief-of-staff is designed to be your **top-level session agent**, not to be invoked as a sub-agent from within a session.

### The Problem
If you try to use the chief-of-staff as a sub-agent within an existing session:
```
Top-level Claude Code session
  → @chief-of-staff (invoked as sub-agent)
    → tries to spawn @task-intake ← FAILS (2 levels of nesting)
```

The Agent tool becomes unavailable inside a sub-agent context, so the chief-of-staff can't orchestrate its specialists.

### The Solution: Two Valid Approaches

**Approach 1 — Start a new session as chief-of-staff (recommended)**
```bash
claude --agent chief-of-staff
```
Or in Claude Code desktop/web:
1. Click the agent picker dropdown
2. Select `chief-of-staff`
3. Start a new session

The chief-of-staff runs at the top level and freely spawns specialists. Full autonomous orchestration.

**Approach 2 — Stay in your current session, Claude Code will orchestrate directly**

Tell Claude Code your task, and It'll invoke specialists directly from the top level:
```
Top-level Claude Code ← you are here
  → @task-intake
  → @senior-pm
  → @senior-fullstack
  → @code-reviewer
  → @senior-qa
```

You get the same result (specialists run in sequence with proper handoffs), just one fewer layer of indirection.

---

## How to Use

### Method 1: Start a session as chief-of-staff (full autonomy)

If you start your session as `chief-of-staff`, you get autonomous orchestration:
```
@"chief-of-staff (agent)" build the user authentication feature
@"chief-of-staff (agent)" we need a pricing page — design and implement it  
@"chief-of-staff (agent)" do a full pre-release security and quality check
@"chief-of-staff (agent)" the login is broken on mobile, fix it
@"chief-of-staff (agent)" here's my SaaS idea: [describe it] — let's start
```

The Chief of Staff:
1. **Scans `~/.claude/agents/` at startup** to discover all available agents dynamically
2. **Reads the project spine** (`CLAUDE.md`, `docs/DECISIONS.md`, `docs/STATE.md`, `docs/RUNBOOK.md`) to load context
3. **Routes to `task-intake` first** to review the request, check the codebase, consult the PM, and ask clarifying questions
4. **Sequences the right specialists** in the right order with proper handoffs
5. **Validates each output with evidence** (gate outputs, file paths, test counts) — claims without evidence are rejected
6. **Enforces quality gates** — never advances work past a red gate; runs a findings registry for Critical/High issues
7. **Keeps the project spine updated** after every workflow — STATE.md, DECISIONS.md, RUNBOOK.md
8. **Runs retrospectives** so lessons feed back into the team's process

### Method 2: Direct specialist invocation (stay in current session)

If you're already in a session, invoke specialists directly:
```
@"task-intake (agent)" review this feature request before we start
@"senior-pm (agent)" create the PRD for the billing feature
@"senior-fullstack (agent)" implement the user authentication
@"code-reviewer (agent)" review the last commit
@"security-auditor (agent)" full security review before launch
@"devops-engineer (agent)" set up CI/CD and deployment for this project
@"growth-marketer (agent)" write the landing page copy
```

Each agent runs at the top level and has full access to the Agent tool, so there's no nesting limitation. I (the top-level Claude) sequence them based on your request.

---

## What the Task Intake Agent Does

Every new task goes through `task-intake` first. It:
- Reads the current codebase and project context
- Checks existing PRDs and recent git history
- Consults the `senior-pm` internally
- Identifies what's ambiguous, conflicting, or missing
- Asks you up to 5 focused clarifying questions before anyone starts building

This is the agent that answers your question: *"who reviews the task, discusses it with the PM, and asks me clarifying questions?"*

---

## The Project Spine

The chief-of-staff maintains four on-disk files that act as the team's shared memory across sessions. Specialists read and update these so context is never re-derived from scratch.

| File | Owner | Purpose |
|---|---|---|
| `CLAUDE.md` | chief-of-staff | Stack, conventions, how to run/test/deploy |
| `docs/DECISIONS.md` | chief-of-staff | Append-only decision log — every significant decision, dated with rationale. Decisions are law until reversed. |
| `docs/STATE.md` | chief-of-staff | Feature board, findings registry, gate command list, go-live blockers |
| `docs/RUNBOOK.md` | devops-engineer | Operations — deploy commands, rollback, monitoring, incident response |

On a new project the chief-of-staff scaffolds all four files before any other work begins. Every workflow ends with the spine updated — a workflow missing spine updates is not finished.

---

## How Self-Discovery Works

This feature applies when running chief-of-staff at the top level (Method 1). The Chief of Staff scans for agents at startup:

```bash
ls ~/.claude/agents/*.md
ls .claude/agents/*.md
```

It reads the `name:` and `description:` from each file's frontmatter to build its team roster. **Add a new agent file → the CoS knows about it next session. No configuration needed.**

When using Method 2 (direct specialist invocation), agents are available for you to call directly without needing self-discovery.

---

## Standard Flows

### When using chief-of-staff at the top level (Method 1)

| You say | What the CoS does |
|---|---|
| "Build feature X" | Intake → PM → Arch → Design → Dev → Code Review → QA |
| "Fix this bug" | Intake → QA diagnose → Dev fix → Code Review → QA verify |
| "Pre-launch check" | Security Audit → DevOps readiness → QA regression → Dev fixes → Growth readiness → Go/no-go |
| "Write the landing page" | Intake → PM brief → Growth copy → Design → Dev implement |
| "Start a new project" | Intake → PM vision → Arch → DevOps scaffold → Design system → Growth positioning → Dev scaffold |
| "Deploy this / set up CI" | DevOps → Arch (if new infra) → Security → Runbook written |

### When invoking specialists directly (Method 2)

Same sequences apply — just tell me your task in the current session and I'll invoke the agents directly in the correct order. No chief-of-staff layer needed.

---

## Enable Parallel Execution (Optional)

```bash
export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1
# or add to .claude/settings.json:
# { "env": { "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1" } }
```

Agents run sequentially by default. With Agent Teams enabled, independent tasks run in parallel.

---

## Files

```
claude-agents/
├── install.sh
├── chief-of-staff.md       ⭐ start here — orchestrates everything, maintains project spine
├── task-intake.md          🔍 reviews every task, asks clarifying questions
├── principal-engineer.md   🏗  architecture & technical decisions
├── senior-pm.md            📋 product strategy & PRDs
├── senior-uiux.md          🎨 UI/UX design & design system
├── senior-fullstack.md     💻 feature implementation
├── code-reviewer.md        👁  code review (after dev, before QA)
├── senior-qa.md            🧪 testing & quality gates
├── security-auditor.md     🔒 security review & hardening
├── devops-engineer.md      🚀 CI/CD, deployment, environments, runbook
└── growth-marketer.md      📈 GTM, SEO, copy & launch
```
