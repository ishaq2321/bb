# Semantics & Embeddings

Backbencher (bb) doesn't just read the text of your code—it understands the *meaning* behind it. By generating vector embeddings for your codebase's AST nodes, bb enables true semantic search and conceptual reasoning.

## How Semantic Search Works

If you search for "payment processing logic", traditional `grep` will look for the exact string "payment processing logic". It will fail if your code actually says `async function executeStripeCharge()`.

Backbencher, however, converts both your query and your codebase into multi-dimensional vectors (Embeddings). It calculates the mathematical "closeness" (Cosine Similarity) between the concepts. This means searching for "payment processing" will accurately return `executeStripeCharge()`, `StripeAPIClient`, and `handleRefund()`.

## Model Flexibility (Privacy vs Power)

Backbencher respects your infrastructure and privacy choices. It supports multiple embedding architectures:

1. **Free Proxy (Default):** Out of the box, bb routes embedding generation through the `opencode/text-embedding-3-small` proxy. This provides lightning-fast OpenAI embeddings for free, without needing an API key.
2. **Bring Your Own Key (BYOK):** If your company uses specific cloud providers, you can configure bb to use your own OpenAI, Azure, Vertex AI, or Cohere API keys.
3. **Local Models (Privacy First):** For air-gapped or high-security environments, you can point bb to local Ollama or HuggingFace endpoints to generate embeddings entirely on your own hardware.

## Intelligent Fallbacks

If you hit a rate limit, or if you disable cloud embeddings for a specific project, Backbencher's semantic engine gracefully degrades. It falls back to an ultra-fast local SQLite FTS5 (Full-Text Search) engine, ensuring that code search never fully breaks, even when offline.