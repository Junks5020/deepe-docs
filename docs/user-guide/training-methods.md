# Training Method Management

The **Training Method Management** module allows for the registration and configuration of large language model fine-tuning strategies within DeepExtension. These strategies can be selected in the [Model Training](model-training.md) module and define how base models are adapted for specific domain tasks.

Supported training method types include:

*   **SFT** (Supervised Fine-Tuning)
*   **PEFT** (Parameter-Efficient Fine-Tuning, e.g., LoRA, Adapters)
*   **PPO**, **GRPO**, and other reinforcement learning-based methods
*   **VL** Training for vision-language models
*   **SD** Training for image generation models, implemented using the open-source SimpleTuner framework.

---

## Overview

The **Training Method Management** list on the main page displays all registered training methods. These methods will be available for selection in the [Model Training](model-training.md) interface when creating a new training task.

If you are a developer or platform maintainer, please refer to the **Developer Guide** for instructions on implementing your own training logic and integrating it into the DeepExtension platform.

---

## Adding a New Training Method

This section describes the complete process for adding a new training method to the system.

### Procedure

1.  Click the **"Add New Method"** button in the interface.
2.  Fill in the following required information in the pop-up form:

### Configuration Field Descriptions

#### Basic Information
*   **Training Name**: Assign a unique identifier for the new training method.
*   **Training Type**: Select the corresponding training type from the dropdown list:
    *   `chat`: Plain text dialogue model training
    *   `embedding`: Text parsing model training
    *   `vision-language`: Vision-to-language multimodal model training
    *   `image-generation`: Image generation model training

#### Lifecycle Configuration
*   **Lifecycle**: Select the model's lifecycle path.
    *   *For detailed explanations, please refer to: [Model Lifecycle Management](../tutorials/tutorial-process-dependency.md)*
    *   **Configuration requirements corresponding to different lifecycle options:**

| Lifecycle Option | Mandatory Configurations | Optional Configurations |
| :--------------- | :----------------------- | :---------------------- |
| **Customized Model** | Training code file, Training environment | Customized Model Inference Function<br>• If enabled, requires: Inference code file, Conda environment name |
| **Complete Model**   | Saving code file, Training environment | Complete Model Inference Function<br>• If enabled, requires: Inference code file, Conda environment name |
| **Live Model**     | Deployment environment selection | • Custom deployment environment requires: Deployment environment code file, Conda environment name |

#### Python File Configuration
Configure the actual Python files and execution environments for each stage:

*   **`training`**: Python file and Conda environment used for the training stage.
*   **`saving`**: Python file and Conda environment used for the model saving stage.
*   **`inference-customized`**: Python file and Conda environment used for Customized Model inference.
*   **`inference-complete`**: Python file and Conda environment used for Complete Model inference.

**Tips**: Fields marked with * are mandatory. Please complete the file configurations for the corresponding stages based on the selected lifecycle path.

> **Note**: Adding new training methods is available **only for commercial users**.
> Noncommercial users are encouraged to modify and use the built-in `custom01` and `custom02` methods, which are fully customizable and serve as templates. See the **Developer Guide** for implementation details.

---

## Delete an Existing Training Method

To remove a method:

- Click **"Delete"** on the desired training method
- This method will no longer be selectable in the [Model Training](model-training.md) interface

> **Note**: Deletion is restricted to **commercial users** to protect stability and integrity of 
preconfigured workflows.

---

## Pre-installed Training Methods

To help users get started quickly, DeepExtension provides several **pre-installed training methods** based on your operating environment.

### CUDA（Linux or Windows via WSL) Users

- **GRPO-Demo**: A ready-to-use GRPO (Guided Reinforcement with Prompt Optimization) method for logic-aligned fine-tuning
- **SFT-Demo**: A supervised fine-tuning example suitable for small-scale tasks
- **Custom01** and **Custom02**: Fully customizable templates that developers can extend for their own training logic

### For macOS Users (with MLX)

- **MLX-Demo**: A demonstration training method using Apple’s MLX framework, optimized for M-series chips
- **Custom01** and **Custom02**: Same customizable templates for developers

> GRPO-Demo, SFT-Demo, and MLX-Demo are fully configured and come with sample datasets to help you try out DeepExtension’s training features immediately.

> **Custom01** and **Custom02** are designed to be extended by developers with AI or ML expertise.  
See [Implement Your Own Training](../developer/implement-own-ai-training.md) for step-by-step instructions on customizing your training logic.


---

*DeepExtension — Flexible fine-tuning starts with flexible training strategy management*

