
# Base Models

**Base Models** refer to pretrained foundation models that are manually loaded into the DeepExtension environment and 
serve as the starting point for fine-tuning and inference. These models form the backbone of your LLM development 
pipeline.

> **Note**: Adding a base model is required before you can initiate training or perform fine-tuning in DeepExtension. We classify this as a **developer task** since it requires access to the backend file system — typically only **admin users** have the necessary permissions.  
> See [How to Add Base Models](../developer/how-to-add-base-models.md) for step-by-step guidance.

---

## Overview

On the main **Base Models** page, you’ll see a list of all currently loaded base models. Each base model entry includes:

- **Technical Name**: A short, unique identifier used internally. This is critical for naming trained models (see 
[Trained Models](trained-models.md) for naming rules).
- **Model Name**: The full official name of the model (e.g., "Qwen-1.5-7B", "LLaMA2-13B").
- **Path**: A relative path to the directory where the model is saved locally.
- **Model Card Info**: Additional technical details automatically extracted from a `*.json` file located in the model 
folder during registration.

> Both **Technical Name** and **Model Name** must be unique across the entire system.

---

## Add a New Base Model

To register a new base model:

1. Click **"Add a New"** on the Base Models page.
2. Provide the following information:

    - **Technical Name** (must be unique and concise)
    - **Model Name** (full descriptive name)
    - **Model Path** (relative path to the local model folder)
    - **Model Deployment Template** *(optional)*: Text block used as part of the **Modelfile** when deploying saved models using **Ollama**
  

Once saved, DeepExtension will attempt to load metadata and configuration details from the model directory, forming a **model card** that can be reused by training or inference workflows.

> You are responsible for ensuring the model files are fully and correctly placed in the target path.

---

### Notes on Deployment Template

- The **Template for Model Deployment** is only required when deploying models using **Ollama**. If you do not plan to use Ollama, you may leave this field blank.
- You can always update this field later by clicking **"Update Deployment Template File"** on the Base Models page.
- For more information about what a Modelfile is, what the **Template for Model Deployment** refers to, and how to prepare one, please refer to the developer guide: [How to Add Base Models](../../developer/how-to-add-base-models)

---

## Base Model Behavior

- Base models must be **manually downloaded and stored locally** before registration.
- Online model fetching (e.g., from HuggingFace or other public hubs) is **not currently supported**.
- Remote integration for auto-fetching is planned for a future update and is on our development roadmap.

---

*DeepExtension — Ground your AI workflows on reliable, local foundation models*
