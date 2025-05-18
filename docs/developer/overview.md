# Developer Guide Overview

Welcome to the Developer Guide for **DeepExtension** — a flexible, extensible platform for building 
domain-specific AI models. This guide is designed to help developers, engineers, and technically curious users 
understand how to extend and customize DeepExtension for real-world usage.

Whether you're deploying on a local machine or preparing your own training logic, this section provides everything 
you need to set up, integrate, and build with confidence — even if you're new to LLM fine-tuning.

---

## What You'll Learn

This guide will walk you through:

- **Supported Hardware & Performance Notes**  
  Understand which hardware configurations work best for inference, training, and deployment — and how they affect 
speed and capacity.

- **Installation Guide**  
  How to set up DeepExtension from scratch on supported platforms like Ubuntu (CUDA-enabled) and macOS.

- **Base Model Management**  
  Learn how to register and organize local base models that serve as the foundation for all fine-tuning 
activities.

- **Implementing Your Own Training (Ubuntu + CUDA)**  
  Extend DeepExtension by integrating your own training script (LoRA, SFT, GRPO, etc.) using our built-in 
templates.

- **Implementing Your Own Training (macOS + MLX)**  
  If you're developing on macOS, we offer support for lightweight training using Apple Silicon and MLX. You'll 
learn how to integrate and test custom MLX-based training workflows.

---

## Who This Is For

This section is for:

- Developers with Python experience who want to extend model training logic
- MLOps engineers managing training environments and hardware
- AI researchers prototyping domain-specific models
- Technical users seeking to customize DeepExtension for internal workflows

You do **not** need to be an AI expert to follow along — we provide templates, configuration tips, and clear entry 
points so you can build progressively.

---

## Ready to Start?

Choose a chapter below to dive in:

- [Supported Hardware & Why It Matters](hardware-overview.md)  
- [Installation Guide](install.md)  
- [Add Base Models](how-to-add-base-models.md)  
- [Implement Your Own Training (CUDA)](implement-own-ai-training-cuda.md)  
- [Implement Your Own Training (MacOS)](implement-own-ai-training-mlx.md)

