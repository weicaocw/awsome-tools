# Nano-Level R Project Reading · Universal Prompt Template

> **Use case**: For developers with a Python / Go background who want to systematically and deeply read an unfamiliar R project (including mlr3 / torch ecosystems, R6 OOP code, data.table, etc.). Hand this prompt framework to an LLM as your "expert mentor."

---

## Role Definition

```
You are a patient R language master and also <project author / ecosystem maintainer> in person.
You are proficient in: R itself (S3/S4/R6/R7 OOP systems), <list of core dependency packages>,
PyTorch / LibTorch internals, machine learning mathematics, and software engineering design patterns.

When answering all questions, you must:
1. Provide analogies to languages I know (Python / Go);
2. Math formulas must be written out in full — explain every symbol and describe "what story the formula tells";
3. For R "magic syntax" and syntactic sugar, stop and explain separately with at least 3 real-life code examples;
4. For "code golf" style code (everything crammed together), first split it into meaningful modules, then explain each module;
5. For every function/class mentioned, state: which package it comes from, input/output types, parameter meanings, and underlying mechanics;
6. Leave out no details, no matter how minor.
```

---

## Layer 1: Project Structure Overview

### Prompt

```
Walk me through this R project's directory structure, covering every directory and file without omission.

Answer specifically:
1. What are the rules for file loading order under R/? Why is zzz.R always loaded last?
2. What do DESCRIPTION and NAMESPACE do? Read them line by line.
   - What is the essential difference between Imports and Suggests? Why is a certain package in Suggests rather than Imports?
   - In importFrom(pkg, func), what do the two arguments mean? After importing, can I still use other functions from that package?
3. Test directory structure: what roles do testthat.R and the test-*.R files under testthat/ each play?
4. If there is C++ code, which directory would it live in? How do R and C++ call each other?
5. What does build.sh / Makefile do? Explain line by line.
6. What does .onLoad() in zzz.R do? What is the complete flow of mlr3misc::register_namespace_callback?
7. How deeply is this package integrated with the <ecosystem name>? Which files should I look at to confirm?
```

---

## Layer 2: Core Code Nano-Level Reading

### 2.1 Classes and Objects (OOP System)

```
Give me a nano-level reading of the following code:

<paste code>

Answer:
1. What is the development lineage of S3 / S4 / R6 / R7? What problem did each solve? Which system is used here?
2. Is this function/class a "factory function" or does it return an instance directly? Is there an implicit return?
3. What parent class does inherit= inherit from? What methods does the parent predefine? Which are overridden here?
   - Compare with Python's super().__init__() mechanism — what does R's super$initialize() do?
4. What is the responsibility of each method: initialize / .iter / .length / set_batch_list?
5. Why are there no public / private / active keywords here? (Compare with standard R6 syntax.)
6. What is the difference between self$xxx <<- and self$xxx <-? How does closure "memory" work mechanically?
7. Inheritance vs. composition design philosophy — illustrate with 3 real-life examples. How does Go handle this?
```

### 2.2 Functions and Syntax

```
Read the following code snippet line by line. Whenever you encounter R syntax unfamiliar to a Python programmer, stop and explain it separately:

<paste code>

Pay special attention to:
1. Assignment operators: <- / <<- / = / :=  — what are they and when is each used?
2. The difference between double brackets [[]] and single brackets [].
3. Pipe operators: what are |> and %>%?
4. data.table's DT[i, j, by] syntax — what does each of the three slots mean?
   - What advanced usage is it to write data.table(...) directly inside the j slot?
   - What is the difference between := and = inside data.table?
5. The ~ tilde operator in dcast / melt / facet_grid — what does it mean in each context?
   Explain with SQL GROUP BY and PIVOT analogies, and give at least 3 real-life examples.
6. %/% integer division, %% modulo, %in% membership — list common R infix operators.
7. Compare R's ... (dot-dot-dot) with Python's *args, **kwargs.
8. The single-line if(condition) value expression — what is returned if the condition is FALSE? Compare R's NULL with Python's None.
9. Symbols wrapped in backticks like `:=` — what does this mean? When are backticks required?
```

### 2.3 Function Tracing and Package Attribution

```
For every function/class appearing in the code, I need to know which package it belongs to:

1. How do I find which package a function belongs to? (find() / environmentName(topenv(...)) etc.)
2. How do I view all fields and methods of an R6 object?
3. How do I view a function's source code?

Please introduce each of the following functions/classes: which package, input type, output type, parameter meanings, underlying mechanics,
and describe their behavior in mathematical language (with formulas):

<list the functions/classes appearing in the code>
```

---

## Layer 3: Mathematics and Machine Learning Principles

```
This code involves the following machine learning concepts — please fill in the foundational knowledge:

<paste code or describe the scenario>

For every concept involved, you must:
1. Give the full mathematical formula (complete, no omitted derivation steps);
2. Explain every symbol in the formula;
3. Describe in one sentence "what story this formula tells";
4. If there is a corresponding PyTorch implementation, give the code framework.

Example concepts (replace with what's actually in your code):
- Loss functions (BCE Loss / MSE Loss / AUC-based Loss)
- Dropout regularization (mathematical meaning of the p parameter)
- Gradient descent (differences between batch / mini-batch / stochastic)
- Stratified sampling (mathematical definition)
- Validation split strategy (risks of random vs. stratified split)
- Random seed mechanism (how torch seed depends on R seed)
- Mathematical meaning of predict_type = "prob" vs. "response"
```

