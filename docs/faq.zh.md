# 常见问题解答（FAQ）

本 FAQ 涵盖了有关 DeepExtension 的常见问题，包括其用途、使用方式、授权模式以及与其他工具的对比。

---

### 什么是 DeepExtension？适合哪些人使用？

**DeepExtension** 是一个面向企业的大语言模型（LLM）全生命周期管理平台。  
与那些专为 AI 开发人员设计的工具不同，DeepExtension 主要面向 **领域专家**、**业务分析师** 和 **跨职能团队**，并支持他们与 **AI 开发人员** 高效协作。

---

### DeepExtension 与 W&B、Comet 或 H2O.ai 有什么不同？

**Weights & Biases**、**Comet** 和 **H2O** 等工具主要用于实验追踪，面向的是数据科学家，  
而 **DeepExtension** 更关注领域团队的使用体验 —— 提供 UI 驱动的微调、评估与部署流程，  
**无需代码或机器学习知识**。

---

### DeepExtension 是免费的吗？

是的。我们提供了一个包含所有主要功能的**免费版本**，非常适合 **个人用户** 或 **小型团队**。  
大型团队或企业可通过购买商业版本解锁更多功能。

---

### DeepExtension 是开源的吗？

**部分开源。**

- AI 训练组件（包括 Adapter、GRPO、MLX 训练等）计划以 **Apache-2.0** 协议开源。
- 核心应用（UI + 生命周期后端）为 **闭源**，但我们提供了 **公开的 Docker 镜像**，任何人都可以免费部署和使用。

---

### 使用 DeepExtension 是否需要编程技能？

**不需要。**您可以通过网页界面完成：

- 模型训练  
- 模型评估  
- 模型推理  
- 基于文档的 RAG 应用  

全部 **零代码操作**。

但在初始安装阶段（尤其是在 Linux 或 macOS 上），建议由具备 **基础 Docker 知识** 的人员协助安装。

---

### 支持哪些 AI 平台？

当前支持：

- **CUDA（Linux，NVIDIA GPU）** —— 支持完整训练功能
- **MLX（macOS，Apple Silicon）** —— 支持轻量训练

我们正在积极评估支持更多平台，例如 **AMD ROCm**、**ONNX Runtime** 和 **Windows CPU 推理**。

---

### 我可以微调自己的大模型吗？

当然可以。  
DeepExtension 支持多种 **参数高效微调方法**，如 **SFT**、**LoRA** 和 **GRPO**，全部 **无需编码**。  
如果您有 AI 开发经验，也可以实现自定义训练方法。

---

### 我可以离线运行 DeepExtension 吗？

可以。  
整个平台可以在本地或私有云中 **离线运行**，无需任何外部 API。  
您可以使用本地基础模型进行训练、部署和评估，全部无需联网。

---

### 如何安装 DeepExtension？

我们提供详细的安装说明，适用于：

- **Linux（CUDA）**
- **macOS（Apple Silicon）**

安装过程基于 **Docker Compose**，如果环境准备完毕，通常可在 30 分钟内完成部署。  
详见 [安装指南](developer/install.md)。

---

*仍有疑问？请通过 [支持页面](about/support.md) 联系我们。*
