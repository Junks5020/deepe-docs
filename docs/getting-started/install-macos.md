
# 🛠️ Install DeepExtension on macOS (Local Dev)

This guide explains how to install and run **DeepExtension** locally on a macOS machine using Docker. This setup is intended for 
development, evaluation, or educational purposes (not GPU training).

---

## ✅ System Requirements

- **OS**: macOS 12+ (Monterey or newer recommended)
- **CPU**: Apple Silicon (M1/M2) or Intel
- **Memory**: At least 16GB RAM
- **Disk Space**: 20GB+ free
- **Docker Desktop**: Required
- **Internet Access**: Required for downloading containers

---

## 📦 1. Install Prerequisites

### Docker

Install Docker Desktop for macOS from:  
https://www.docker.com/products/docker-desktop/

After installation, launch Docker and verify that it's running.

---

## 📁 2. Clone DeepExtension Repository

Clone the DeepExtension source code repository and navigate into the project directory.

> Replace the URL with your private repo if applicable.

---

## 🧱 3. Configure Environment

Copy the sample environment file and adjust settings:

- `DEPLOY_MODE=macos`
- `DEEP_DB_PASSWORD`
- `ADMIN_EMAIL`

---

## 🚀 4. Start DeepExtension with Docker Compose

Run the macOS-compatible Docker Compose configuration:

Verify all services are running correctly, then open your browser and visit:

```
http://localhost:8080
```

---

## 🧪 5. First-Time Setup

- Register an admin user  
- Create a new project  
- Upload a test dataset (CSV, JSON, or JSONL)  
- Optionally trigger a small training job (CPU-only)

---

## 🧼 6. Stop or Remove

Stop all containers when you're done or remove them for a clean slate.

---

## 🆘 Troubleshooting

- **Docker not starting**: Restart Docker Desktop or your system  
- **UI not loading**: Ensure services are up via `docker ps`  
- **Permission issues**: Make sure your user has Docker access

---

## 📘 Next Steps

- Continue with the [Quick Start Guide](quick-start.md)
- Try out the [Tutorials](../tutorials/e2e.md)
- Visit the [Developer Guide](../developer/api-overview.md)

---

*DeepExtension — Extend AI Capabilities for Enterprises*

