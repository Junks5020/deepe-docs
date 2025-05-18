
# 还在改进中, 展示不要review

# Install DeepExtension on Ubuntu (CUDA)

This guide walks you through installing **DeepExtension** on an Ubuntu system with **GPU acceleration (CUDA)**. It covers prerequisites, Docker setup, and how to run DeepExtension using Docker Compose.

---

## System Requirements

- **OS**: Ubuntu 20.04 or 22.04 (recommended)
- **GPU**: NVIDIA GPU with CUDA Compute Capability 6.0+
- **Memory**: At least 16GB RAM (32GB+ recommended for training)
- **Disk Space**: 50GB+ free
- **Internet Access**: Required for pulling containers
- **User Permissions**: Sudo privileges

---

## 1. Install Docker & NVIDIA Container Toolkit

### Step 1.1: Install Docker

```bash
sudo apt update
sudo apt install -y docker.io docker-compose
sudo systemctl enable --now docker
```

### Step 1.2: Add Your User to Docker Group

```bash
sudo usermod -aG docker $USER
newgrp docker
```

### Step 1.3: Install NVIDIA Container Toolkit

```bash
# Add NVIDIA package repositories
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/libnvidia-container/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

# Install NVIDIA Docker runtime
sudo apt update
sudo apt install -y nvidia-docker2
sudo systemctl restart docker
```

---

## 2. Verify GPU Access in Docker

Test if Docker can see your GPU:

```bash
docker run --rm --gpus all nvidia/cuda:12.2.0-base-ubuntu20.04 nvidia-smi
```

Expected output: your GPU information table.

---

## 3. Clone DeepExtension Repository

```bash
git clone https://github.com/your-org/deepextension.git
cd deepextension
```

> Replace with your private repo URL if applicable.

---

## 4. Configure Environment

Copy and edit the `.env` file:

```bash
cp .env.example .env
nano .env
```

Key settings to review:
- `DEEP_DB_PASSWORD`
- `ADMIN_EMAIL`
- `DEPLOY_MODE=ubuntu-gpu`

---

## 5. Start DeepExtension with Docker Compose

```bash
docker compose -f docker-compose.ubuntu.gpu.yml up -d
```

Check running services:

```bash
docker ps
```

Access the UI in your browser:

```
http://localhost:8080
```

---

## 6. First-Time Setup

- Register the first admin user via the UI
- Create a project and upload a sample dataset
- Optionally, test GPU-based training

---

## 7. Stop or Remove

To stop:

```bash
docker compose -f docker-compose.ubuntu.gpu.yml down
```

To remove all volumes (if needed):

```bash
docker compose -f docker-compose.ubuntu.gpu.yml down -v
```

---

## Troubleshooting

- **"nvidia-smi not found"**: Ensure host has NVIDIA driver and CUDA installed
- **Permission denied**: Add your user to `docker` group (`sudo usermod -aG docker $USER`)
- **Web UI not loading**: Check `docker logs` and confirm all services are up

---

## Next Steps

- Continue with the [Quick Start Guide](quick-start.md)
- Read the [System Requirements](system-reqs.md)
- See [Developer Guide](../developer/api-overview.md) if integrating training logic

---

*DeepExtension — Build Enterprise AI with Clarity and Control*
