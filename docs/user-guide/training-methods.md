
# ⚙️ Training Method Management

The **Training Method Management** module allows you to configure and register custom fine-tuning strategies 
used in DeepExtension. These strategies are selectable in [Model Training](model-training.md) and define how 
base models are adapted to domain-specific tasks.

Supported method types include:

- **SFT** (Supervised Fine-Tuning)
<!-- - **DPO** (Direct Preference Optimization) -->
- **PEFT** (Parameter-Efficient Fine-Tuning, e.g., LoRA, adapters)
- **PPO**, **GRPO**, and other reinforcement-based methods

---

## 📋 Overview

On the main **Training Methods** page, you can see a list of all currently registered training methods. 
These are the entries available for selection when creating a new job in the [Model 
Training](model-training.md) interface.

If you are a developer or infrastructure maintainer, refer to the **Developer Guide** for instructions on 
how to implement your own training logic and link it to the DeepExtension platform.

---

## ➕ Add a New Training Method

To register a new method:

1. Click **"Add a New"**
2. Fill in required details such as:
   - Internal Name
   - Display Name
   - Method Type (e.g., SFT, PEFT)
   - Description
   - Configuration Options (if applicable)

> ⚠️ **Note**: Adding new training methods is available **only for commercial users**.

> Noncommercial users are encouraged to modify and use the built-in `custom01` and `custom02` methods, which 
are fully customizable and serve as templates. See the **Developer Guide** for implementation details.

---

## 🗑️ Delete an Existing Training Method

To remove a method:

- Click **"Delete"** on the desired training method
- This method will no longer be selectable in the [Model Training](model-training.md) interface

> ⚠️ **Note**: Deletion is restricted to **commercial users** to protect stability and integrity of 
preconfigured workflows.

---

*DeepExtension — Flexible fine-tuning starts with flexible training strategy management*

