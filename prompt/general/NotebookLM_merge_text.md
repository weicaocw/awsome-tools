以下内容是关于 **Vibe Coding** 的一个提示词模板，旨在帮助没有编程背景的用户生成用于自动合并文本文件的脚本。

## 中文版 (Chinese Version)

**尝试 Vibe Coding:**

使用下面的提示词，来生成 shell 脚本，一键自动化合并文本文件，适合没有编程背景的同学尝试：

### ## 任务目标

我想把【当前文件夹】里的多个文本文件合并成一个新的文本文件。我没有编程背景。

### ## 具体需求

1. 当前文件夹中，包含若干 `.txt` 和 `.md` 文件
2. 我希望它们合并成一个新的文件，例如：`Combined_Knowledge.txt`
3. 合并规则如下：
* 按文件名顺序合并
* 每个文件内容前，加上文件名作为标题
* 文件之间用明显的分隔符隔开（例如 `---`）


4. 合并后的文件，生成在【同一个文件夹】中
5. 合并后 **不能出现中文乱码**

### ## 我的操作系统

* 操作系统是：（请选择并填写）
* Windows 11
* macOS


* 如果不同系统需要不同方法，请分别给出

### ## 输出要求（非常重要）

1. 请直接给我【完整、可运行的命令或脚本】
2. 不要只讲原理，不要让我自己补代码
3. 请明确告诉我：
* 在哪里打开（例如：终端 / PowerShell）
* 要复制哪一段
* 粘贴后按什么键


4. 请确保脚本中 **显式处理文本编码 (UTF-8)**
5. 如果有容易踩坑的地方，请提前提醒

### ## 请避免

* 不要使用抽象术语
* 不要假设我懂任何编程概念
* 不要省略关键步骤

---

## English Version (Translation)

**Trying Vibe Coding:**

Use the following prompt to generate a shell script that automates merging text files with one click. Ideal for those without a programming background:

### ## Task Goal

I want to merge multiple text files in the [Current Folder] into a single new text file. I have no programming background.

### ## Specific Requirements

1. The current folder contains several `.txt` and `.md` files.
2. I want them merged into a new file, for example: `Combined_Knowledge.txt`.
3. Merging rules are as follows:
* Merge in alphabetical order of filenames.
* Before each file's content, add the filename as a heading.
* Separate files with a clear divider (e.g., `---`).


4. The merged file should be generated within the [Same Folder].
5. There **must be no garbled Chinese characters** after merging.

### ## My Operating System

* The operating system is: (Please select and fill in)
* Windows 11
* macOS


* If different systems require different methods, please provide both separately.

### ## Output Requirements (Very Important)

1. Please provide the [Complete, runnable command or script] directly.
2. Do not just explain the theory; do not ask me to complete the code myself.
3. Please clearly tell me:
* Where to open it (e.g., Terminal / PowerShell).
* Which part to copy.
* Which key to press after pasting.


4. Please ensure the script **explicitly handles text encoding (UTF-8)**.
5. If there are common pitfalls, please warn me in advance.

### ## Please Avoid

* Do not use abstract jargon.
* Do not assume I understand any programming concepts.
* Do not skip key steps.
