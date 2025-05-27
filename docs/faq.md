# Frequently Asked Questions (FAQ)

This FAQ covers the most common questions about DeepExtension — its purpose, usage, licensing, and how it compares to other tools.

---

### What is DeepExtension and who is it for?

**DeepExtension** is an enterprise-grade platform designed for managing the full lifecycle of large language models (LLMs).  
Unlike tools made purely for AI developers, DeepExtension is designed for **domain experts**, **business analysts**, and **cross-functional teams** to collaborate seamlessly with **AI developers**.

---

### How is DeepExtension different from W&B, Comet, or H2O.ai?

While tools like **Weights & Biases**, **Comet**, and **H2O** focus on experimentation tracking and are built primarily for data scientists, 
**DeepExtension** is designed with domain teams in mind — with UI-driven workflows for fine-tuning, evaluation, and deployment,
**without requiring code or ML expertise**.

---

### Is DeepExtension free to use?

Yes. There is a **free version** that includes all major features and is more than sufficient for **individual users** or **small teams**.  
Larger teams or enterprises can unlock additional functionality via commercial plans.

---

### Is DeepExtension open-source?

**Partially.**

- The AI training components (including adapters, GRPO, MLX training, etc.) are planned to be released under **Apache-2.0**.
- The core application (UI + lifecycle backend) is **closed-source**, but **Docker images are publicly available** so that everyone can use and deploy DeepExtension without paying.

---

### Do I need to know how to code to use DeepExtension?

**No.** You can:

- Train models  
- Evaluate model quality  
- Run inference  
- Use document-based RAG  

All from the **web UI**, with **zero coding**.

However, for the initial installation (especially on Linux/Mac), someone with **basic Docker knowledge** should assist.

---

### What AI platforms are supported?

Currently:

- **CUDA (Linux or Windows via WSL)** — full support including training
- **MLX (macOS, Apple Silicon)** — lightweight training with prebuilt methods

We are actively evaluating more platforms like **AMD ROCm**, **ONNX Runtime**, and **Windows CPU inference**.

---

### Can I fine-tune my own LLMs?

Yes.  
DeepExtension supports several **parameter-efficient fine-tuning** methods like **SFT**, **LoRA**, and **GRPO**, with no coding required.  
You can also implement your own training methods if you have AI experience.

---

### Can I run DeepExtension offline?

Yes.  
The entire platform can run **locally or inside a private cloud**, without any external API dependencies.  
You can use local base models, run training, deploy models, and even evaluate them offline.

---

### How do I install DeepExtension?

We provide detailed installation instructions for:
- **CUDA（Linux or Windows via WSL)** systems
- **macOS (Apple Silicon)**

Installation uses **Docker Compose**, and a typical setup can be completed in under 30 minutes if requirements are met.  
See [Installation Guide](developer/install.md) for details.

---

*Still have questions? Contact us via the [Support Page](about/support.md).*
