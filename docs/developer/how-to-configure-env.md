# Python Environment Management Guide

## Overview

To address the significant differences in training code across the various model types supported by DeepExtension, the latest version introduces support for isolated Python environments. This isolation is achieved using Conda.

This document explains how to create and use a new Conda environment within the system.

## Creating a New Environment

### 1. Access the Python Container
Start by entering the running Docker container:
```shell
docker exec -it deepE-training-prod bash
```

### 2. Initialize Conda (If Necessary)
You may encounter one of two scenarios upon entering the container:

*   **Scenario 1: Conda is not initialized** in your shell session.
    Execute the following commands to initialize Conda and re-enter the container:
    ```shell
    conda init
    exit
    docker exec -it deepE-training-prod bash
    ```

*   **Scenario 2: Conda is already initialized**. The command prompt will typically show a `(base)` prefix. You can proceed directly to the next step.

### 3. Create the Conda Environment
Use the `conda create` command to establish a new isolated environment. Specify your desired environment name (`env_name`) and Python version.
```shell
conda create -n <env_name> python=<version_number> -y
```
*Example:*
```shell
conda create -n my_training_env python=3.9 -y
```

### 4. Install Dependencies
There are two primary methods for installing dependencies into your new environment:

**Method 1: Install from a `requirements.txt` file**
```shell
conda activate <env_name>
pip install -r requirements.txt
```

**Method 2: Installation via Local Package Directory**

**On Machine A, perform the following operations:**
```shell
# Enter the training container
docker exec -it deepE-training-prod

# Activate the target environment
conda activate <environment_name>

# Install the conda-pack tool
conda install -c conda-forge conda-pack

# Package the current environment (execute within the container)
conda pack -n <environment_name> -o <environment_name>.tar.gz
```

**Transfer the packaged file:**
- Transfer the generated `<environment_name>.tar.gz` file from Machine A to Machine B

**On Machine B, perform the following operations:**
```shell
# Navigate to the project directory and create the environment directory
mkdir -p ./conda/envs/<environment_name>

# Enter the target directory
cd ./conda/envs/<environment_name>

# Extract the environment package
tar -xzf <environment_name>.tar.gz

# Enter the training container
docker exec -it deepE-training-prod

# Run conda-unpack to fix paths (Important!)
source /opt/conda/envs/<environment_name>/bin/conda-unpack

# Clean up temporary files (optional)
rm /opt/conda/envs/<environment_name>/bin/conda-unpack
```

**Important Notes:**
- Replace `<environment_name>` with the actual conda environment name
- Ensure the directory structure on Machine B matches that on Machine A
- The conda-unpack step must be executed to fix hardcoded paths in the environment

## Using the Environment

Once the environment is created, you can specify it for your training tasks. In the training method configuration, locate the **`conda_env`** field and enter the name of the environment you created (e.g., `my_training_env`).

For detailed instructions on configuring training methods, please refer to the [Training Configuration Documentation].