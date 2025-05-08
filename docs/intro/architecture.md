# System Architecture

DeepExtension is designed as a modular, scalable, and enterprise-grade platform for managing the full lifecycle of AI model development—from data preparation to deployment. This document provides a high-level overview of its architecture.

---

## 🏗️ Overview

At a glance, DeepExtension consists of the following key layers:


---

## 🖥️ 1. User Interfaces

- **Web-based UI** (Self-hosted): The primary interface for most users.
- **RESTful API**: For programmatic access, CI/CD integration, or automation.

---

## ⚙️ 2. Application Layer

This layer powers the user experience and handles:

- **User & Project Management**
- **Task Scheduling** (training, evaluation, fine-tuning)
- **Model Lifecycle**: for tracking versions, performance, and usage
- **Data Versioning**: Supports incremental, labeled datasets
- **Evaluation Tools**: Includes benchmarks, JSON validators, business-rule testers
- **Security**: RBAC, token auth, audit logs


---

## 🧠 3. Core AI Layer

This is where DeepExtension becomes AI-specialized:

- **GRPO Engine**: Custom reinforcement learning logic with prompt tuning
- **Training Job Orchestrator**: Manages LLM fine-tuning tasks
- **Customizable Training Logic**: Bring your own training code in almost any form—make slight adjustments and DeepExtension will execute, track, and monitor it seamlessly

---

## 🧰 4. Infrastructure Layer

Runs the compute and storage:

- **CUDA GPU Support** on Ubuntu for training and inference
- **Local macOS Support** for development and preview
- **Docker Compose**: Manages services (database, vector store, API, UI)
- **Storage Backends**:

  - **File Storage**: For managing raw datasets, model checkpoints, and artifacts  
  - **Vector Databases**: For storing and querying embeddings (e.g., for semantic search or RAG)  
  - **Relational Databases (e.g., PostgreSQL)**: For storing metadata, configurations, and training records


---

## 🔗 Integrations

DeepExtension supports integrations with:

- **LLM Providers**: OpenAI, Qwen, Claude, SiliconFlow, etc.
- **Local Model Tools**: Works smoothly with tools like **LM Studio**, **Ollama**, and others for local model experimentation and serving
<!-- - **Vector Databases** -->

---

## 🔐 Security Features

- Role-based access control (RBAC)
- Project-level permission scopes
- Action logging and traceability
- Option for air-gapped deployment

---

## 📦 Deployment Options

| Target Environment | Description                            |
|--------------------|----------------------------------------|
| `Ubuntu + CUDA`    | Optimized for high-performance training |
| `macOS` (Dev)      | Runs via Docker (currently for local use and study only) |
| `Self-hosted SaaS` | Full deployment for internal or external use |

---

## 🚀 Summary

DeepExtension is engineered to be adaptable for both experimental R&D and mission-critical enterprise deployments. Its layered architecture makes it easy to integrate with existing AI stacks while giving you complete control over your model workflows.

