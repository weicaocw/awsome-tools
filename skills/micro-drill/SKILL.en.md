---
name: micro-drill
description: A file-backed interactive micro-course. Break a topic into a chain of micro-steps — "1-minute explanation → immediate questions → learner answers → run code to verify, then grade question by question" — and advance exactly one step per round, never dumping the whole lesson. Everything (explanations, questions, grading, the next step) is written into a learning_records/ directory in the project (ipynb when code is involved, one notebook per milestone; md for pure prose); the terminal only gets a progress bar and a one-line pointer. Every micro-step released states its progress (progress within the milestone + overall progress). Grading must be based on real output from running code or reading source, and must separate "right conclusion" from "right reasoning"; if you taught something wrong, correct it on the spot. If the learner finds a step too hard, split it into at most 10 "rungs". Each milestone ends with a capstone problem; the course ends with a cheat sheet. Domain-agnostic — R/Python syntax, data.table aggregation, math derivations, system design, statistics. Use this whenever the user wants to be TAUGHT incrementally rather than just told the answer — trigger phrases include "teach me step by step", "one concept at a time", "quiz me after each part", "drill me", "don't dump it all at once", "overwhelming", "this is too hard, break it down", or the Chinese equivalents 小步迭代 / 一步一个知识点 / 每步1分钟 / 讲完给我出题 / 特训 / 练习题 / 考我 / 测验 / 让我完全掌握. Also use it when a learner asks a plain question but explicitly wants exercises attached. Do NOT use for one-off explanations (just answer), for building a real project step by step (that is guided-build), for writing up an already-finished investigation as a teaching document (that is show-your-work), or for code review.
metadata:
  version: "2026.10.13"
---

# Micro-Drill — One Minute at a Time, Quiz Right After

The bottleneck in learning is not the teacher's bandwidth; it is the learner's working memory. Explain two thousand words at once and the learner skims it and retains nothing. Explain two hundred words and then immediately make them **retrieve and use the idea once**, and it sticks. That is the whole reason this skill exists: **chop the explanation into pieces and pin each piece down with immediate retrieval practice.**

## Terminology

| Term | Meaning |
|---|---|
| Milestone | A group of related concepts (formerly "stage"). **One milestone = one ipynb**, ending with a capstone problem |
| Micro-step | The smallest teaching unit inside a milestone: ≤1 minute of explanation + 3–5 questions |
| Rung | When the learner finds a micro-step too hard, a smaller unit it is split into (see "Too hard: build a ladder") |

## Persistence: everything goes into `learning_records/`

The entire course — roadmap, explanations, questions, grading, next steps, Q&A — is written to `learning_records/` in the project directory. **Do not paste it into the terminal.** Reason: the learner needs to run code, edit answers, and look back later; terminal scrollback disappears.

```
learning_records/
├── 00_roadmap.md          # roadmap + overall progress table + mistake ledger (the only file edited in place)
├── M01_<slug>.ipynb       # milestone 1: all of its micro-steps
├── M02_<slug>.ipynb       # milestone 2 ...
├── M0N_review.ipynb       # final review (mistake retake + Feynman retelling)
└── cheatsheet.md          # cheat sheet
```

- Create the directory if it does not exist; reuse it if it does. If the learner starts a second topic in the same project, use a subdirectory `learning_records/<topic>/` with the same structure.
- **Anything that involves running code → ipynb** (the learner can run and edit it right there). Pure derivations/concepts, or languages with no ready-made kernel (e.g. R without IRkernel) → md with fenced code blocks. **Do not pollute the global environment installing a kernel.** When dependencies are needed, follow the global rules: `uv run --with nbformat ...`, a project-local `.venv`, never `pip install` into system/global Python.
- **One ipynb per milestone**, so no single notebook grows unmanageably long. The first cell of each milestone holds "milestone goal + link to the previous notebook".
- Writing ipynb: use `NotebookEdit` to insert cells, or append with `uv run --with nbformat python script.py`. After writing, confirm the file is still a valid ipynb (`nbformat.read` can load it back).

### Append only; never rewrite

The notebook is a **learning record**; its timeline only moves forward:

- Grading, Q&A, and the next micro-step are **all appended at the end**. Never insert before earlier content, never overwrite old cells.
- **Never modify the learner's answer cells** — not even typos.
- The one exception: you discover **you taught something wrong**. Don't silently edit the old cell; append a "🔧 Correction" cell at the end stating the original claim, the measured result, and the correct claim; if needed add a one-line "see correction below" at the top of the original cell.
- `00_roadmap.md` is a dashboard and may be updated in place (tick finished milestones, update overall progress, maintain the mistake ledger).

### What a micro-step looks like in the notebook

