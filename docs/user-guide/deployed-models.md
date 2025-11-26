
# Live Models

**Live Models** are fully merged and quantized models that have been actively launched via a local LLM 
deployment tool (currently **Ollama**). Once Live, these models behave exactly like base models and can serve real-time 
inference requests or be integrated into downstream applications.

---

## Overview

The **Live Models** page displays all successfully Live models, each with associated metadata.

Each model entry includes:

- **Auto-Generated Name**: Follows the naming convention:

```
[live_model_name] = [complete_model_name]_d_[first4ofDeployingUUID]_[quant_type]
```

- **Deployment Status**
- **Linked Deployment Tool** (e.g., Ollama, LMStudio)
- **Model Card**: Displays configuration metadata inherited from the complete model and deployment process

> Live models are locally served by external tools and must be registered separately if you want to 
use them in workflows like DeepExtend or Model Assessment.

---

## Register as Third-party Model

To use a Live model across DeepExtension modules:

1. Click **"Register"** on the Live model entry
2. The model will be added to the [Third-party Models](thirdparty-models.md) list.

> Requires integration with a compatible LLM deployment backend (e.g., Ollama or LMStudio)

---

## Delete a Live Model

To undeploy and remove a model from your LLM runtime:

1. Click **"Delete"** on the Live model entry
2. This will instruct the backend deployment tool to remove the model from active service

> This does **not** affect its entry in [Third-party Models](thirdparty-models.md) if previously 
registered.

> Deletion actions also require a valid connection to your external deployment system

---

*DeepExtension — Operationalize your fine-tuned models with streamlined deployment and registration*

