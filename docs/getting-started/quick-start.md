# 还在改进中, 暂时不要review

# Quick Start Guide

Welcome to **DeepExtension** — your platform for fast, flexible, and guided domain-specific AI development.

This guide walks you through the basic steps to get up and running, whether you’re a domain expert using the UI or a developer looking to plug in custom training logic.

---

## Prerequisites

Before you begin, make sure you have the following:

- A working DeepExtension deployment:
  - Local (macOS/Linux with Docker)
  - Server-based (Ubuntu + CUDA)
  - Self-hosted (SaaS-style)
- Access to the web interface (usually at `http://localhost:8080` or your configured domain)
- A test dataset (CSV, JSONL, or JSON format)
- (Optional) Python environment if you're integrating custom training code

---

## Step 1: Log In & Create a Project

1. Open your browser and navigate to the DeepExtension web UI.
2. Log in using your admin or user credentials.
3. Click **"New Project"** and name it (e.g., `product-forecasting-v1`).
4. Choose your working language and domain (optional metadata).

---

## Step 2: Upload Your Dataset

1. Inside your project, go to **"Datasets"** → **"Upload Dataset"**.
2. Upload your training data:
   - Supported formats: `.csv`, `.json`, `.jsonl`
   - You can label columns or fields directly after upload
3. DeepExtension automatically tracks dataset versions

---

## Step 3: Define Training Configuration

1. Go to **"Training"** → **"New Training Job"**
2. Choose a base model:
   - e.g., `Qwen-1.5-7B`, `OpenLLM`, `Mistral`, or custom
3. Select a fine-tuning method:
   - Default: **LoRA (PEFT)**
   - Advanced: **SFT**, **GRPO**
4. Choose hyperparameters or stick with recommended defaults

---

## Step 4: Run Training Job

1. Click **"Start Training"**
2. Monitor progress in the **"Jobs"** dashboard
3. Training output will be saved as a model version linked to this project

---

## Step 5: Evaluate the Model

1. Go to **"Evaluation"**
2. Choose test inputs or upload an evaluation set
3. Use built-in scoring tools or define custom evaluation scripts (optional)
4. Use JSON schema validators, business rule checks, or manual review

---

## Step 6: Deploy the Model

1. Go to **"Deployment"** → **"Create Endpoint"**
2. Choose the model version to deploy
3. Set access control and rate limits
4. Deploy as:
   - API endpoint
   - Offline batch inference
   - Integration with internal apps

---

## (Optional) Developer Integration

- If you're an AI engineer:
  - Clone the SDK or use the Python API
  - Write custom training logic compatible with DeepExtension's interface
  - Register your script and test it in the UI

---

## Tips for Success

- Start with small, clean datasets
- Use **predefined templates and cases** for common business tasks
- Track model performance across multiple iterations
- Involve domain experts during evaluation

---

## Next Steps

- Explore the **User Guide** for details on UI and features
- Visit the **Developer Guide** if you're integrating training pipelines
- Browse **Tutorials** for real-world examples

---

*DeepExtension — Extend AI Capabilities for Enterprises*
