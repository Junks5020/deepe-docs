# 🧭 UI Overview

Welcome to the **DeepExtension User Interface (UI)** — a web-based, modular workspace designed for both domain experts and AI developers to 
collaborate seamlessly throughout the model development lifecycle.

This section provides a practical overview of all key UI components and how they work together to enable end-to-end AI workflows without 
requiring users to write code.

---

## 🧱 What You'll Find in This Section

The **User Guide** is organized by feature areas of the DeepExtension interface. It helps you understand what each part of the UI does and how 
to use it effectively:

### 📊 Dashboard
Get a real-time overview of active projects, training jobs, model deployments, usage stats, and recent activity — all in one glance.

### 🎯 DeepPrompt
Use structured prompt templates to guide LLM behavior. Ideal for business logic alignment and creating repeatable AI actions.

Compared with traditional prompt playgrounds, **DeepPrompt** offers deeper integration with your data and models. It allows users to:

- Embed and reference document-based knowledge directly within prompts  
- Perform inference against **trained adapters or PEFT checkpoints**, even before merging them into the base model  
- Simulate production behavior with partial training results, accelerating evaluation cycles  


### 🧠 Model Training
Trigger training jobs using base models, fine-tuning methods (e.g., **LoRA**, **GRPO**), and customizable hyperparameters. All training tasks are fully UI-driven — no coding required.

Highlights include:

- **"Copy Train"** button: Instantly duplicate a previous training job, preserving all configurations. Change only a few parameters (e.g., base model, dataset, LoRA rank, learning rate) to create a comparable variation.
- **Real-time training logs and evaluation data**: Loss curves, reward points, and key metrics are fully visualized, making model progress transparent.
- **Multi-training comparison**: Select multiple training runs and compare them side by side with one click — including performance, configuration, input and output differences.


### 📂 Dataset Management
Upload, version, label, and organize datasets. Supports multiple formats like JSONL, and JSON.

### 📄 Document Embedding
Embed large-scale documents for retrieval-augmented generation (RAG) use cases. Supports knowledge base creation and indexing.

### 📈 Model Assessment

DeepExtension provides a powerful, **batch-oriented model evaluation framework** designed to help you compare model outputs at scale using real datasets.

Key capabilities include:

- Assessment is based on **questions sampled directly from your datasets**
- Four flexible evaluation modes
  <!-- - **Single Candidate**: Generate answers without judgment
  - **Two Candidates**: Generate answers from two models for side-by-side comparison
  - **1 Candidate + 1 Judge**: A judge model evaluates a single model's answer using predefined metrics
  - **2 Candidates + 1 Judge**: A judge model compares both answers and selects the better one, with scoring -->
- Each assessment job includes a **preview stage** to verify setup (model, dataset, measurement prompt, etc.)
- Execution is done in **batch mode**, allowing large-scale evaluations
- Results are fully viewable in the UI and can also be **exported as local files**
- **Any model can be used** — including third-party APIs, local adapters at any training stage, or fully deployed in-house models

This system helps teams confidently compare fine-tuned models, judge alignment quality, and standardize LLM output evaluation.


### 🗂️ Model Management
Track every model in your organization through the following subcategories:

- **Thirdparty Models**: External models you’ve linked (e.g., OpenAI, Anthropic, ModelScope, etc.)
- **Base Models**: Pretrained foundation models available for use or fine-tuning
- **Trained Models**: Outputs from the training process, typically PEFT adapters or checkpoints that are linked to a base model (also called as training artifact). These represent models in their intermediate form before merging.
- **Saved Models**: Fully materialized models created by merging trained adapters into base models. These are independent and versioned snapshots, ready for deployment or further experimentation.
- **Deployed Models**: Fully merged models that are actively served via API or integrated into internal tools. Once deployed, they function identically to base models and are ready for real-time inference or application integration.

Each model type reflects a stage in the **training lifecycle** — from raw training output to production-grade deployment.  
The UI provides **one-click actions** to move models forward through this lifecycle:
- Convert a **Trained Model** into a **Saved Model**
- Deploy a **Saved Model** as a **Deployed Model**
- Delete models at any stage if they’re no longer needed

This structure gives users full control over versioning, promotion, and cleanup, ensuring that only valuable models progress while maintaining a clear and auditable lifecycle.

### ⚙️ Settings

- **Training Method Management**: Configure and register custom fine-tuning strategies (e.g., SFT, PEFT)
- **User Management**: Manage team members, permissions, and access control across projects

---

## 🎯 Who Should Use This

This guide is ideal for:

- **Domain Experts** who want to train and evaluate models without coding
- **Data Scientists / ML Engineers** configuring custom training and evaluation flows
- **Project Managers** overseeing AI workflows, security, and deployment status

---

## 📘 Next Steps

You can continue with the following chapters for more detail:

<!-- - [UI Dashboard](ui-dashboard.md)   -->
- [DeepPrompt](deep-prompt.md)  
- [Model Training](model-training.md)  
- [Dataset Management](dataset-management.md)  
- [Document Embedding](document-embedding.md)  
- [Model Assessment](model-assessment.md)  
- [Model Management](trained-models.md)  
- [Settings](training-methods.md)

---

*DeepExtension — A unified workspace for real-world AI workflows*

