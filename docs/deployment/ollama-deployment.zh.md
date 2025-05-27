# Ollama 作为部署工具

DeepExtension 当前已与 **Ollama** 实现深度集成，可作为外部模型部署工具使用。无论是部署在 DeepExtension 内部训练的模型，还是连接外部管理的模型，Ollama 都可提供完整的部署与注册闭环。

本指南将帮助您理解如何有效结合 DeepExtension 使用 Ollama。

---

## 为什么选择 Ollama？

Ollama 提供了一种轻量级、本地优先的方式来部署大语言模型（LLMs）。它特别适用于：

- 本地推理
- 快速原型开发
- 部署量化模型
- 与如 DeepExtension 这类基于 Docker 的应用无缝集成

---

## 关键使用场景

借助 Ollama，您可以：

- **将 DeepExtension 中训练的模型部署到 Ollama**，用于实时推理。
- **将 Ollama 中托管的模型注册为 DeepExtension 的“第三方模型”**，以用于：

    - 提示词推理（通过 **DeepPrompt**）
    - 模型评估（通过 **模型评估** 模块）
    - 文档嵌入（例如在基于文档的 RAG 流程中）

---

## 新手入门提示

### 安装

Ollama 非常易于安装。请参考官方文档：[https://ollama.com](https://ollama.com)

> 支持 macOS、Linux 和 Windows（WSL2）。

---

### 使用 `OLLAMA_HOST=0.0.0.0`

当在 DeepExtension 运行于 Docker 环境时启动 Ollama，请务必使用以下命令：

```bash
OLLAMA_HOST=0.0.0.0 ollama serve
```

> 这可确保 Ollama 可被 Docker 网络中的服务访问。  
如果使用 `localhost` 或 `127.0.0.1`，将无法与 Docker 化的 DeepExtension 正常通信。

---

### 查看可用模型

使用以下命令检查模型是否可用：

- 列出当前部署的模型：
  ```bash
  ollama list
  ```

- 查看模型元信息：
  ```bash
  ollama show <模型名称>
  ```

> 用于确认是否已安装量化版本，即使 `pull` 过程中未明确显示。

---

### 拉取模型

执行：
```bash
ollama pull <模型名称>
```

> 注意：Ollama 可能会自动下载量化版本。使用 `ollama show` 可确认细节。

---

### 用于 RAG 的嵌入模型

若用于文档嵌入（例如在 DeepExtension 的 RAG 流程中），您需要一个专用的嵌入模型。我们推荐：

- `nomic-embed-text`：轻量且高效
  ```bash
  ollama pull nomic-embed-text
  ```

此模型非常适合作为 **文档嵌入** 模块的后端。

---

## 总结

Ollama 提供了一个适合生产环境的方式来本地部署与使用 LLM。DeepExtension 完整支持以下能力：

- 通过 Ollama 部署训练完成的模型
- 注册已有的 Ollama 模型
- 在推理、评估和嵌入任务中使用 Ollama 托管的模型

只需极少配置，您就可以将本地硬件转变为强大的推理引擎 —— 与 DeepExtension 无缝协作。

---

*DeepExtension —— 为企业 AI 提供灵活的部署方案。*
