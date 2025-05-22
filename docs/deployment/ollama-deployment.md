# Ollama as Deployment Tool

DeepExtension currently offers robust integration with **Ollama** as an external deployment tool. Whether you're deploying models trained inside DeepExtension or connecting to externally managed ones, Ollama enables a complete deployment and registration loop.

This guide helps you understand how to use Ollama with DeepExtension effectively.

---

## Why Ollama?

Ollama provides a lightweight and local-first way to serve LLMs. It's especially useful for:

- Local inference
- Fast prototyping
- Hosting quantized models
- Integrating seamlessly with Dockerized applications like DeepExtension

---

## Key Use Cases

With Ollama, you can:

- **Deploy models from DeepExtension** directly to Ollama and use them for real-time inference.
- **Register Ollama-hosted models** in DeepExtension as **Thirdparty Models** for use in:

    - Prompting (via **DeepPrompt**)
    - Evaluation (via **Model Assessment**)
    - Embedding (e.g., for document-based RAG)

---

## Beginner Tips for Using Ollama

### Installation

Ollama is very easy to install. Refer to the official documentation: [https://ollama.com](https://ollama.com)

> Works on macOS, Linux, and Windows WSL2.

---

### Use `OLLAMA_HOST=0.0.0.0`

When starting Ollama in environments where DeepExtension is running in Docker, always use:

```bash
OLLAMA_HOST=0.0.0.0 ollama serve
```

> This ensures Ollama is reachable from within the Docker network.  
Using `localhost` or `127.0.0.1` will not work with Dockerized DeepExtension.

---

### Check Available Models

Use the following to inspect model availability:

- List deployed models:
  ```bash
  ollama list
  ```

- Show model metadata:
  ```bash
  ollama show <model-name>
  ```

> Useful to verify whether quantized versions are installed, even if not shown explicitly during `pull`.

---

### Pull Models

Use:
```bash
ollama pull <model-name>
```

> Be aware that Ollama might automatically download quantized variants. Confirm details with `ollama show`.

---

### Embedding Models for RAG

For document embedding (used in DeepExtension’s RAG pipeline), you need an embedding model.  
We recommend:

- `nomic-embed-text`: lightweight and fast
  ```bash
  ollama pull nomic-embed-text
  ```

This model works well as the embedding backend in **Document Embedding**.

---

## Summary

Ollama offers a production-friendly way to serve and use LLMs locally. DeepExtension fully supports:

- Deploying trained models via Ollama
- Registering existing Ollama models
- Using Ollama-hosted models for inference, assessment, and embedding

With minimal setup, you can turn local hardware into a powerful inference engine — seamlessly integrated with your DeepExtension workflows.

---

*DeepExtension — Built to extend enterprise AI with flexible deployment options.*
