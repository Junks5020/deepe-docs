# Python Environment Management Guide

## Overview

To address the variability in training code caused by the wide variety of models supported by DeepExtension, the latest version now supports using Conda for Python environment isolation.

This document explains how to create and use new Conda environments within the system.

## Creating a New Environment

### 1. Enter the Python Container
First, enter the running Docker container:
```shell
docker exec -it deepE-training-prod bash
```

### 2. Initialize Conda (If Needed)
After entering the container, you might encounter one of the following two situations:

*   **Situation 1: Conda is not initialized.** The command prompt does not have the `(base)` environment prefix.
    Please execute the following commands to initialize Conda and re-enter the container:
    ```shell
    conda init
    exit
    docker exec -it deepE-training-prod bash
    ```

*   **Situation 2: Conda is already initialized.** The command prompt typically shows the `(base)` prefix, and you can proceed directly to the next step.

### 3. Create a Conda Environment
Use the `conda create` command to create a new isolated environment. Specify the desired environment name (`env_name`) and Python version.
```shell
conda create -n <environment_name> python=<version_number> -y
```
*Example:*
```shell
conda create -n my_training_env python=3.9 -y
```

### 4. Install Dependencies
You can install dependencies in the new environment primarily through the following two methods:

**Method 1: Install via requirements.txt file**
```shell
conda activate <environment_name>
pip install -r requirements.txt
```

**Method 2: Install via a local package directory**

**Perform the following operations on Machine A:**
```shell
# Enter the training container
docker exec -it deepE-training-prod

# Activate the target environment
conda activate <environment_name>

# Install the conda-pack tool
conda install -c conda-forge conda-pack

# Pack the current environment (execute inside the container)
conda pack -n <environment_name> -o <environment_name>.tar.gz
```

**Transfer the packed file:**
- Transfer the generated `<environment_name>.tar.gz` file from Machine A to Machine B.

**Perform the following operations on Machine B:**
```shell
# Enter the project directory and create the environment directory
mkdir -p ./conda/envs/<environment_name>

# Enter the target directory
cd ./conda/envs/<environment_name>

# Extract the environment package
tar -xzf <environment_name>.tar.gz

# Enter the training container
docker exec -it deepE-training-prod

# Run conda-unpack to fix paths (Important!)
source /opt/conda/envs/<environment_name>/bin/conda-unpack

# Clean up temporary files (Optional)
rm /opt/conda/envs/<environment_name>/bin/conda-unpack
```

**Important Notes:**
- Replace `<environment_name>` with the actual Conda environment name.
- Ensure the directory structure on Machine B is consistent with Machine A.
- The `conda-unpack` step must be executed to fix hardcoded paths within the environment.

## Environment Configuration Examples

### Qwen3 Model Training Environment Configuration

For training the `Qwen3` model, we provide a pre-configured environment dependency file. You can quickly create a usable training environment by following these steps:

**Step 1: Create the Environment**
```shell
conda create -n transformer_env python=3.10 -y
conda activate transformer_env
```

**Step 2: Install Dependencies**
Save the following content as a `requirements_qwen25.txt` file:

*(Content of requirements_qwen25.txt remains the same as provided in the original Chinese text, as it contains specific package names and versions which should not be translated. It lists Conda channels, dependencies (like _libgcc_mutex, bzip2, python, etc.) and pip packages (like accelerate, torch, transformers, etc.). The `prefix` at the end points to `/opt/conda/envs/transformer_env`)*

Then install the dependencies:
```shell
pip install -r requirements_qwen25.txt
```

**Step 3: Verify Installation**
```python
# Verify key package versions
python -c "import torch; print(f'PyTorch: {torch.__version__}'); import transformers; print(f'Transformers: {transformers.__version__}'); import peft; print(f'PEFT: {peft.__version__}')"
```

**Step 4: Export Environment (Optional)**
If you need to migrate the environment to another machine, you can pack it using conda-pack:
```shell
conda install -c conda-forge conda-pack
conda pack -n qwen25_training -o qwen25_training.tar.gz
```

## Using the Environment

Once the environment is created, you can specify its use in your training tasks. Please locate the **`conda_env`** field in your training method configuration and enter the name of the environment you created (e.g., `my_training_env` or `transformer_env`).

For detailed instructions on training method configuration, please refer to the [Training Configuration Documentation](../user-guide/training-methods.md).