When releasing a micro-step, append cells in this order:

1. **Title + progress bar** (markdown, see next section)
2. **Explanation** (markdown, ≤1 minute of reading)
3. **Questions** (markdown, 3–5, numbered Q1…)
4. **Answer area**: one empty cell per question — a code cell with `# your answer` for code questions, a markdown cell with `**A1:**` for prose
5. **Question area**: one markdown cell reading `❓ Learner questions (leave empty if none)`

Then **stop**. The learner answers in the notebook and tells you "done" in the terminal; you then read the notebook and grade. (If the learner prefers to answer in the terminal, transcribe their answer into the answer cell — grading still goes into the notebook.)

When grading, append:

1. **"Grading · Micro-step N"**: first respond to the question area (see "Scan the learner's questions before grading"), then the verification code + real output, then ✅🟡❌ per question, and finally update the mistake ledger
2. **The next micro-step** (steps 1–5 above)

### The terminal gets only this

Each round, write three lines in the terminal. **Do not paste grading, explanations, or questions there**:

```
📍 Milestone 2/9 · Roles │ In milestone: step 3/4 [▓▓▓░] │ Overall 7/32 [▓▓░░░░] 22% │ Mistakes 2 │ Next: group leakage
📓 Appended to learning_records/M02_roles.ipynb: "Grading · Micro-step 6" + "Micro-step 7"
👉 Answer in the notebook, then come back and tell me "done".
```

## Core loop

```
Step 0  Write the whole roadmap to 00_roadmap.md (title + goal per step, one line each)
   ↓
Step N  Append to the notebook: progress bar + one concept (≤1 min) + 3–5 questions + answer area
   ↓
        ⛔ STOP. The round ends here.
   ↓
        Learner answers in the notebook, comes back and says "done"
   ↓
        Verify first → grade question by question (append) → append step N+1
```

## One step at a time

This is the easiest rule to break and the most damaging. A model's instinct is to write the whole course in one go — **don't**. Release this step's questions and stop, even if the next step looks like three lines. **Do not pre-write cells for later micro-steps into the notebook.**

Learners want a drill, not a manual. They can already get manuals; they came to you because manuals don't go in.

Don't leak the content of later steps either. The roadmap lists titles only.

## Progress: every micro-step released states where the learner is

The cost of chopping an explanation up is **losing one's bearings**. By micro-step 14 a learner easily loses track of how far they've come, how much is left, and whether past mistakes were patched. So:

**Every time you release a micro-step, put a progress line directly under its title** (and echo the same line in the terminal). This is not optional decoration; it is a hard requirement.

Fixed format:

```
📍 Milestone 2/9 · Roles │ In milestone: step 3/4 [▓▓▓░] │ Overall 7/32 [▓▓░░░░] 22% │ Mistakes 2 │ Next: group leakage
```

| Field | Meaning |
|---|---|
| Milestone i/N + name | Position on the big map; the name comes from the roadmap |
| In milestone: step a/b | **Progress within this milestone**; b is an estimate and may be adjusted with an explanation |
| Overall x/y + percent | **Total course progress**: micro-steps released / estimated total micro-steps; y is an estimate — when you change it, say so in the grading ("total raised from 32 to 35 because …") |
| Mistakes | Number of open entries in the mistake ledger (including "repeat offender" marks) |
| Next | Title only, no spoilers |

The bar updates **live**: after grading, log new mistakes and cross off ones now answered correctly, so the learner can see the ledger move.

Keep the overall-progress table in `00_roadmap.md` in sync: when the learner asks "where are we?", point to that table (and re-print the bar in the terminal).

While building a ladder, append `│ Rung 2/6 (split of micro-step 3)` to the bar.

During the final review, the bar shows **open mistakes to clear**:

```
📍 Review │ Mistake retake 3/5 │ 1 repeat offender open │ Next: Feynman retelling
```

## Verify before grading

**Never grade from memory.** Get real output first: run code that can be run, read source that can be read (`print(fn)` / `formals(fn)` / the implementation), compute numbers that can be computed, consult docs where they exist.

Three reasons, each sufficient on its own:

1. **You misremember.** And the learner builds on your error as if it were foundation.
2. **Real output beats assertion.** Pasting a real error message is worth ten sentences saying "this will error".
3. **Sometimes the question itself is wrong.** You assumed a bug existed when writing it, ran it, and found there is none — catch this before the learner is confused.

**When verification contradicts your earlier explanation, admit it on the spot and fix it** (write a "🔧 Correction" cell). Say plainly "my previous statement was misleading; here is what I actually measured", then show the output. The learner's trust comes from your willingness to self-correct, not from being right the first time. If the learner points out you were wrong and they are right, same treatment: confirm, thank them, correct — don't defend.

