# UI Overview

Welcome to the **DeepExtension User Interface (UI)** — a web-based, modular workspace designed for both domain experts and AI developers to 
collaborate seamlessly throughout the model development lifecycle.

This section provides a practical overview of all key UI components and how they work together to enable end-to-end AI workflows without 
requiring users to write code.

---

## What You'll Find in This Section

The **User Guide** is organized by feature areas of the DeepExtension interface. It helps you understand what each part of the UI does and how 
to use it effectively:

### Dashboard
Get a real-time overview of active projects, training jobs, model deployments, usage stats, and recent activity — all in one glance. The dashboard includes:

- **Core Data Statistics Overview**: Centralized display of key metrics across models, datasets, knowledge bases, and evaluations
- **Fine-tuning Task Panel**: Bar chart visualization of model training task distribution by type
- **Base Model Distribution**: Donut chart showing proportion of base models in Customized Modelss
- **Model Assessment Analysis**: Area chart displaying evaluation mode distribution across assessment tasks
- **Third-party Model Ecosystem**: Donut chart visualizing vendor distribution and type占比 of third-party models

### DeepExtend
Uses structured prompt templates to guide LLM behavior, making it ideal for business logic alignment and building repeatable AI tasks. It primarily supports reasoning for both text and images.

#### DeepPrompt
Compared to traditional prompt workbenches, **DeepPrompt** offers deeper integration capabilities with data and models, enabling users to:

- Directly embed and reference document-based knowledge in prompts
- Perform inference directly on **adapters or PEFT checkpoints from the training phase**
- Accelerate evaluation cycles by simulating production behavior using partial training results

#### DeepImage
Compared to traditional image generation tools, **DeepImage** provides more flexible and powerful image synthesis capabilities, allowing users to:

- Generate images in **any aspect ratio and size** to fit diverse application scenarios
- Produce **multiple images in a single operation** to enhance creative efficiency
- Achieve creative editing and style transfer through **image-to-image generation**
- Exercise **fine-grained control** over generation parameters for customized results
- Utilize **pre-trained models and custom checkpoints** to accomplish specialized visual tasks

### Dataset Management
Upload, version, label, and organize datasets. Supports multiple formats like JSONL, and JSON.

### Knowledge Base (RAG)
Embed large-scale documents for retrieval-augmented generation (RAG) use cases. Supports knowledge base creation and indexing.


### Model Training
Trigger training jobs using base models, fine-tuning methods (e.g., **SFT**, **GRPO**), with or without parameter-efficient techniques like **LoRA**, and customizable hyperparameters. All training tasks are fully UI-driven — no coding required.

Additionally, this section also supports the configuration of model training methods and the setup of model training parameter files.

Highlights include:

- **"Copy Train"** button: Instantly duplicate a previous training job, preserving all configurations. Change only a few parameters (e.g., base model, dataset, LoRA rank, learning rate) to create a comparable variation.
- **Real-time training logs and evaluation data**: Loss curves, reward points, and key metrics are fully visualized, making model progress transparent.
- **Multi-training comparison**: Select multiple training runs and compare them side by side with one click — including performance, configuration, input and output differences.


### Model Assessment

DeepExtension provides a powerful, **batch-oriented model evaluation framework** designed to help you compare model outputs at scale using real datasets.

Key capabilities include:

- Assessment is based on **questions sampled directly from your datasets**
- Four flexible evaluation modes
- Each assessment job includes a **preview stage** to verify setup (model, dataset, measurement prompt, etc.)
- Execution is done in **background mode**, allowing large-scale evaluations
- Results are fully viewable in the UI and can also be **exported as local files**
- **Any model can be used** — including third-party APIs, local adapters at any training stage, or fully deployed in-house models

This system helps teams confidently compare fine-tuned models, judge alignment quality, and standardize LLM output evaluation.


### Model Management
Track every model in your organization through the following subcategories:

- **Third-party Models**: External models you’ve linked (e.g., OpenAI, Anthropic, ModelScope, etc.)
- **Base Models**: Pretrained foundation models available for use or fine-tuning
- **Customized Models**: Outputs from the training process, typically PEFT adapters or checkpoints that are linked to a base model (also called as training artifact). These represent models in their intermediate form before merging.
- **Complete Models**: Fully materialized models created by merging trained adapters into base models. These are independent and versioned snapshots, ready for deployment or further experimentation.
- **Live Models**: Fully merged models that are actively served via API or integrated into internal tools. Once deployed, they function identically to base models and are ready for real-time inference or application integration.

Each model type reflects a stage in the **training lifecycle** — from raw training output to production-grade deployment.  
The UI provides **one-click actions** to move models forward through this lifecycle:
- Convert a **Customized Models** into a **Complete Models**
- Deploy a **Customized Models** as a **Live Models**
- Deploy a **Complete Models** as a **Live Models**

- Delete models at any stage if they’re no longer needed

This structure gives users full control over versioning, promotion, and cleanup, ensuring that only valuable models progress while maintaining a clear and auditable lifecycle.

### Settings

- **Compute Environment Configuration**: Configure and define the Python environment.
- **Deployment Tool Configuration**: Maintain integration settings for deployment tools.  
  Currently, only **Ollama** is supported. When deploying a Complete Models, the system uses this configuration to connect with your local Ollama environment. More local LLM serving tools such as **LM Studio** are planned for future support.
- **User Management**: Manage team members, permissions, and access control across projects

---

## Who Should Use This

This guide is ideal for:

- **Domain Experts** who want to train and evaluate models without coding
- **Data Scientists / ML Engineers** configuring custom training and evaluation flows
- **Project Managers** overseeing AI workflows, security, and deployment status

---

## Next Steps

You can continue with the following chapters for more detail:

<!-- - [UI Dashboard](ui-dashboard.md)   -->
- [DeepPrompt](deep-prompt.md)  
- [Model Training](model-training.md)  
- [Dataset Management](dataset-management.md)  
- [Document Embedding](document-embedding.md)  
- [Model Assessment](model-assessment.md)  
- [Model Management](thirdparty-models.md)  
- [Settings](deployment-tool-configuration.md)

---

*DeepExtension — A unified workspace for real-world AI workflows*

