
# 💾 Saved Models

**Saved Models** are fully materialized models created by merging trained adapters into their corresponding 
base models. Once saved, these models are self-contained, versioned snapshots that can be independently 
deployed, evaluated, or reused.

---

## 📄 Overview

On the **Saved Models** page, you will find a list of all merged models that were successfully saved through 
the [Trained Models](trained-models.md) interface.

Each model entry includes:

- **Auto-Generated Name**: Created using the following format:

```
[saved_model_name]_s_[quant_type]_[first4ofUUID]
```

- **Quantization Info**: Specified during the save process
- **Model Card**: A structured summary of technical details, configurations, and metadata from both the base 
model and the training process

---

## 🚀 Deploy a Saved Model

To make a saved model available for real-time use:

1. Click **"Deploy"** on the desired saved model
2. DeepExtension will forward deployment requests to your configured LLM deployment tool (e.g., **Ollama**, 
**LMStudio**, or custom endpoints)
3. Upon successful deployment, a new entry will appear under [Deployed Models](deployed-models.md)

> ⚠️ Note: Deployment requires prior integration with an external deployment backend. DeepExtension itself 
does not serve models.

---

## 🗑️ Delete a Saved Model

To remove a saved model:

- Click **"Delete"** on the selected model
- This action will permanently delete the model directory from your local storage

> ❗ If the model was already deployed via the **Deploy** button, the deployment entry in [Deployed 
Models](deployed-models.md) will remain unaffected.

---

*DeepExtension — From training artifacts to deployable intelligence, all in one flow*

