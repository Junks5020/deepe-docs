
# Add Base Models

Adding a base model is required before you can initiate training or perform fine-tuning in DeepExtension. We classify this as a **developer task** since it requires access to the backend file system — typically only **admin users** have the necessary permissions.

This guide walks you through the process of registering a model such as `Qwen2.5-7B-Instruct` and making it available for training within DeepExtension.

---

## Step 1: Download the Model Files

To take model files from Hugging Face as an example, use a search engine and look for:

```
huggingface qwen2 5 7b instruct
```

You will likely find the official page for `Qwen/Qwen2.5-7B-Instruct`. Under the **"Files and versions"** tab (ensure version = `main`), download all files containing:

- `config.json`
- One or more `*.safetensors` model weight files
- `tokenizer.json`, `tokenizer_config.json`, etc.

Create a local directory named:

```
Qwen2.5-7B-Instruct
```

and save all the files inside.

---

## Step 2: Move to the DeepExtension Models Directory

Assume `{deepextension_base_dir}` is the root directory of your DeepExtension installation. Inside it, there should be a folder named `models`.

Move your model directory into that location:

```
{deepextension_base_dir}/models/Qwen2.5-7B-Instruct
```

This directory path will later be referenced as the **Model Path**.

---

## Step 3 (Optional): Get Deployment Template (For Ollama)

If you plan to deploy the saved model via **Ollama**, you also need to provide a **Model Deployment Template**.

1. Search online:
   ```
   ollama modelfile qwen2 5 7b instruct
   ```
2. Locate the official Ollama model page (e.g., for `qwen2.5:7b-instruct`)
3. Click on the **template** link
4. Copy the template content and save it for the next step

> If you don’t plan to deploy via Ollama, this step is not required.

---

## Step 4: Register the Base Model in DeepExtension

Go to the **Base Models** page in the DeepExtension Web UI and click **"Add a New"**.

Fill in the following fields:

| Field                   | Example Value                  | Notes                                                         |
|------------------------|---------------------------------|---------------------------------------------------------------|
| Technical Name         | `qw2.5-7-i`                     | Must be short and unique                                      |
| Model Name             | `Qwen2.5-7B-Instruct`           | Descriptive, full name                                        |
| Model Path             | `./models/Qwen2.5-7B-Instruct`  | Path must match the directory in Step 2                       |
| Deployment Template    | *(Paste from Step 3)*           | Required only for Ollama deployment                          |

> You can leave the **Deployment Template** field empty and fill it later using **"Update Deployment Template File"**.

---

## Step 5: Confirm Registration

Return to the **Base Models** main page and refresh. Your model should now be listed.

You should also see:

- Disk usage (approx. **14GB** for Qwen2.5-7B-Instruct)
- Model metadata and a generated **Model Card**

You’re done! The base model is now available for fine-tuning, evaluation, and deployment.

---

For further help with deployment templates and Ollama setup, see:

- [Base Models](../user-guide/base-models.md)  
- [Deployment Tool Configuration](../user-guide/deployment-tool-configuration.md)  

