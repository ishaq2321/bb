# Temporal & Behavioral Intelligence

Backbencher does more than just parse your code's current state—it predicts how your code *will* change. By fusing AST (Abstract Syntax Tree) intelligence with Git temporal history, Backbencher gains a behavioral understanding of your project's evolution.

---

## 1. Co-Occurrence Analysis (The "Usually Modified Together" Rule)

Every codebase has hidden dependencies that aren't explicit in the code. For example, updating a database schema file might *always* require updating a corresponding migration script, even though neither file imports the other.

**How Backbencher sees this:**
When you use `bb_update` to modify the schema file, Backbencher instantly queries the temporal intelligence engine. It cross-references git commit histories and file modification timestamps to detect temporal patterns.

If it finds that 90% of the time `schema.ts` is changed, `migration.sql` is also changed, it will issue a **🔮 PREDICTIVE INTEL** warning. 

## 2. Predictive Workflow Steps

When you ask the AI to implement a feature, it queries `bb_patterns` with `workflow_next_steps`. 

Instead of guessing what to do next based on generic programming knowledge, Backbencher looks at your specific project's history.
- Did you just add a new Redux slice? Backbencher predicts you'll likely need to add it to the root reducer, because that's what usually happens in *your* repository.
- Did you just create a new API route? Backbencher predicts you need to write the corresponding integration test.

## 3. Architectural Violations & Code Smells

Because the engine understands the logical layers of your application (e.g., Domain, Presentation, Data), it monitors the behavioral evolution of the project.
If a UI component suddenly imports a raw SQL query file, Backbencher flags this as a temporal architectural violation, preventing spaghetti code before it gets committed.