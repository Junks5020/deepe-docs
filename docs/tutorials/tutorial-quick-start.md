# Quick Start: Run Your First Training

DeepExtension makes it easy to launch your first model training job through a fully visual interface — no coding required.

Depending on your system’s AI platform, we provide preinstalled demo training methods to help you get started.

---

## Available Demo Training Methods

### For Ubuntu (CUDA) Users

- **GRPO-Demo**: A ready-to-use GRPO (Guided Reinforcement with Prompt Optimization) method for logic-aligned fine-tuning.
- **SFT-Demo**: A supervised fine-tuning example suitable for small-scale tasks.

### For macOS Users (Apple Silicon with MLX)

- **MLX-Demo**: A demonstration training method using Apple’s MLX framework, optimized for M-series chips.

---

## Before You Start

As outlined in [Process Dependency](tutorial-process-dependency.md), make sure the following components are ready:

- A **base model** has been added
- A **dataset** is available
- A demo **training method** (already preinstalled)

We recommend trying one of the following example datasets:

- `grpo-demo-train-dataset.jsonl`
- `sft-demo-train-dataset.jsonl`
- [`mlx-demo-train-dataset.jsonl`](../assets/datasets/mlx-demo-train-dataset.jsonl)

You can also use your own dataset, but please ensure the structure matches one of the examples (i.e., it includes the same fields).

---

## Suggested Parameters for Demo Training

Below is a minimal parameter configuration that works reliably for all demo training methods:

| **Parameter Name**        | **Description**                                      | **Recommended Value**         |
|---------------------------|------------------------------------------------------|--------------------------------|
| Base Model / MODEL_PATH   | Foundation model for fine-tuning                     | `Qwen2.5-1.5B`                 |
| Dataset / DATASET_PATH    | Dataset to be used                                   | `demo-dataset`                |
| LORA_RANK                 | LoRA adapter rank                                    | `8`                            |
| LOAD_IN_4BIT              | Enable 4-bit quantization                            | `true`                         |
| MAX_SEQ_LENGTH            | Max sequence length                                  | `1024`                         |
| MAX_INPUT_LENGTH          | Max input length                                     | `1024`                         |
| MAX_CONTENT_LENGTH        | Max content length                                   | `1024`                         |
| MAX_SAMPLES               | Max number of training samples                       | `1000`                         |
| NUM_GENERATIONS           | Generations per batch                                | `2`                            |
| MAX_GRAD_NORM             | Gradient clipping norm                               | `0.5`                          |
| EPOCHS                    | Number of training epochs                            | `1`                            |
| MAX_STEPS                 | Max training steps                                   | `10`                           |
| BATCH_SIZE                | Training batch size                                  | `2`                            |
| GRAD_ACCUM_STEPS          | Gradient accumulation steps                          | `2`                            |
| LEARNING_RATE             | Initial learning rate                                | `2e-5`                         |
| WARMUP_STEPS              | Warmup steps                                         | `2`                            |
| WARMUP_RATIO              | Warmup ratio (alternative to warmup steps)           | `0.01`                         |
| OUTPUT_DIR                | Output directory                                     | System auto-generated          |
| PromptInputColumn         | Input prompt field name                              | `input`                        |
| PromptOutputColumn        | Output/response field name                           | `input`                        |

You can fine-tune these parameters later as you gain more experience.

---

## Monitor Progress

- Go to [Model Training](../user-guide/model-training.md) in the main navigation.
- Launch the job and track its progress.
- Once the job reaches the **Completed** state, the output will appear under [Trained Models](../user-guide/trained-models.md).

---

## Next Step

From here, you can:

- Evaluate the trained model using [Model Assessment](../user-guide/model-assessment.md)
- Run inference in [DeepPrompt](../user-guide/deep-prompt.md)
- Save and deploy your model

---

*DeepExtension — Fast start, full control.*
