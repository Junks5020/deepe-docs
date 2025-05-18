
# Training Method Management

The **Training Method Management** module allows you to configure and register custom fine-tuning strategies 
used in DeepExtension. These strategies are selectable in [Model Training](model-training.md) and define how 
base models are adapted to domain-specific tasks.

Supported method types include:

- **SFT** (Supervised Fine-Tuning)
<!-- - **DPO** (Direct Preference Optimization) -->
- **PEFT** (Parameter-Efficient Fine-Tuning, e.g., LoRA, adapters)
- **PPO**, **GRPO**, and other reinforcement-based methods

---

## Overview

On the main **Training Methods** page, you can see a list of all currently registered training methods. 
These are the entries available for selection when creating a new job in the [Model 
Training](model-training.md) interface.

If you are a developer or infrastructure maintainer, refer to the **Developer Guide** for instructions on 
how to implement your own training logic and link it to the DeepExtension platform.

---

## Add a New Training Method

To register a new method:

1. Click **"Add a New"**
2. Fill in required details such as:
   - Internal Name
   - Display Name
   - Method Type (e.g., SFT, PEFT)
   - Description
   - Configuration Options (if applicable)

> **Note**: Adding new training methods is available **only for commercial users**.

> Noncommercial users are encouraged to modify and use the built-in `custom01` and `custom02` methods, which 
are fully customizable and serve as templates. See the **Developer Guide** for implementation details.

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

### For Ubuntu (CUDA) Users

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

