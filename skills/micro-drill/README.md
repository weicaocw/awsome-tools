# micro-drill

**Version: 2026.10.13** · English | [简体中文](README.zh-CN.md)

> 一次只推进一个微步的互动微课技能，课程内容落盘为笔记本。中文说明见 [README.zh-CN.md](README.zh-CN.md)，中文技能文件见 [SKILL.md](SKILL.md)。
> An interactive micro-course skill that advances one micro-step at a time and saves the course as notebooks. Skill files: [SKILL.en.md](SKILL.en.md) (English) · [SKILL.md](SKILL.md) (中文).

An agent skill that teaches you **one micro-step at a time**: a ≤1-minute explanation, then immediate questions, then you answer, then the agent runs code to verify before grading. It never dumps the whole lesson, and the entire course is saved as notebooks you can re-run and review.

## What it does

- **One step per round.** Explain a tiny concept → ask 3–5 questions → stop and wait for you.
- **Everything is written to `learning_records/`** in your project — not the terminal. Code topics get one `.ipynb` **per milestone**; pure-prose topics use `.md`. Grading and the next step are **appended** to the notebook; your answer cells are never touched.
- **Progress on every micro-step.** Each released step carries a progress line: milestone progress, overall progress, open mistakes, what's next.
- **Verified grading.** The agent runs code / reads source before judging, separates ✅ (right conclusion + reasoning), 🟡 (right conclusion, wrong reasoning) and ❌, and shows the code behind every number it quotes.
- **"Too hard" → a ladder.** If a step is too big, it is split into ≤10 rungs (one idea + one 30-second question each), then you return to the original problem.
- **Mistake ledger → final review → cheat sheet.** Wrong answers are retaken later with new wording, followed by a Feynman retelling and a one-page cheat sheet.

```
📍 Milestone 2/9 · Roles │ In milestone: step 3/4 [▓▓▓░] │ Overall 7/32 [▓▓░░░░] 22% │ Mistakes 2 │ Next: group leakage
```

### Generated layout

```
learning_records/
├── 00_roadmap.md          # roadmap, overall progress, mistake ledger
├── M01_<slug>.ipynb       # one notebook per milestone
├── M02_<slug>.ipynb
├── M0N_review.ipynb       # mistake retake + Feynman retelling
└── cheatsheet.md
```

## Files

| File | Purpose |
|---|---|
| [`SKILL.md`](SKILL.md) | The skill in **Chinese** (default; teaches in Chinese) |
| [`SKILL.en.md`](SKILL.en.md) | The same skill in **English** |
| [`README.zh-CN.md`](README.zh-CN.md) | This document in Chinese / 本说明的中文版 |

Both define `name: micro-drill`. The skill adapts to the learner's language either way; the two files differ in the language of the instructions to the agent.

## Install

Claude Code reads skills from `~/.claude/skills/<name>/SKILL.md` (global) or `<project>/.claude/skills/<name>/SKILL.md` (per project).

```bash
# English version
mkdir -p ~/.claude/skills/micro-drill
cp SKILL.en.md ~/.claude/skills/micro-drill/SKILL.md

# Chinese version
mkdir -p ~/.claude/skills/micro-drill
cp SKILL.md ~/.claude/skills/micro-drill/SKILL.md
```

Install only one of them under the name `micro-drill`.

## Use

Just ask in natural language, for example:

- "Teach me data.table aggregation step by step, quiz me after each part."
- "Drill me on gradient descent, one concept at a time."
- "一步一个知识点，每步1分钟，讲完给我出题。"

Then answer inside the notebook it creates, and come back to the terminal and say "done". If a step is too hard, say so — it will split it into rungs.

## Notebook tooling

When it needs to create notebooks it uses `uv run --with nbformat ...` (project-local, never `pip install` into your global Python).

## Version history

| Version | Notes |
|---|---|
| 2026.10.13 | Course content is persisted under `learning_records/` (ipynb per milestone, append-only); progress line on every micro-step (milestone + overall); "too hard" splits a step into ≤10 rungs; "stage" renamed "milestone". |