---

## Layer 4: Engineering Design and Architecture

```
Analyze this code from a software engineering perspective:

<paste code>

1. What design pattern is used here? (Factory, Strategy, Observer, Template Method, ...)
   Illustrate with 3 real-life examples showing what problem this pattern solves.
2. How does the "memory" of closures manifest here? What is the parallel with Python's yield / generator?
3. Concurrency architecture: what do the future / future.apply packages do?
   - What effect does future::plan("multisession") have?
   - What is the difference between future_lapply and lapply?
   - How are ... arguments passed through?
4. How many sources of randomness exist here? How is reproducibility controlled for each?
5. GPU support: does the code run on CPU by default? How would you adapt it for GPU? Give concrete modified code.
   What happens if a custom loss function forgets to specify device?
```

---

## Layer 5: Testing and Refactoring

### 5.1 Reading Test Files

```
Help me read the following test file closely and understand R community testing conventions:

<paste test code>

1. Basic testthat structure: what are the arguments to test_that()? What is the execution flow? Who triggers execution?
2. The expect_* family: list expect_equal / expect_error / expect_true / expect_warning etc., each with API and use case, giving 3 examples from simple to complex.
3. Conditional test blocks like if(condition) { test_that(...) } — how does the test framework handle the if branch?
4. Parse specific assertion statements, e.g.:
   expect_equal(sum(matrix["rowname",] >= 1), ncol(matrix))
   Is matrix["rowname",] matrix-specific syntax? Does >= 1 return a boolean vector? Does sum() treat TRUE as 1?
5. Why is data.table::setDTthreads(1L) set in tests?
```

### 5.2 Refactoring Plan Design (TDD)

```
I want to refactor <describe the refactoring goal, e.g., extract a parent class from two similar batch_sampler_* functions>.
Please help me:

1. Analyze shared logic and differences between the two files; identify what interface can be extracted into a parent class;
2. Following R community TDD best practices, where should new tests be added?
   A. Append test cases to the existing test-CRAN.R;
   B. Create a new test_that block inside test-CRAN.R;
   C. Create a new test-<feature>.R file.
   Give the best practice recommendation and reasoning.
3. Provide a skeleton of the refactored parent class, marking which methods are template methods (subclass must implement) and which are shared implementations;
4. How do you run only a specific test file / specific test case? How do devtools and R CMD check each do this?
5. Write a clean PR message template including: background, motivation, changes made, test coverage notes.
```

---

## Layer 6: Build and CI/CD

```
Help me read the build script and GitHub Actions workflow line by line:

<paste build.sh or workflow.yaml>

1. In the build script:
   - What is set -o errexit?
   - Usage of grep / sed (explain regex symbols ^ $ . * \1 etc.);
   - What does the -v flag in grep -v mean? Why must the Remotes field be removed before CRAN submission?
   - What does each of R --vanilla CMD build / install / check --as-cran actually do internally?
   - What does the tee command do?
2. In the GitHub Actions workflow:
   - When does on: push/pull_request trigger?
   - What is the purpose of the matrix.config matrix strategy?
   - What does each r-lib/actions/* action do?
   - Why does torch::install_torch() need its own separate step? (What does each of the two installs install?)
3. What tests does this CI cover? What is missing?
```

---

## Appendix: Common Follow-Up Prompts

| Situation | Follow-Up Prompt |
|-----------|-----------------|
| Unfamiliar function | "Which package does this function come from? What are the input/output types? Parameter meanings? Underlying mechanics? Describe in mathematical language with formulas." |
| Magic syntax | "What R syntax is this? What is the Python equivalent? Give 3 real-life examples with runnable code." |
| Code crammed together | "Split this code into meaningful functional modules, explain each module, and for any code golf, break it down line by line." |
| Math concept | "Give the full math formula, explain each symbol, state what story the formula tells. No derivation steps omitted." |
| Design pattern | "What design pattern is used here? Give 3 real-life examples illustrating what problem this pattern solves." |
| Comparing two approaches | "Explicit form A and implicit form B produce the same result. Why use explicit? Any hidden risks?" |
| Package attribution | "How do I find which package this function/class belongs to? Give me a runnable R query command." |
| Randomness control | "How many sources of randomness are there? How is reproducibility controlled? What is the dependency relationship between torch seed and R seed?" |
| GPU adaptation | "Does this code run on CPU by default? How would you adapt it for GPU? What happens if a custom function forgets to specify device?" |
| Concurrency | "What is the relationship between the future and future.apply packages? What options does future::plan() have? How do you verify that parallelism is actually working?" |

---

## Usage Instructions

1. **First use**: Send the "Role Definition" section to the LLM to establish the conversational role.
2. **Layer by layer**: Progress through Layer 1 → Layer 6 in order, each time pasting one layer's prompt along with the relevant code snippet.
3. **Follow up freely**: When you don't understand a response, select an appropriate follow-up from the "Appendix: Common Follow-Up Prompts."
4. **Replace placeholders**: Substitute `<paste code>`, `<project author>`, `<list of core dependency packages>`, etc. with your actual content.
5. **Iterate deeper**: For the same code block, you can do three passes — first a "macro explanation," then "line-by-line explanation," then "drill into details."
