# Installation Guide

DeepExtension is an enterprise-level AI platform, and while we aim to make setup as easy as possible, some initial configuration is still required. We recommend using Docker-based deployment to leverage the benefits of containerization and cloud-native infrastructure.

---

## Define Installation Directory

Choose a directory as your DeepExtension base folder. We'll refer to this path as `{deepextension_base_dir}` throughout this guide.

- **Recommended path**: `/opt/deepextension`

---

## 1. Clone the Repository

Clone the DeepExtension repository from GitHub.

```bash
cd /opt
git clone git@github.com:DeepExtension-AI/DeepExtension.git deepextension
cd deepextension
```

Check that the clone was successful and without errors.

---

## 2. Database Preparation (Optional)
To streamline the setup process, an integrated PostgreSQL database is included in the Docker Compose configuration. If you do not require an external database, you may safely skip this section.
>
> Note: We do not recommend using the Docker Compose-integrated PostgreSQL database in production environments. If you prefer to use your own external database, please follow the steps below.

1. Manually install a local PostgreSQL server or use existing database information(version 16 is known to run stably)
2. To ensure successful initialization, you **must** use the default superuser:  
   **`dbuser = postgres`**  
3. Make sure to note down the following parameters for later use: {dbname}, {dbuser}, {dbpassword}, {dbhost}, and {dbport}.
4. Initialize the database schema using the **golang-migrate** tool:

### 2.4.1 Install golang-migrate

You can install this tool via CLI or Homebrew (for macOS users):

#### Option A: CLI (Recommended)
```bash
# 1. Navigate to the migrate folder in the DeepExtension codebase
cd {deepextension_base_dir}/migrate

# 2. Make the installation script executable
chmod +x install_migrate.sh

# 3. Run the script (administrator password may be required)
./install_migrate.sh

# 4. Verify installation
migrate -version
# Example output: v4.18.3
```

#### Option B: Homebrew (macOS only)
```bash
# 1. Install via Homebrew
brew install golang-migrate

# 2. Verify installation
migrate -version
# Example output: v4.18.3
```

### 2.4.2 Execute the Migration
```bash
# Run the migration command with the appropriate connection string
cd {deepextension_base_dir}
migrate -path migrations -database "postgres://{dbuser}:{dbpassword}@{dbhost}:{dbport}/{dbname}?sslmode=disable" up
```

After running the migration, you should see no error messages and output similar to the following:
```
1747303002/u create_initialize_type (***ms)
1747303003/u create_initialize_table (***ms)
```

This indicates that the migration completed successfully. You can now proceed with the next steps of the installation.

> If the schema is not initialized correctly, the program will fail to start.

---



### 2.5 Configure Database Access

**Create** the configuration file `{deepextension_base_dir}/custom.conf` from template:

```
cd {deepextension_base_dir}
cp custom.conf.template custom.conf
```
Open `custom.conf` with any text editor and edit the following fields:
```
DB_HOST={dbhost}
DB_PORT={dbport}
DB_USER=postgres
DB_PASS={dbpassword}
DB_NAME={dbname}
```

> 💡  Important: 
> 
> - If the db machine’s IP address changes frequently (e.g., on laptops or networks without static IPs), you will need to manually update this value. 
> - For production servers, it is strongly recommended to configure a static IP address to prevent connection issues.

## 3. Set Up Model Training Environment

> **Note**  
> 
> DeepExtension offers different setup options based on your platform’s capabilities:
> 
> - On **CUDA（Linux or Windows via WSL)** systems, model training can be run **inside Docker** because Docker supports full GPU acceleration through **NVIDIA’s native CUDA integration**. This allows you to containerize the training process and benefit from isolation, reproducibility, and simplified deployment.
> 
> - On **macOS (M1–M4)** systems, GPU acceleration is provided via **Metal Performance Shaders (MPS)**. However, Docker does **not support GPU passthrough** on macOS. As a result, training must run **outside of Docker**, directly on the host.  
>   To ensure that training services behave like a Docker-managed process (with auto-restart, background execution, and logging), we use **PM2**, a process manager for Node.js.
> 
> - The **"No AI Image" (no-training mode)** option is intended for users who want to explore DeepExtension’s features **without GPU hardware**. This mode is functional but **not recommended**.


