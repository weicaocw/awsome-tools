这是一套基于第一性原理（First Principles）的四步连续提示词（Prompts）。以下为你整理出的完整英文原文及中文对照排版：

---

### Step 1 · 核心问题拆解（Decomposition）

#### 英文原文

> “Act as a world-class first principles analyst. Your job in this step is decomposition only. You're penalized for introducing advice, solutions, assumptions, or standard playbooks. Be my thought partner. Do not suck up to me.
> I want to understand exactly what this problem is made of. My problem is: **[INSERT PROBLEM]**. If the stated problem appears to contain a hidden objective or a deeper question, identify it in one sentence before decomposing. Ask whether I want you to decompose the original problem or the deeper one. Do not continue until I choose. Do not replace or reframe my problem.
> Break the problem into its smallest useful constituent parts. Show the hierarchy clearly: the overall problem, its major components, and the smaller elements inside each component. Use only dimensions that are relevant, such as people, process steps, time, resources, costs, etc. For each component, briefly explain what it contains and how it connects to the larger problem. Stop decomposing when breaking a component down further would no longer improve understanding or make it easier to examine.
> Do not evaluate the components. Do not classify them as facts or assumptions. Do not recommend solutions. Only show me what parts the problem is made of.”

#### 中文排版参考

> “扮演一位世界顶尖的第一性原理分析专家。你在这一步的**唯一工作就是拆解**。如果你提出建议、解决方案、假设或套用既定套路，将会受到扣分惩罚。做我的思考伙伴，不要奉承我。
> 我想弄清楚这个问题究竟由什么构成。我的问题是：**[在此输入问题]**。如果陈述的问题背后似乎包含隐藏目标或更深层的问题，请在开始拆解前用一句话指出来，并询问我是希望拆解原问题还是深层问题。在我做出选择前不要继续，切勿直接替换或重构我的问题。
> 将问题拆解为最小且有用的组成部分。清晰展示层级结构：总体问题、主要组成部分，以及每个部分内部的更小要素。仅使用相关的维度（例如：人员、流程步骤、时间、资源、成本等）。简要说明每个组件包含的内容及其与总体问题的关联。当进一步拆解不再有助于加深理解或便于审视时，即停止拆解。
> 不要评估这些组件。不要将它们归类为事实或假设。不要推荐解决方案。只向我展示这个问题的构成要素。”

---

### Step 2 · 假设审计与红队审查（Red Team Audit）

#### 英文原文

> “Act as a skeptical red team analyst whose only job is to uncover and question inherited assumptions. Assume that every “obvious” part of the problem may be hiding a convention until evidence proves otherwise.
> I want to know which of the building blocks above are load-bearing assumptions, not facts — and what becomes possible if they're wrong.
> Review the blocks from the previous step. Give me a numbered list of the assumptions hiding in them. For each one, on its own lines:
> * Name the assumption.
> * Classify whether it's fact, convention, or unknown based on the evidence available.
> * Verify the evidence.
> * State what breaks, or what opens up, if I eliminate it; and state what changes if I invert it.
> 
> 
> Order the list from most load-bearing assumption to least.”

#### 中文排版参考

> “扮演一位持怀疑态度的红队分析专家，你的唯一任务是揭露并质疑那些固有的既定假设。假设问题的每一个‘显而易见’的部分背后都潜藏着某种常规惯例，直到证据能够证明相反的事实。
> 我想知道上述构建模块中，哪些是**承重型假设（而非事实）**——以及一旦它们是错误的，会带来什么新的可能性。
> 审查上一步得出的模块，给我一份潜藏假设的编号清单。针对每一个假设，分行明确：
> * 命名该假设；
> * 根据现有证据，将其归类为‘事实’、‘常规惯例’或‘未知’；
> * 验证现有证据；
> * 说明如果消除它，什么会瓦解、什么可能性会被打开；并说明如果反转它，会发生什么变化。
> 
> 
> 按照**承重程度从大到小**对清单进行排序。”

---

### Step 3 · 架构重组与创新设计（Reconstruction）

#### 英文原文

> “Act as an architect designing with no memory of how this problem has been solved before. The standard playbook is unavailable to you. Your only materials are the verified building blocks that survived the audit.
> I want new solutions assembled from those building blocks — not fresh ideas pulled from how it's normally done, and not variations on the standard answer.
> Take the building blocks that survived the audit. Recombine them — rearrange, connect, and stack these same elements into new configurations, the way the same musical notes can be arranged into different songs.
> Produce 3 solutions that each use only these verified blocks and differ from each other in their underlying structure, not just their details. For each solution:
> * Name which building blocks it's built from;
> * Which discarded convention it refuses to obey;
> * Its single biggest point of failure.
> 
> 
> Do not introduce any new building block unless you label it clearly as a new assumption.”

#### 中文排版参考

> “扮演一位‘对以往解法毫无记忆’的架构设计师。你无法调用现成的标准套路，你唯一的材料就是**在审查中幸存下来的、经过验证的基础模块**。
> 我需要用这些模块拼装出全新的解决方案——不是借鉴常规做法带来的新点子，也不是标准答案的变体。
> 取用通过审查的模块进行重组——重新排列、连接并叠加这些相同的要素，形成全新的结构，就像将相同的音符编排成不同的乐曲一样。
> 输出 3 个解决方案，要求：
> 1. 均仅使用这些经过验证的模块；
> 2. 彼此之间存在底层结构层面的差异，而非仅仅是细节不同。
> 
> 
> 针对每个方案明确：
> * 它由哪些构建模块搭建而成；
> * 它拒绝遵守哪条被废弃的常规惯例；
> * 其最大的单一故障失效点是什么。
> 
> 
> 除非将其明确标记为‘新假设’，否则不得引入任何新的构建模块。”

---

### Step 4 · 科学验证与最小实验（Testing）

#### 英文原文

> “Act as a skeptical scientist. Your job is to help me design the cheapest, fastest way to find out whether this holds up BEFORE it costs me anything real in time, money, effort, or reputation. Don't try to sell me the idea. Give me a test I could actually run, and the pass/fail lines to read it by.
> I want the smallest real world test that helps me understand what parts work and what parts don't, as early and as cheaply as possible.
> Take the 3 solutions from the previous step and design experiments to test whether they'll work in the real world. Design the smallest concrete test for each. For instance, what to actually do, who to talk to or what to build, using the least time, money, effort, or social risk the problem allows.
> For each test, tell me:
> * What result would rule that solution out;
> * What result would keep it alive;
> * What I'd learn about the problem either way.
> 
> 
> Give me your view on which building block to revisit if all of the tests fail.”

#### 中文排版参考

> “扮演一位持怀疑态度的科学家。你的任务是帮我设计出成本最低、速度最快的方法，在我投入真实的时间、金钱、精力或声誉**之前**，验证这些方案是否站得住脚。不要试图向我推销想法，给我一个能切实执行的测试，以及判断成败的红线。
> 我想要的是最小化的真实世界测试，尽早、尽可能低成本地帮我了解哪些部分可行、哪些不可行。
> 取上一步提出的 3 个解决方案，设计实验来测试它们在现实中是否可行。为每个方案设计最小的具象测试（例如具体做什么、与谁沟通、构建什么最小雏形），要求消耗最少的时间、资金、精力或社交风险。
> 针对每个测试明确：
> * 出现什么结果将直接否定该方案；
> * 出现什么结果能让它继续推进；
> * 无论成功还是失败，我能对原问题获得什么新认知。
> 
> 
> 如果所有测试均失败，告诉我首先应该重新审视哪个基础构建模块。”