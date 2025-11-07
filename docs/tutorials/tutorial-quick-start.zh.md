# 快速开始：运行您的首次训练任务

DeepExtension 通过完全可视化的界面，帮助您在无需编写代码的情况下轻松启动首次模型训练。

根据系统的 AI 平台，我们已预安装多个演示训练方法，助您快速上手。

---

## 可用的演示训练方法

### 对于 CUDA（Linux 或者 Windows (通过 WSL)）用户：

- **GRPO-Demo**：基于 GRPO（Guided Reinforcement with Prompt Optimization）方法的逻辑对齐微调示例。
- **SFT-Demo**：适用于小规模任务的监督微调示例。

### 对于 macOS 用户（Apple Silicon 与 MLX）

- **MLX-Demo**：基于 Apple MLX 框架的演示训练方法，已针对 M 系列芯片优化。

---

## 开始之前

如 [流程依赖关系](tutorial-process-dependency.md) 页面所述，确保以下组件已准备就绪：

- 已添加一个**基础模型**
- 拥有一个**数据集**
- 至少一个已预安装的**演示训练方法**

建议使用以下示例数据集之一：

- **GRPO-Demo**（`openai/gsm8k` 数据集前 100 行）：  
  [`openai-gsm8k_first_100_lines.jsonl`](../assets/datasets/openai-gsm8k_first_100_lines.jsonl)

- **SFT-Demo**（`yahma/alpaca-cleaned` 数据集前 100 行）：  
  [`alpaca_data_cleaned_first_100_lines.jsonl`](../assets/datasets/alpaca_data_cleaned_first_100_lines.jsonl)

- **MLX-Demo**（来自 MLX 官方仓库）：  
  [`mlx-demo-train-dataset.jsonl`](../assets/datasets/mlx-demo-train-dataset.jsonl)

- **VL-SINGLE-Demo** :  
  [`single-images-folder`](../assets/datasets/single-images.tar.gz)

- **VL-MULTI-Demo** :  
  [`multi-images-folder`](../assets/datasets/multi-images.tar.gz)


也可以使用自己的数据集，需要确保其结构与上述任一示例保持一致，包括字段名的匹配。

---

## 演示训练的建议参数配置

以下为一套适用于所有演示训练方法的最小参数配置：

| **参数名**                 | **说明**                                 | **推荐值**                  |
|---------------------------|------------------------------------------|-----------------------------|
| Base Model                | 用于微调的基础模型                        | `Qwen2.5-1.5B`              |
| Dataset                   | 要使用的数据集                            | `demo-dataset`              |
| LORA_RANK                 | LoRA 适配器的秩                          | `8`                         |
| LOAD_IN_4BIT              | 是否启用 4bit 量化                        | `true`                      |
| MAX_SEQ_LENGTH            | 最大序列长度                              | `1024`                      |
| MAX_INPUT_LENGTH          | 最大输入长度                              | `1024`                      |
| MAX_CONTENT_LENGTH        | 最大内容长度                              | `1024`                      |
| MAX_SAMPLES               | 最大训练样本数                            | `1000`                      |
| NUM_GENERATIONS           | 每批次生成数                              | `2`                         |
| MAX_GRAD_NORM             | 梯度裁剪阈值                              | `0.5`                       |
| EPOCHS*                   | 训练轮数                                  | `1`                         |
| MAX_STEPS                 | 最大训练步数                              | `10`                        |
| BATCH_SIZE                | 训练批大小                                | `2`                         |
| GRAD_ACCUM_STEPS          | 梯度累计步数                              | `2`                         |
| LEARNING_RATE             | 初始学习率                                | `2e-5`                      |
| WARMUP_STEPS              | 预热步数                                  | `2`                         |
| WARMUP_RATIO*             | 预热比例（作为 WARMUP_STEPS 替代）        | `0.01`                      |
| OUTPUT_DIR                | 输出目录                                  | 系统自动生成                |
| PromptInputColumn**       | 输入字段名称                              |                             |
| PromptOutputColumn**      | 输出字段名称                              |                             |

> \* 这些参数将在近期版本中提供。  
> \** 并非所有演示训练方法都需要这些参数。

可以根据实际情况灵活调整上述参数配置。

---

## 监控训练进度

- 进入主导航中的 [模型训练](../user-guide/model-training.md) 页面
- 启动训练任务并查看实时进度
- 当任务进入 **已完成** 状态后，可以在 [定制模型](../user-guide/trained-models.md) 页面中查看结果

---

## 下一步操作

完成训练后，可以：

- 使用 [模型评估](../user-guide/model-assessment.md) 功能进行效果评估
- 在 [DeepPrompt](../user-guide/deep-prompt.md) 中运行推理
- 保存并部署模型

---

*DeepExtension —— 快速上手，全面掌控。*
