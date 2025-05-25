
# Trained Models

**Trained Models** are the outputs produced by DeepExtension's model training workflows — typically **PEFT adapters** or **checkpoints** 
that are still linked to their original base models. These intermediate artifacts represent models that have completed training but have 
not yet been merged into standalone full models.

---

## Overview

Trained models are automatically saved upon successful completion of a training job in [Model Training](model-training.md).

On the main **Trained Models** page, you will find a list of all stored adapter-based training results. Each entry includes:

- **Base Model Name**: Identifies which base model this adapter is built on
- **Train Name**: The name provided when the training job was submitted
- **Model Card**: Metadata extracted from the training configuration and evaluation summary
- **Auto-Generated Trained Model Name**: Formatted as:

```
[trained_model_name] = [base_model_technical_name]_[train_name]_[YYYYMMDD]_[first4ofTrainingUUID]
```

> Currently, only **adapter-based artifacts** are stored at this stage — full checkpoints are not yet supported but may be added in 
future releases.

---

## Save a Trained Model

To promote a trained model to a standalone **Saved Model**:

1. Click **"Save"** on the desired trained model
2. Confirm the automatically generated parameters — no additional manual input is required  
3. Click **"OK"** to submit the saving job

The process runs in **background mode**, and once complete, the new model will appear in the [Saved Models](saved-models.md) section.

> **Note:** Quantization is **not supported** during the saving process for the following reasons:
>
> - There is currently **no standardized format** for quantized saved models.
> - Quantization can be more appropriately and flexibly applied **during the deployment** stage instead.

---

## Delete a Trained Model

To remove a trained model:

- Click **"Delete"** on the model entry
- This will permanently delete only the adapter or checkpoint file

> If this model was already saved as a full model in the [Saved Models](saved-models.md) section, that entry will remain unaffected.

---

## Trained Model Behavior

- Trained models are always **tied to their base models** and cannot operate independently until saved and merged
- The saved name format ensures traceability and version control
- Checkpoint-based training result saving is not yet available but under consideration for future support

---


*DeepExtension — Manage your training artifacts with precision and traceability*

