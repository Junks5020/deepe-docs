# SD-Demo Implementation Guide

This document details the technical implementation of the built-in training method **SD-Demo** on the DeepExtension platform. This read-only example demonstrates how third-party training code integrates with the platform's workflow.

---

## Technical Architecture

### Implementation Foundation
**SD-Demo** is built upon the LoRA training module from the [SimpleTuner project](https://github.com/bghira/SimpleTuner.git). To ensure compatibility, we made the following adjustments to the specified commit version:
- Dependency version adaptation
- Entry script optimization
- Data interface standardization

[Get Adapted Version](../assets/datasets/SimpleTuner.zip)

---

## Environment Configuration

### Resource Preparation
#### Base Model
The platform requires base models to be stored in a specified path:
```
{deepextension_base_dir}/models/stable-diffusion-3.5-medium
```
> Note: Compatible with any SD series models

#### Dataset
Training datasets follow standard formats and can be obtained from:
[`sd-in-video`](../assets/datasets/sd-in-video.zip)

For dataset upload procedures, refer to: [Dataset Management](../user-guide/dataset-management.md)

#### Training Code

Extract the adapted SimpleTuner version to the `deep-e-python` folder in the project root directory.

---

## Environment Validation

### Local Testing Process

Environment validation must be completed before integration:

```bash
# Create isolated environment
conda create -n sd python=3.11 -y
conda activate sd

# Install dependencies
cd SimpleTuner/
pip install -U poetry pip -i https://pypi.tuna.tsinghua.edu.cn/simple --trusted-host pypi.tuna.tsinghua.edu.cn
poetry config virtualenvs.create false
poetry source add --priority=default tsinghua https://pypi.tuna.tsinghua.edu.cn/simple/
poetry lock
poetry install

# Execute validation
./train.sh
```

Expected result: The script executes normally and completes the preset iteration count.

> **Key Requirement: Platform integration can only proceed after successful local validation**

---

## Platform Integration

### Entry Implementation
Training task scheduling is implemented through the `sd-demo.py` entry file. For environment configuration details, refer to: [Python Environment Management Guide](how-to-configure-env.md)

### Execution Mechanism
The platform uses standardized startup commands:
```python
cmd = ['conda', 'run', '-n', envName, 'python', pythonFile]
```

This design offers the following advantages:

- **Modularity**: Each training method runs independently

- **Flexibility**: Supports parallel multi-environment execution

- **Maintainability**: Unified execution interface

---

## Container Environment Deployment

### Option 1: Real-time Installation

Follow the "Environment Validation" steps above within the container.

### Option 2: Pre-configured Environment

The system presets the environment name for SD models as `sd`, which can be pre-configured via:

```bash
# Environment packaging (on machine with existing environment)
conda install -c conda-forge conda-pack
conda pack -n sd -o sd.tar.gz

# Environment deployment (on machine requiring new dependencies)
cd {deepextension_dir}/conda/envs
mkdir -p sd
tar -xzf sd.tar.gz -C sd

# Activation within container
docker exec -it deepE-training-prod bash
## First entry into container
conda init
exit
source /opt/conda/envs/sd/bin/conda-unpack
## You will see like 
# bash: import: command not found
# bash: import: command not found
# bash: import: command not found
# bash: import: command not found
# bash: import: command not found
# bash: on_win: command not found
# bash: /opt/conda/envs/sd/bin/conda-unpack: line 48: syntax error near unexpected token `('
# bash: /opt/conda/envs/sd/bin/conda-unpack: line 48: `SHEBANG_REGEX = ('
```

---

## Technical Validation

### Implementation Achievements

- ✅ Seamless integration of third-party training code

- ✅ Standardized workflow support

- ✅ Image generation model training task scheduling

### Platform Compatibility

- Supports multiple SD base models

- Adapts to standard dataset formats

- Provides complete environment management solutions

---

## Summary

SD-Demo successfully validates DeepExtension platform's capability to integrate complex training workflows, establishing a technical foundation for standardizing future image generation model training tasks.

> DeepExtension - Enterprise AI Training Workflow Standardization Platform  
> Professional Integration | Stable Operation | Efficient Scheduling