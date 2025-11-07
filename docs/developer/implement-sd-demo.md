# SD-Demo Implementation Guide

This document explains how the built-in training method **SD-Demo** is implemented within DeepExtension.

SD-Demo is a read-only reference example demonstrating how to integrate third-party training code into DeepExtension's workflow.

---

## Example Source

**SD-Demo** is based on the LoRA training implementation from the [SimpleTuner project](https://github.com/bghira/SimpleTuner.git). Since it has been tested only with a specific commit hash and includes adjustments to dependency versions and entry scripts, we provide an adapted downloadable package.

[Download Adapted SimpleTuner Version](../assets/datasets/SimpleTuner.zip)

---

## Prerequisites: Local Runtime Environment

By default, the SD example reads datasets from directories, while DeepExtension requires file-based input format.

### Base Model (Local)

Ensure compatible base models (e.g., `stable-diffusion-3.5-medium`) are downloaded to the following path:

```
{deepextension_base_dir}/models/stable-diffusion-3.5-medium
```

> Note: You can also use any other locally available SD-compatible model.

### Dataset (Local)

The dataset used by SD-Demo is located within the SimpleTuner directory:

```
SimpleTuner/datasets/sd3.5_generated_hard_examples
```

> Important: Due to limitations of the SimpleTuner project, the dataset currently uses a fixed path and will be integrated into the unified system management in the future.

---

## Environment Setup and Local Testing

Before integration, verify that the SimpleTuner example code can run normally on your local machine:

```bash
# Create Conda environment
conda create -n sd-demo python=3.11 -y
conda activate sd-demo

# Enter project directory and install dependencies
cd SimpleTuner/
pip install -U poetry pip -i https://pypi.tuna.tsinghua.edu.cn/simple --trusted-host pypi.tuna.tsinghua.edu.cn
poetry config virtualenvs.create false
poetry source add --priority=default tsinghua https://pypi.tuna.tsinghua.edu.cn/simple/
poetry lock
poetry install

# Run training script
./train.sh
```

If everything is set up correctly, the script should run normally and complete after several iterations.

> **Important: Proceed with integration steps only after successful local testing.**

---

## Integration with `sd-demo.py`

After validating the training script, we created the `sd-demo.py` entry file.The environment configuration within the container can be found in [How to Configure Environment](how-to-configure-env.md).

Currently, all training code follows a unified startup format:

```python
cmd = ['conda', 'run', '-n', envName, 'python', pythonFile]
```

This approach offers better modularity, provides certain flexibility, and facilitates future maintenance and expansion.

---

## Summary

- **SD-Demo** demonstrates how to integrate SimpleTuner-based training workflows into the DeepExtension platform
- Validates the feasibility of using image generation models for training tasks through DeepExtension

---

> DeepExtension — Integrate real training workflows into your enterprise AI stack.
> No hacks, no workarounds, just clean integration.