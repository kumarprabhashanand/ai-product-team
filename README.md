# AI Agent Team — Claude Code SaaS Squad

10 specialized Claude Code sub-agents forming a complete, self-coordinating SaaS team. One install. Works in every project.

---

## The Team

| Agent | Model | Color | Role |
|---|---|---|---|
| `chief-of-staff` ⭐ | Opus | Orange | **Orchestrator** — your proxy. Discovers the team dynamically, routes everything |
| `task-intake` | Opus | Cyan | **Intake & Clarification** — interrogates every task before work starts |
| `principal-engineer` | Opus | Purple | Architecture, technical decisions, system design |
| `senior-pm` | Sonnet | Yellow | PRDs, product strategy, requirements, roadmap |
| `senior-uiux` | Sonnet | Pink | UI/UX design, design system, user psychology |
| `senior-fullstack` | Sonnet | Blue | Feature implementation, code, integrations |
| `code-reviewer` | Sonnet | Red | Adversarial code review — after dev, before QA |
| `senior-qa` | Sonnet | Green | Tests, quality gates, bug discovery, release sign-off |
| `security-auditor` | Sonnet | Red | Security review, pre-launch hardening, vulnerability finding |
| `growth-marketer` | Sonnet | Orange | GTM strategy, SEO, copywriting, launch, conversion |

---

## Install

```bash
chmod +x claude-agents/install.sh
./claude-agents/install.sh
```

Restart Claude Code, then run `/agents` to confirm they loaded.

---

## How to Use

### The normal way — just brief the Chief of Staff
```
@"chief-of-staff (agent)" build the user authentication feature
@"chief-of-staff (agent)" we need a pricing page — design and implement it
@"chief-of-staff (agent)" do a full pre-release security and quality check
@"chief-of-staff (agent)" the login is broken on mobile, fix it
@"chief-of-staff (agent)" here's my SaaS idea: [describe it] — let's start
```

The Chief of Staff:
1. **Scans `~/.claude/agents/` at startup** to discover all available agents dynamically — no manual updates needed when you add new agents
2. **Routes to `task-intake` first** to review the request, check the codebase, consult the PM, and ask you clarifying questions
3. **Sequences the right specialists** in the right order with proper handoffs
4. **Validates each output** before passing it to the next stage
5. **Reports back** with what was done, what decisions were made, and what you should watch for

### Direct invocation (when you know what you need)
```
@"task-intake (agent)" review this feature request before we start
@"security-auditor (agent)" full security review before launch
@"growth-marketer (agent)" write the landing page copy for the billing feature
@"code-reviewer (agent)" review the last commit
```

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

## How Self-Discovery Works

The Chief of Staff runs this on startup:
```bash
ls ~/.claude/agents/*.md
ls .claude/agents/*.md
```
It reads the `name:` and `description:` from each file's frontmatter to build its team roster. **Add a new agent file → the CoS knows about it next session. No configuration needed.**

---

## Standard Flows

| You say | What the CoS does |
|---|---|
| "Build feature X" | Intake → PM → Arch → Design → Dev → Code Review → QA |
| "Fix this bug" | Intake → QA diagnose → Dev fix → Code Review → QA verify |
| "Pre-launch check" | Security Audit → QA regression → Dev fixes → Growth readiness → Go/no-go |
| "Write the landing page" | Intake → PM brief → Growth copy → Design → Dev implement |
| "Start a new project" | Intake → PM vision → Arch → Design system → Growth positioning → Dev scaffold |

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
├── chief-of-staff.md       ⭐ start here — orchestrates everything
├── task-intake.md          🔍 reviews every task, asks clarifying questions
├── principal-engineer.md   🏗  architecture & technical decisions
├── senior-pm.md            📋 product strategy & PRDs
├── senior-uiux.md          🎨 UI/UX design & design system
├── senior-fullstack.md     💻 feature implementation
├── code-reviewer.md        👁  code review (after dev, before QA)
├── senior-qa.md            🧪 testing & quality gates
├── security-auditor.md     🔒 security review & hardening
└── growth-marketer.md      📈 GTM, SEO, copy & launch
```
