# deepe_sd_series Deployment Tool

## Overview

The DeepExtension framework supports custom deployment platform integration. `deepe_sd_series` is an official standard custom inference container provided by the platform. Users can also  build their own deployment tools for rapid deployment of trained models.

This document describes the joint usage method of DeepExtension with `deepe_sd_series`.

## Use Cases

Although Ollama supports deployment of most mainstream models, some models still lack native support. To enhance usage flexibility, the system allows users to actively configure deployment environments and implement model deployment through specified inference code.

Currently, `deepe_sd_series` supports inference deployment for trained `stable-diffusion-3.5-medium` models.

## System Requirements

### Hardware Requirements
- GPU: NVIDIA GPU with 8GB+ VRAM (12GB+ recommended)
- RAM: 16GB+ RAM
- Storage: 50GB+ available space

### Software Requirements
- Docker: 20.10+
- NVIDIA Container Toolkit
- CUDA: 11.8+

## Installation Method

### 1. Environment Preparation
Ensure Docker and NVIDIA Container Toolkit are installed on your system:
```bash
# Verify Docker installation
docker --version

# Verify NVIDIA Container Toolkit
nvidia-ctk --version
```

### 2. Deployment Execution
Execute the `./sd_docker_run.sh` script from the GitHub repository to install and deploy:

```bash
# Add execution permissions
chmod +x ./sd_docker_run.sh

# Execute deployment script
./sd_docker_run.sh
```

### Script Content Details
The script includes the following steps:

```bash
# Build base image
docker build -f Dockerfile.base -t flux-base:latest --load .

# Build application image
DOCKER_BUILDKIT=0 docker build -t flux-app:latest .

# Run container
docker run -d --name flux_app_prod --gpus all -p 5051:5050 \
  -v /home/cicd/workspace/tongrui/fluxUse/flux_docker/flux_models:/app/flux_models \
  -v ./imageGeneration:/app/generated_images \
  -v ./flux_app/models_config.yaml:/app/models_config.yaml:rw \
  -v ./models:/app/models \
  -e CUDA_VISIBLE_DEVICES=0 -e PYTHONPATH=/app \
  flux-app:latest
```


## Configuration Guide

### Model Configuration File (models_config.yaml)
```yaml
models:
  - id: "stable-diffusion-3.5-medium"
    name: "Stable Diffusion 3.5 Medium"
    path: "/app/flux_models/stable_diffusion_3_5_medium"
    type: "text-to-image"
    enabled: true
    default_params:
      width: 1024
      height: 1024
      num_inference_steps: 28
```

### Environment Variables
- `CUDA_VISIBLE_DEVICES`: Specify GPU devices to use
- `PYTHONPATH`: Python path settings
- `MODEL_CACHE_DIR`: Model cache directory

## Usage Examples

### 1. Text-to-Image Call Example
```python
import requests
import json

url = "http://localhost:5051/text2image"
payload = {
    "prompt": "a beautiful sunset over mountains, digital art",
    "negative_prompt": "blurry, low quality",
    "width": 1024,
    "height": 1024,
    "num_inference_steps": 28,
    "guidance_scale": 3.5,
    "num_images": 1,
    "seed": 42
}

response = requests.post(url, json=payload)
task_id = response.json()["task_id"]
```

### 2. Query Task Status
```python
status_url = f"http://localhost:5051/task/{task_id}"
status_response = requests.get(status_url)
print(status_response.json())
```

## Troubleshooting

### Common Issues

1. **GPU Inaccessible**
   ```bash
   # Verify GPU access
   docker run --rm --gpus all nvidia/cuda:11.8-base nvidia-smi
   ```

2. **Port Conflict**
   - Ensure port 5051 is not occupied by other processes
   - Modify port mapping in script: `-p 5051:5050`

3. **Storage Permission Issues**
   - Ensure mounted directories have read-write permissions
   - Check Docker container access to mounted directories

4. **Model Loading Failure**
   - Verify model file paths are correct
   - Check model file integrity
   - Check container logs for detailed error information

### Log Viewing
```bash
# View container logs
docker logs flux_app_prod

# View logs in real-time
docker logs -f flux_app_prod
```

## Performance Optimization Recommendations

1. **GPU Memory Optimization**
   - Adjust image dimensions and batch size based on available VRAM
   - Use `CUDA_VISIBLE_DEVICES` to limit GPU usage

2. **Storage Optimization**
   - Use SSD storage to improve model loading speed
   - Regularly clean generated image files

3. **Network Optimization**
   - Consider enabling GPU passthrough for LAN deployments
   - Configure appropriate timeout parameters

## Important Notes

1. **Security Warnings**
   - Do not expose the service to the public internet without proper authentication
   - Regularly update base images to get security patches

2. **Resource Management**
   - Monitor GPU memory usage to avoid memory overflow
   - Set task queue limits to prevent system overload

3. **Data Persistence**
   - Regularly backup important data
   - Ensure data persistence configuration for mounted volumes

4. **Version Compatibility**
   - Ensure model versions are compatible with inference code
   - Pay attention to API interface backward compatibility during upgrades

## Technical Support

If you encounter problems, please:
1. Check container logs for detailed error information
2. Verify environment configuration meets requirements
3. Refer to the GitHub repository's Issues page
4. Contact the technical support team