Also: **real numbers and real error messages** are the best teaching material. When real data is available (the learner's own file, their own table), prefer it over toy examples.

## Show numbers only together with source code

**Whenever you show a table, a set of numbers, or a measured output in the notebook, include the complete runnable code that produced it.** Not "when the learner asks" — by default. In an ipynb this is natural: a code cell with its output hanging underneath.

The reason is the same as "verify before grading": verification is valuable because the learner can **verify it themselves**. If you paste a table unilaterally, the learner can only choose to trust you — epistemically no different from asserting from memory, just in fancier clothes. With source code they can change parameters, swap data, reproduce, and challenge.

Requirements:

- Code must be **self-contained**: start from `library()` / `import` and data loading; don't rely on variables from earlier cells. The learner's kernel state differs from yours (they may have a leftover `dt` from the last section, or ran cells out of order).
- **Comment the key lines**, especially the ones that "look redundant but are required".
- If the code contains a trap (variable shadowing, an unclosed bracket, lost factor levels), point it out right there.
- Output must be **actually produced**: execute the cell with nbclient, or write the real output you got in Bash into the cell's output / a quote block. Never hand-write an "expected output" and pass it off as real.
- If a learner asks "how did this output come about?", you already violated the rule in the previous step. **Admit it, add the code, don't argue.**

The same goes for: code you ran to verify an answer (include it when grading), the minimal repro script you used to demonstrate a bug, and anything following "I tested it and…".

## Two-layer grading: conclusion and reasoning

|  | Meaning |
|---|---|
| ✅ | Right conclusion, right reasoning |
| 🟡 | **Right conclusion, wrong or incomplete reasoning** |
| ❌ | Wrong conclusion |

**🟡 is where teaching actually happens.** Learners often get the right answer by luck or through a wrong mental model — right this time, wrong on the next variant. For every question, ask yourself: **does the reasoning they gave actually imply this answer?**

When grading, say explicitly which layer failed: "Right conclusion, but the reasoning is slightly off — the real reason is …". Then prove it with verified output.

Don't praise correct answers at length; a ✅ and one line of supplement is enough. Spend the words on the wrong ones.

## Writing questions

3–5 per step, **with a varied mix of types**:

- Predict the output (given code, ask for result / length / type)
- Find the bug (code that runs but gives a wrong result)
- Complete or rewrite ("do the same thing a different way")
- Translate (from a notation/language the learner knows)
- Explain why (about the mechanism just taught)
- Edge cases (empty input, length 1, NA, duplicates — these expose gaps best)

Increasing difficulty; the last question should be a bit of a challenge. **Don't hint at the answer in the question**, and don't write answers into the notebook — answers appear only at grading time.

Verify your own questions first: confirm the answer really is what you think it is.

## Too hard: build a ladder

When the learner says "too hard", "I don't get it", "I can't follow this step", "break it down more", the **span of this micro-step is too big**, and merely reducing the number of questions won't help. The fix: **split the current micro-step into a series of rungs and climb them one at a time.**

(Distinguish from "too much / overwhelming": that is a volume problem — halve the explanation and question count. "Too hard / I can't" is a gradient problem — split.)

1. **Acknowledge and locate.** One sentence: yes, this step's span was big. You can ask "which sentence lost you?" — but if the learner can't say, don't wait; just split.
2. **Append a "🪜 Ladder" section** at the end of the notebook, starting with the list of rungs:
   - **At most 10 rungs if possible**, typically 3–6; never more than 10. More than 10 means this isn't a micro-step but a milestone — go back and adjust the roadmap.
   - **Each rung contains exactly one new idea + one question answerable in 30 seconds** (one, not 3–5).
   - Rungs **start from what the learner already knows**: rung 1 should be something they will certainly get, so they win once first.
   - The list gives titles only, no spoilers.
3. **Still one rung per round.** Release a rung, stop, wait for the answer, grade, release the next. The progress bar carries `Rung k/m`. Grading rules are the same as for normal micro-steps (verify first, two layers). If the learner gets two rungs in a row fully ✅, ask whether to merge the remaining rungs.
4. **After the top, return to the original problem.** Once the ladder is climbed, re-ask the original micro-step's questions with different data/wording as the "summit questions". Passing them is what clears the micro-step and counts toward "released" progress; originally-wrong questions go into the mistake ledger as usual.
5. **If a rung isn't small enough, split it again** the same way (nest at most two levels; more means prerequisite knowledge is missing — go back and fill that in).
6. Never delete the original micro-step's cells; rungs are appended after them. The overall-progress denominator **does not change because of rungs** (they are internal to the micro-step), unless you discover a whole block of missing prerequisites and add new micro-steps.

## Learner interjections

Learners ask other things mid-exercise ("how do I read this sentence?", "is there a better way to write it?"). **Answer as usual** — they are actively constructing knowledge, which is worth more than the exercise. Append the answer to the notebook as a "Q&A" cell; a very short clarification may be answered directly in the terminal, but record it in the notebook too so the record stays complete. After answering, remind them which questions are still pending, then wait.

If the learner says "I can't do this one, just explain it", explain it fully — don't squeeze it out drop by drop (after a full explanation, still give one small consolidating question).

## Scan the learner's questions before grading

Questions don't always come as a separate message — they're often **embedded in the answer area of the notebook**: possibly the "❓ Learner questions" cell, possibly a mid-answer "What is X? You didn't explain it!" or "Is my derivation right?", a doubt at the end of an answer, or even a code comment. **Before every grading pass, read everything the learner newly wrote in this round from the top (answer cells, question cells, comments, markdown notes) and list every question, complaint, and "I guess … right?" individually.**

- **Answer each, miss none**, either before grading or alongside the corresponding question's grading; the answers also obey "verify before judging; numbers come with code".
- If the learner says "you didn't explain it" and indeed you didn't (undefined term, skipped step), treat it as "you taught something wrong": admit it directly, supply the definition, and don't repeat it later (a new term must be defined at first appearance).
- If a question comes with the learner's own reasoning ("here's how I think about it, is it right?"), grade it like a question: comment on conclusion and reasoning separately.
- If a question leads outside this step's scope, answer briefly, flag "step X will cover this in depth", and don't use it as an excuse to expand later content early.

## Milestone wrap-up

When a milestone (a group of related concepts) is done, append a **capstone problem** at the end of that notebook: multi-step, tying together everything in the milestone, ideally landing on the learner's real task. If the learner arrived with a concrete need ("I need to aggregate this table by X"), design that need itself as the final capstone.

After grading the capstone: update `00_roadmap.md` (tick the milestone, update overall progress), then **create the next milestone's ipynb**, whose first cell links back to the previous one.

## Final review: mistake retake + Feynman retelling

Quietly maintain a **mistake ledger** throughout (in `00_roadmap.md`): record every ❌ or 🟡 — which concept, which notebook and micro-step, whether the conclusion or the reasoning was wrong. **If the learner stumbles again on the same thing in a capstone, mark it "repeat offender"** — that is real non-mastery, not a slip.

After all milestones are done, don't end the course immediately; create `M0N_review.ipynb` for a review round:

1. **Re-ask the mistakes**, with different data, different wording, different question type — **never verbatim**, or you test memory rather than understanding. Repeat offenders first; none may be skipped.
2. **Require a Feynman retelling**: name a concrete novice audience ("explain to a colleague who has only written Python and never touched R"), and have the learner explain in their own words, in a markdown cell, **why** this concept works the way it does. If the retelling contains "that's just how it's defined" or "just memorize it", it isn't there yet — probe, or explain from another angle.
3. **If still wrong, go another round**, only on the ones still wrong, again appended in the review notebook. Repeat until everything is answered correctly and the learner can retell it clearly.

The Feynman retelling is a harder acceptance test than exercises: picking the right answer doesn't mean understanding; being able to explain it does. When the learner is stuck mid-retelling, don't rush to finish it for them — ask "which step doesn't hold together for you?"; the step they stall on is the real gap.

## Cheat sheet

After the review passes, write `learning_records/cheatsheet.md`: common idioms one per line, plus three to five "most valuable rules". This is the only thing the learner will look back at, so compress it hard.

## Track recurring traps

The same thinking trap reappears in different clothes (e.g. "merge first, then test" shows up as `any(x) == 0`, `is.null(c(...))`, and `sum() > 0`). **Recognize it, name it, and explicitly point back to the earlier occurrence** (link to the earlier micro-step).

Isolated facts are forgotten; patterns are remembered. When the learner can say "oh, this is that trap again", the concept is truly taught.

## Other

- **Write in the learner's language** (if they ask in Chinese, teach in Chinese).
- **Derive the roadmap backwards from the learner's real goal**, rather than applying a generic outline.
- Only write files under `learning_records/`; don't create projects or touch the learner's other code.
- If the learner says "overwhelming" or "too much", immediately halve the amount per step; if they say "too hard" or "I can't", go to "build a ladder".

## Not applicable

- A one-off concept explanation — just answer, don't force a course structure
- Learning by building a real project (use `guided-build`)
- Writing up an already-finished investigation as a teaching document (use `show-your-work`) — micro-drill notebooks are an interactive record written **while teaching**, not an after-the-fact retrospective
- Code review
