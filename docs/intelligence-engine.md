# The Intelligence Engine

At the core of Backbencher OS is a high-speed, local, privacy-first **Intelligence Engine** that instantly maps your entire codebase. Instead of relying on slow, inaccurate grep searches or uploading your entire codebase to an LLM, Backbencher processes your code locally and builds a real-time map of how everything connects.

---

## 1. What is the Intelligence Engine?

When you run Backbencher, the Intelligence Engine silently indexes your files. It understands the **structure** of your code (functions, classes, variables) rather than just the raw text.

**Key Benefits:**
- **Lightning Fast:** Once indexed, finding a function or discovering its callers happens in milliseconds.
- **Privacy First:** The index is built and stored entirely on your local machine. No source code is sent to external servers during the indexing process.
- **Cross-Language:** It natively understands TypeScript, Python, Rust, Go, Java, and many other languages, mapping dependencies seamlessly even if your frontend is React and your backend is Django.
- **Real-Time Sync:** The engine automatically detects when you modify files and updates its map JIT (Just-In-Time), ensuring the AI tools always see the most accurate version of your project.

## 2. How the AI uses the Engine

When you ask Backbencher a question or instruct it to modify a file, it does not guess.

1. **JIT Context Extraction:** The AI queries the local engine for exact context. If you say "Update the `loginUser` function," the engine provides the exact boundaries of that function.
2. **Surgical Updates:** Because the engine knows where the function starts and ends, Backbencher replaces *only* that function, leaving the rest of your file (and your indentation) perfectly intact.
3. **Relationship Mapping:** Before deleting or modifying a critical class, the engine tells the AI exactly which other files rely on it, preventing broken builds and missing imports.

This engine is what gives Backbencher "God-Mode" understanding of your architecture, enabling safe, autonomous software engineering at scale.
