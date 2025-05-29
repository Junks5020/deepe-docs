# 开发者指南总览

欢迎阅读 **DeepExtension** 的开发者指南！  
DeepExtension 是一个灵活可扩展的平台，专为构建领域特定的 AI 模型而设计。本指南旨在帮助开发者、工程师及技术爱好者深入理解如何在实际环境中扩展和定制 DeepExtension。

无论您是在本地部署，还是编写自己的训练逻辑，本章节将为您提供所需的一切配置、集成与构建信息 —— 即使您是首次接触大语言模型微调，也可以轻松上手。

---

## 您将学到什么？

本指南将带您了解：

- **支持的硬件与性能建议**  
  掌握不同硬件平台在推理、训练、部署过程中的表现，了解如何平衡速度与资源消耗。

- **安装指南**  
  学会如何在受支持的平台（如 Linux、WSL（含 CUDA）、macOS）上从零搭建 DeepExtension。

- **基础模型管理**  
  学习如何注册与组织本地基础模型，这些模型将作为微调训练的起点。

- **实现自定义训练方法（适用于 CUDA：Linux 或 Windows via WSL）**  
  使用内置模板将您自己的训练脚本（如 LoRA、SFT、GRPO 等）集成到 DeepExtension。

- **实现自定义训练方法（适用于 macOS + MLX）**  
  若您在 macOS 上开发，我们提供 MLX 训练支持。您将学会如何集成并测试 MLX 训练流程。

---

## 适用对象

本章节适合以下群体：

- 有 Python 编程经验，想扩展模型训练逻辑的开发者  
- 负责管理训练环境与硬件资源的 MLOps 工程师  
- 正在构建领域模型原型的 AI 研究人员  
- 希望将 DeepExtension 集成进内部流程的技术用户  

您**不需要**是 AI 专家，我们提供了模板、配置建议与清晰的入门点，帮助您逐步构建完整流程。

---

## 准备好开始了吗？

点击下方任意章节即可进入：

- [支持的 AI 平台及其意义](ai-platform-overview.md)  
- [安装指南](install.md)  
- [添加基础模型](how-to-add-base-models.md)  
- [实现自定义训练方法（CUDA）](implement-own-ai-training-cuda.md)  
- [实现自定义训练方法（macOS）](implement-own-ai-training-mac.zh.md)
