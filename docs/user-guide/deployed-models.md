
# Deployed Models

**Deployed Models** are fully merged and quantized models that have been actively launched via a local LLM 
deployment tool (currently **Ollama**). Once deployed, these models behave exactly like base models and can serve real-time 
inference requests or be integrated into downstream applications.

---

## Overview

The **Deployed Models** page displays all successfully deployed models, each with associated metadata.

Each model entry includes:

- **Auto-Generated Name**: Follows the naming convention:

```
[deployed_model_name] = [saved_model_name]_d_[first4ofDeployingUUID]_[quant_type]
```

- **Deployment Status**
- **Linked Deployment Tool** (e.g., Ollama, LMStudio)
- **Model Card**: Displays configuration metadata inherited from the saved model and deployment process

> Deployed models are locally served by external tools and must be registered separately if you want to 
use them in workflows like DeepPrompt or Model Assessment.

---

## Register as Thirdparty Model

To use a deployed model across DeepExtension modules:

1. Click **"Register"** on the deployed model entry
2. The model will be added to the [Thirdparty Models](thirdparty-models.md) list.

> Requires integration with a compatible LLM deployment backend (e.g., Ollama or LMStudio)

---

## Delete a Deployed Model

To undeploy and remove a model from your LLM runtime:

1. Click **"Delete"** on the deployed model entry
2. This will instruct the backend deployment tool to remove the model from active service

> This does **not** affect its entry in [Thirdparty Models](thirdparty-models.md) if previously 
registered.

> Deletion actions also require a valid connection to your external deployment system

---

*DeepExtension — Operationalize your fine-tuned models with streamlined deployment and registration*

