# micro-drill（微课特训）

**版本：2026.10.13** · 简体中文 | [English](README.md)

> 一次只推进一个微步的互动微课技能，课程内容落盘为笔记本。英文说明见 [README.md](README.md)，英文技能文件见 [SKILL.en.md](SKILL.en.md)。
> An interactive micro-course skill that advances one micro-step at a time and saves the course as notebooks. Skill files: [SKILL.md](SKILL.md) (中文) · [SKILL.en.md](SKILL.en.md) (English).

一个**一次只推进一个微步**的教学型 agent 技能：≤1 分钟讲解 → 立刻出题 → 你作答 → agent 跑代码验证后再批改。绝不一次性讲完，整门课程会落盘成可反复运行、回看的笔记本。

## 它做什么

- **一轮只走一步。** 讲一个小知识点 → 出 3–5 道题 → 停下来等你。
- **一切写进项目里的 `learning_records/`**，而不是终端。涉及代码的主题**每个里程碑一个 `.ipynb`**，纯文字的用 `.md`。批改和下一步都**追加**在笔记本末尾，你的作答 cell 绝不会被改动。
- **每个微步都写明进度。** 放出的每个微步都带一行进度条：本里程碑进度、总进度、错题账、下一步。
- **先验证再批改。** agent 会先跑代码/查源码再下判断，分 ✅（结论和理由都对）、🟡（结论对但理由错）、❌ 三档，引用的每个数字都附上产生它的代码。
- **"太难了"→ 拆台阶。** 一个微步跨度太大时，拆成 ≤10 级台阶（每级一个想法 + 一道 30 秒的小题），爬完再回到原题。
- **错题账 → 结课复训 → 速查卡。** 错题换措辞重考，再做费曼复述，最后给一页速查卡。

```
📍 里程碑 2/9 · 角色系统 │ 本里程碑 微步 3/4 [▓▓▓░] │ 总进度 7/32 [▓▓░░░░] 22% │ 错题账 2 │ 下一步：group 防泄漏
```

### 生成的目录结构

```
learning_records/
├── 00_roadmap.md          # 路线图、总进度、错题账
├── M01_<slug>.ipynb       # 每个里程碑一个笔记本
├── M02_<slug>.ipynb
├── M0N_review.ipynb       # 错题重考 + 费曼复述
└── cheatsheet.md          # 速查卡
```

## 文件

| 文件 | 用途 |
|---|---|
| [`SKILL.md`](SKILL.md) | **中文**版技能（默认版，用中文授课） |
| [`SKILL.en.md`](SKILL.en.md) | 同一技能的**英文**版 |
| [`README.md`](README.md) | 本说明的英文版 / This document in English |

两个文件的 `name` 都是 `micro-drill`。无论装哪个，技能都会跟随学员使用的语言授课；区别只在于给 agent 的指令是中文还是英文。

## 安装

Claude Code 从 `~/.claude/skills/<name>/SKILL.md`（全局）或 `<项目>/.claude/skills/<name>/SKILL.md`（项目级）读取技能。

```bash
# 中文版
mkdir -p ~/.claude/skills/micro-drill
cp SKILL.md ~/.claude/skills/micro-drill/SKILL.md

# 英文版
mkdir -p ~/.claude/skills/micro-drill
cp SKILL.en.md ~/.claude/skills/micro-drill/SKILL.md
```

只需安装其中一个，目录名统一为 `micro-drill`。

## 使用

直接用自然语言提出即可，例如：

- "一步一个知识点，每步 1 分钟，讲完给我出题，带我学 data.table 聚合。"
- "特训一下梯度下降，别一次性全给我。"
- "Teach me step by step, quiz me after each part."

然后在它创建的笔记本里作答，回到终端告诉它"做完了"。觉得哪一步太难，直接说，它会把那一步拆成台阶。

## 笔记本工具

需要创建笔记本时使用 `uv run --with nbformat ...`（项目内隔离，绝不 `pip install` 到全局 Python）。

## 版本历史

| 版本 | 说明 |
|---|---|
| 2026.10.13 | 课程内容落盘到 `learning_records/`（每个里程碑一个 ipynb，只追加不改写）；每个微步都写明进度（本里程碑 + 总进度）；"太难了"时把微步拆成 ≤10 级台阶；"阶段"改称"里程碑"。 |
