
# 🌐 Thirdparty Models

**Thirdparty Models** refer to external models integrated into DeepExtension — including services like **OpenAI**, 
**Anthropic**, **ModelScope**, or even locally deployed models accessible via API. These models are essential components 
of DeepExtension workflows and can be used for inference, evaluation, and embedding.

---

## 🔗 Why Thirdparty Models Matter

Thirdparty models are deeply integrated into the DeepExtension ecosystem:

- In **DeepPrompt**, you can:
  - Compare your fine-tuned models or local adapters against public APIs like GPT-4
  - Test how external models interact with your **knowledge base** or **system prompts**

- In **Document Embedding**, an **embedding model** must be registered as a thirdparty model to support vectorization of 
uploaded documents.

- In **Model Assessment**, you can use any thirdparty model as a **candidate** or **judge** — enabling rich benchmarking 
and evaluation scenarios.

> 💡 Even locally deployed models (e.g., those running on LAN or containerized endpoints) must be registered as 
thirdparty models since DeepExtension itself does not host or serve models directly.

---

## ➕ Add a New Model

To add a new thirdparty model:

1. Click **"Add a New Model"**
2. Fill in the following parameters:

| Field               | Description                                                                 |
|---------------------|-----------------------------------------------------------------------------|
| Provider            | The service provider (e.g., OpenAI, Anthropic, ModelScope, custom)          |
| Model Type          | Either `text` (for generation) or `embedding` (for vector output)           |
| Model Name          | Exact model name as defined by the provider (e.g., `gpt-4`, `text-embedding-ada-002`) |
| API Address         | The full API endpoint URL for the model                                     |
| API Key             | The authentication key or token used to access the model                    |
| Description         | Optional notes for documentation or usage guidance                          |
| Use Privately       | If enabled, the model is visible and usable **only to you** (default: No)   |

3. Click **"OK"** to add the model.
4. Click **"Test Connection"** to validate the setup.

---

## ✏️ Edit an Existing Model

To update a model:

1. Click **"Edit"** on the model you wish to change
2. You may modify:
   - API Address
   - API Key
   - Description
   - Privacy setting (toggle "Use Privately")

3. Save changes to apply updates immediately.

---

*DeepExtension — Integrate your models, wherever they live*

