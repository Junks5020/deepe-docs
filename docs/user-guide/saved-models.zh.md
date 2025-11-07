
# 完整模型（Complete Models）

**完整模型**是通过将训练好的适配器（adapter）合并到其对应的基础模型（Base Model）中创建的完全物化模型（fully materialized models）。
一旦保存，这些模型就成为了**可独立部署、评估或复用的版本化快照**。

---

## 总览

在 **完整模型** 页面中，可以查看所有通过 [定制模型](trained-models.zh.md) 接口成功保存的模型列表。

每个模型条目包含以下信息：

- **自动生成的名称**：使用以下格式生成：

```
[complete_model_name] = [customized_model_name]_s_[first4ofSavingUUID]
```

- **模型卡片**（Model Card）：包含来自基础模型和训练过程的技术细节、配置信息和元数据的结构化摘要

---

## 部署完整模型

部署完整模型使其可用于实时推理：

1. 点击所选模型旁的 **“部署”** 按钮
2. 提供所需的额外参数（如量化配置、部署环境）
3. DeepExtension 会将部署请求转发至配置好的 LLM 部署工具
4. 部署成功后，该模型将出现在 [上线模型](deployed-models.zh.md) 页面中

> **注意：**
>
> - DeepExtension 本身并不直接提供模型服务，所以部署前需要先与外部部署后端进行集成。
> - 使用 **Ollama** 进行部署时，需提供有效的 **模型部署模板文件（Deployment Template File）**，详见 [基础模型](base-models.zh.md)。
> - 必须正确设置 **部署环境**，详见 [部署工具配置](deployment-tool-configuration.zh.md)。
> - 因为目前 Ollama API 支持的量化模型限制，DeepExtension 当前也仅支持以下几种量化模式：`no_quantization`、`q8_0`、`q4_K_M` 和 `q4_K_S` 。

---

## 删除完整模型

要删除一个完整模型：

- 点击目标模型旁的 **“删除”** 按钮
- 此操作将**永久从本地存储中删除模型目录**

> 如果该模型已经通过 **“部署”** 按钮部署，则其在 [上线模型](deployed-models.zh.md) 中的部署记录将不受影响。

---

*DeepExtension —— 从训练产物到可部署智能，尽在一体化流程中*