There are three options depending on your platform:

### Option A: CUDA (Linux or Windows via WSL, NVIDIA GPUs)

Before starting, ensure that your environment supports GPU passthrough into Docker.

Run the following command to verify if Docker and CUDA drivers are correctly installed and configured:
```bash
docker run -it --rm --gpus all pytorch/pytorch:latest python -c "import torch; print(torch.cuda.is_available())"
```

- If the output is True, your setup is correct.

- If it returns False or shows errors, you need to install or fix the GPU drivers and Docker GPU support.

> 💡 For Linux systems, make sure to install the NVIDIA Container Toolkit. You can follow the official instructions at:
>
> [https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)

Upon confirmation of successful test execution and verification of all test criteria, proceed to implement the procedures outlined in Step 4.

### Option B: Apple macOS (M1–M4)

> ⚠️ **Attention**  
> The MLX-based training method requires **macOS version 13.5 or higher**.  
> If your system does not meet this requirement, please skip to **Option C: No AI Image (no-training mode)**.

#### a. Prepare the MLX code

1. Download the entire repository from [https://github.com/ml-explore/mlx-lm](https://github.com/ml-explore/mlx-lm) (tested successfully with v0.24.1)
2. Copy the `mlx_lm` subdirectory from the `mlx-lm` project  into `{deepextension_base_dir}/deep-e-python`
3. Run the preparation script to apply required MLX code modifications for DeepExtension compatibility:

```bash
cd {deepextension_base_dir}/deep-e-python
chmod +x prepare_mlx_changes.sh
./prepare_mlx_changes.sh
```

Using the script saves time and helps avoid manual editing errors. The changes are

-  For `{deepextension_base_dir}/deep-e-python/mlx_lm/tuner/datasets.py`,

change from:
```python
names = ("train", "valid", "test")
train, valid, test = [load_subset(data_path / f"{n}.jsonl") for n in names]
return train, valid, test
```
To:
```python
# names = ("train", "valid", "test")
train = load_subset(data_path)
return train, train, None
```

-  For `{deepextension_base_dir}/deep-e-python/mlx_lm/tuner/trainer.py`,

change from:
```python
mx.set_wired_limit(mx.metal.device_info()["max_recommended_working_set_size"])
```
To:
```python
mx.set_wired_limit(8 * 1024 * 1024 * 1024)
```

> This sets a memory limit of 8GB, suitable for LoRA training on a 1.5B base model with a 16GB Mac. Adjust as needed for your system.

#### b. Set Up the Python Environment and Install Required Packages
Option 1: For users with Conda installed

1. Create a new environment (e.g., for Python 3.11):
```bash
conda create -n deepe_prod python=3.11
```
1. Activate the environment:
```bash
conda activate deepe_prod
```
1. Install dependencies:
```bash
pip3 install -r requirements_mac.txt
```

Option 2: For users without Conda installed

Set up a Python virtual environment using venv and install the required packages manually.

1. Create and activate a virtual environment:
```bash
python3 -m venv deepe_prod
source deepe_prod/bin/activate
pip3 install -r requirements_mac.txt
```


For both options 1 and 2 above, we should verify that all required packages are installed correctly and completely.
Before continuing to test the overall installation, you may want to verify that the local environment is properly configured — especially if you plan to run Mac-native training using MLX.

We recommend following the **“Test the Localized Script”** section in  
[How We Implemented MLX-Demo (MacOS)](implement-mlx-demo.md).  
This ensures that the `mlx_lm.lora` module is correctly installed and that your environment can execute a minimal MLX-based training run.

Specifically, confirm the following:

- A base model (e.g., `Qwen2.5-1.5B-Instruct`) is available in `{deepextension_base_dir}/models` (see also [Add Base Models](how-to-add-base-models.md))
- A dataset file is available at `{deepextension_base_dir}/examples/mlx-demo-train-dataset.jsonl`

Then run:

```bash
cd {deepextension_base_dir}/deep-e-python
python3 -m mlx_lm.lora \
    --model ../models/Qwen2.5-1.5B-Instruct \
    --train \
    --data examples/mlx-demo-train-dataset.jsonl \
    --iters 2
```

If the command runs without errors, your local environment is confirmed to be functional.

>  Only proceed to the next installation test step after this check passes.


#### c. Install pm2:

1. Install Node.js and NPM
2. Run:

```bash
npm install -g pm2
```

#### d. Troubleshooting Python Environment Issues

> **Note**  
> During our testing, we observed that issues may arise depending on the specific Python version in use, or whether you're invoking `python3` vs. `python`. Please be patient — environment setup may require several iterations to get right.

If the training service fails to start or behaves unexpectedly:

- Run the following to inspect runtime logs, — especially helpful when running training for the first time:
  ```bash
  pm2 logs training-py
  ```

- If you encounter missing dependencies or version mismatches, install the required packages, then clear the PM2 cache:
  ```bash
  pm2 delete training-py
  ```
- After applying fixes or updating packages, restart the training service by following the instructions in Step 5.

> In our experience, sometimes the setup process is quick and smooth, but in other cases, it may take time to resolve all package and compatibility issues. Don’t worry — once the environment is correctly set up, it will remain stable.
### Option C: No AI Image (No-Training Mode)

To run DeepExtension without training capabilities, open `{deepextension_base_dir}/custom.conf` with any text editor and add the following line:

```bash
WITH_AI_IMAGE=false
```

> This variable only takes effect in CUDA-enabled environments.
> By default, WITH_AI_IMAGE is set to true.
> To enable "No-Training Mode", you need to manually set this value to false.
> If the training image build fails, the execution script will automatically set WITH_AI_IMAGE to false.


---
## 4. Configuring Optional Environment Parameters
### Web Service Port Configuration
- Default Port: **88**

- Port Conflict Handling: If the default port is occupied, the system will automatically search for available ports beginning from 88 in ascending order.

- Configuration File: {deepextension_base_dir}/custom.conf

- Configuration Parameter: UI_AI_EXPOSED_PORT

To specify a custom port, add or modify the following line in the configuration file:

```ini
UI_AI_EXPOSED_PORT={preferred_webui_port}
```
### AI Redis Service Port Configuration
- Default Port: **6490**

- Port Conflict Handling: If the default port is occupied, the system will automatically search for available ports beginning from 6490 in ascending order.

- Configuration File: {deepextension_base_dir}/custom.conf

- Configuration Parameter: AI_PY_REDIS_EXPOSED_PORT

To specify a custom port, add or modify the following line in the configuration file:


```ini
AI_PY_REDIS_EXPOSED_PORT={preferred_redis_port}
```

---

## 4. Start the Application

Run:

```bash
./run_compose.sh
```

Verify that:

- All images are downloaded
- All containers start successfully

Open `[http://localhost:88](http://localhost:88)` or `[http://localhost:{preferred_webui_port}](http://localhost:{preferred_webui_port})` to check the Web UI.

To manage the application lifecycle, use the following commands:

- Stop all running containers (without removing them):
```bash
./run_compose.sh stop
```

- Stop and **remove** the containers (images and volumes are not affected):
```bash
./run_compose.sh down
```

> These commands work similarly to `docker compose stop` and `docker compose down`.
> You can use them safely during upgrades, maintenance, or when switching environments.

### Verify Database Initialization (First Run Only)
During the first application launch, initial data will be populated into the database.
To verify that the schema migration was successful, connect to the database and run:
```sql
select is_init from sys_version_config where deploy_version = 0.1;
```
If the result of `is_init` is `true`, it confirms that the schema was migrated successfully.

---

## 5. Root User Setup (First Run Only)

During the first launch, a root user is created automatically. The initial password is saved at:

```
{deepextension_base_dir}/adminPassword/adminPassword.txt
```

### Steps:

1. Use the following credentials to log in for the first time:  

    - **Project Code**: `1001`  
    - **Username**: `admin`  
    - **Initial Password**: *(see file)* `{deepextension_base_dir}/adminPassword/adminPassword.txt`

2. Immediately change the password after logging in.

3. **Delete** the password file to ensure security.

4. Go to [User Management](../user-guide/user-management.md) to add new normal users.  
   > Only the **admin** user should perform administrative tasks. Regular users should have their own accounts.


---

## Important

- Do **not** manually modify any files or configurations without contacting the DeepExtension Team.
- Always follow upgrade instructions during version updates.
- If you still encounter problems during installation or have feedback regarding this guide, please email us at: install@deepextension.ai