
# Customized Models

**Customized Models** are the outputs produced by DeepExtension's model training workflows — typically **PEFT adapters** or **checkpoints** 
that are still linked to their original base models. These intermediate artifacts represent models that have completed training but have 
not yet been merged into standalone full models.

---

## Overview

Customized models are automatically saved upon successful completion of a training job in [Model Training](model-training.md).

On the main **Customized Models** page, you will find a list of all stored adapter-based training results. Each entry includes:

- **Base Model Name**: Identifies which base model this adapter is built on
- **Train Name**: The name provided when the training job was submitted
- **Model Card**: Metadata extracted from the training configuration and evaluation summary
- **Auto-Generated Customized Model Name**: Formatted as:

```
[Customized_model_name] = [base_model_technical_name]_[train_name]_[YYYYMMDD]_[first4ofTrainingUUID]
```

> Currently, only **adapter-based artifacts** are stored at this stage — full checkpoints are not yet supported but may be added in 
future releases.

---

## Save a Customized Model

To promote a Customized model to a standalone **Saved Model**:

1. Click **"Save"** on the desired Customized model
2. Confirm the automatically generated parameters — no additional manual input is required  
3. Click **"OK"** to submit the saving job

The process runs in **background mode**, and once complete, the new model will appear in the [Complete Models](saved-models.md) section.

> **Note:** Quantization is **not supported** during the saving process for the following reasons:
>
> - There is currently **no standardized format** for quantized complete models.
> - Quantization can be more appropriately and flexibly applied **during the deployment** stage instead.

---
## Deploy a Customized Model

To make a Customized model available for real-time use:

1. Click **"Deploy"** on the desired Customized model
2. Provide any required extra parameters (e.g., quantization configuration, deployment environment)
3. DeepExtension will forward deployment requests to your configured LLM deployment tool 
4. Upon successful deployment, a new entry will appear under [Live Models](deployed-models.md)

> **Note:**
> 
> - Deployment requires prior integration with an external deployment backend. DeepExtension itself does **not** serve models.
> - To deploy via **Ollama**, a valid **Deployment Template File** is required. See [Base Models](base-models.md) for more details.
> - The **Deployment Environment** must be correctly configured. See [Deployment Tool Configuration](deployment-tool-configuration.md).
> - Currently, only the following quantization modes are supported: `no_quantization`, `q8_0`, `q4_K_M`, and `q4_K_S` — as these are the only options supported by the Ollama API.

---
## Delete a Customized Model

To remove a Customized model:

- Click **"Delete"** on the model entry
- This will permanently delete only the adapter or checkpoint file

> If this model was already saved as a full model in the [Complete Models](saved-models.md) section, that entry will remain unaffected.

---

## Customized Model Behavior

- Customized models are always **tied to their base models** and cannot operate independently until saved and merged
- The saved name format ensures traceability and version control
- Checkpoint-based training result saving is not yet available but under consideration for future support

---


*DeepExtension — Manage your training artifacts with precision and traceability*

