
# 📂 Dataset Management

The **Dataset Management** module in DeepExtension provides a structured and version-controlled environment for uploading and organizing the training 
and evaluation data used across your AI workflows.

You can manage datasets in formats like **JSONL** and **JSON**, define their schema, and maintain clean records for traceability and reuse.

---

## 📥 Upload a Dataset

To upload a new dataset:

1. Click **"Upload a Dataset"** from the dataset page.  
2. Fill in the **dataset name** and **dataset description**.  
3. Click **"Upload"** to select a file in `.json` or `.jsonl` format from your local directory.  
4. After selecting the file, click **"Execute"** to start the upload. The upload runs in **batch mode**.  
5. Once complete, click **"View"** to inspect the uploaded dataset.  
6. If any error occurs, click **"Log"** to check the detailed error messages.

### ⚠️ Upload Requirements

Currently, only UTF-8 encoded `.json` or `.jsonl` files are supported. Please follow these format rules:

1. The file **must be encoded in UTF-8**.  
2. Each line must be a **valid JSON object** (for `.jsonl` files).  
3. All JSON objects must share the **same field names and field count** as the first line.  
4. Field values can be empty strings (`""`), but the fields must still be present.  
5. Each data entry (line) must be **under 4000 characters total**.  
6. **Blank lines and comment lines are not allowed**. The file should contain only clean JSON lines.

---

## 📑 Dataset Management Behavior

Each dataset upload creates a **new, separate dataset entry**.  
Version control is not yet available but is currently on the roadmap for future updates.

<!-- - Tracks version history for reproducibility  
- Allows you to **revert to earlier versions** if needed  
- Associates dataset versions with specific training jobs -->

---

## 🔄 Dataset Usage

Datasets can be used in:

- **Training jobs**: Paired with your chosen fine-tuning method  
- **Model Assessment** ([see details](model-assessment.md)):  
  Used as **input questions**, and if available, **reference answers** from the dataset can also be used by a judge model to assess inference quality or training effectiveness

---

*DeepExtension — Make your data structured, reusable, and ready for intelligent learning*

