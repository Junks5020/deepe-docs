# Supported AI Platform & Why It Matters

DeepExtension is built to bridge the gap between enterprise users and the 
complexity of LLM training. A key part of that mission is supporting AI platforms 
that balance **performance**, **accessibility**, and **developer-friendliness** 
across a variety of hardware and operating systems.

This page explains the current supported platforms, the rationale behind them, and 
how they shape the DeepExtension user experience.

---

## Why Platform Choice Matters

The choice of AI platform directly influences:

- **Compatibility with popular ML libraries** (e.g., PyTorch, TensorFlow)
- **Training and inference performance**
- **Ease of installation and deployment**
- **Hardware cost and accessibility**

For non-AI experts or resource-constrained teams, a complex setup can become a 
deal-breaker. DeepExtension aims to **lower the entry barrier** without 
compromising performance — which is why platform support is a strategic decision.

---

## CUDA Platform: Industry Standard for LLM Training

From the early days of DeepExtension, we adopted **CUDA** as the primary training 
and inference backend. CUDA-enabled GPUs (NVIDIA) remain the **de facto standard** 
for:

- Full compatibility with PyTorch and TensorFlow  
- Optimized support for LLM architectures and large-scale parallelism  
- Ecosystem maturity (tools, community, research support)

This makes CUDA the most **reliable and performant choice** for serious training 
workflows. DeepExtension's training modules, including GRPO and SFT, are fully 
optimized for CUDA environments.

> CUDA is strongly recommended for enterprise users who require scalable training 
on open-source foundation models (e.g., Qwen, LLaMA, DeepSeek).

---

## MLX on Apple Silicon: Lightweight and Accessible

While CUDA is powerful, it's not easily accessible to all users — especially 
individual researchers or smaller teams without access to NVIDIA hardware.

Apple's M-series chips (M1–M4) introduced a new opportunity. With a **Unified 
Memory Architecture (UMA)** and impressive on-device AI performance, they offer:

- A compact yet capable development environment
- No additional GPU needed — it’s built into the chip
- Quiet, energy-efficient operation ideal for everyday usage

We initially tested **PyTorch with Metal backend (MPS)** on macOS, but found its 
performance to be inconsistent and its compatibility limited.

Instead, we chose to integrate with **MLX** — Apple’s new machine learning 
framework built specifically for Apple Silicon. MLX offers:

- Superior performance over MPS in real-world scenarios  
- Simpler setup and memory management  
- High efficiency for small-scale training and experimentation

DeepExtension now includes **pre-installed MLX training demos** to help new users 
run their first fine-tuning workflow right from their Mac.

---

## Currently Supported Platforms

| Platform        | Backend   | Supported OS | Use Cases                                |
|----------------|-----------|--------------|------------------------------------------|
| **CUDA**        | PyTorch / TensorFlow   | Linux, Windows (via WSL)  | Full-scale model training, production    |
| **MLX**         | MLX       | macOS (M1–M4)| Local development, small-scale training  |

> Other platforms are not currently supported, but may be considered based on user demand.

---

## Roadmap for Future Platform Support

We understand that hardware and ecosystem preferences vary — especially across 
global and diverse user bases.

While CUDA and MLX meet the majority of current use cases, we are actively 
collecting feedback to evaluate support for platforms such as:

- Windows (for CPU inference and simple UI testing)
- AMD ROCm platform (for open GPU ecosystems)
- ONNX Runtime or TensorRT (for inference-optimized deployment)

If you have specific platform needs or environment constraints, please reach out 
via [Support](../about/support.md). Your input directly helps shape our roadmap.

---

*DeepExtension is here to make LLM training more accessible — regardless of 
whether you run on a data center, a MacBook, or a startup budget.*

