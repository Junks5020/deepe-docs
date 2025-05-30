# 系统架构（System Architecture）

**DeepExtension** 是一个模块化、可扩展、企业级的平台，支持 AI 模型开发从数据准备到模型部署的全生命周期管理—。本章节将提供其架构的高层次概览。

---

## 总览（Overview）

从整体上看，DeepExtension 包含以下关键架构层：

---

## 1. 用户界面层（User Interfaces）

- **基于 Web 的用户界面**（自部署）：大多数用户使用的主要交互界面  
- **RESTful API**：支持程序化访问、CI/CD 集成或自动化操作

---

## 2. 应用层（Application Layer）

负责核心业务逻辑和用户体验，包括：

- **用户与项目管理**
- **任务调度**（训练、评估、微调）
- **模型生命周期管理**：跟踪模型版本、性能和使用情况
- **数据版本管理**：支持增量式、标注型数据集
- **评估工具**：内置基准测试、JSON 验证器、业务规则测试器
- **安全机制**：支持 RBAC、Token 鉴权、操作审计日志

---

## 3. 核心 AI 层（Core AI Layer）

是 DeepExtension 的 AI 核心所在：

- **GRPO 引擎**：集成提示词优化的定制强化学习逻辑  
- **训练任务编排器**：管理 LLM 微调任务的执行与调度  
- **可定制训练逻辑**：可以接入任意形式的训练代码，只需稍作调整，即可由 DeepExtension 执行、追踪和监控

---

## 4. 基础设施层（Infrastructure Layer）

用于提供计算与存储支持：

- **CUDA GPU 支持（Linux 或者 Windows (通过 WSL)）**：用于训练与推理的高性能部署环境  
- **macOS 本地开发支持**：适用于模型开发与预览  
- **Docker Compose**：统一管理服务组件（数据库、向量库、API、UI 等）  
- **存储后端**：

  - **文件存储**：管理原始数据集、模型检查点及中间产物  
  - **向量数据库**：用于存储和查询向量嵌入（如语义搜索或 RAG）  
  - **关系型数据库（如 PostgreSQL）**：用于存储元数据、配置与训练记录

---

## 5. 集成能力（Integrations）

DeepExtension 支持与多种平台和工具的集成：

- **主流 LLM 服务商**：如 OpenAI、Qwen、Claude、SiliconFlow 等  
- **本地模型工具**：兼容如 **LM Studio**、**Ollama** 等本地模型运行与实验平台
<!-- - **向量数据库** -->

---

## 6. 安全特性（Security Features）

- 基于角色的访问控制（RBAC）  
- 项目级权限隔离  
- 操作日志记录与可追溯性  
- 支持物理隔离部署（Air-gapped Deployment）

---

## 7. 部署选项（Deployment Options）

| 目标环境             | 描述说明                                 |
|----------------------|------------------------------------------|
| `CUDA（Linux 或者 Windows (通过 WSL))`      | 针对高性能训练进行了优化配置             |
| `macOS（开发环境）`  | 基于 Docker 运行，适用于本地使用或学习 |
| `自托管 SaaS`        | 可用于企业内部或对外服务的完整部署方案     |

---

## 总结（Summary）

**DeepExtension** 的系统架构兼顾了实验性研发和企业级关键场景的灵活性。通过分层设计，能够轻松集成到现有的 AI 技术栈中，同时为用户提供对模型工作流的全面控制。
