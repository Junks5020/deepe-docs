# Installation Guide

DeepExtension is an enterprise-level AI platform, and while we aim to make setup as easy as possible, some initial configuration is still required. We recommend using Docker-based deployment to leverage the benefits of containerization and cloud-native infrastructure.

---

## Define Installation Directory

Choose a directory as your DeepExtension base folder. We'll refer to this path as `{deepextension_base_dir}` throughout this guide.

- **Recommended path**: `/opt/deepextension`

---

## 1. Prepare the Database

We recommend **not** using Docker to run your PostgreSQL database. Use a local or dedicated database server for better stability.

1. Install a local PostgreSQL server (version 16.1 is known to run stably)
2. Choose an IP and port (e.g., `5439`), referred to as `{psql_url}` and `{psql_port}`
3. (Optional for advanced users) Change the DB password and update it in the configuration file `de-psql.conf`
4. Initialize the database schema using the **golang-migrate** tool:

### 1.4.1 Install golang-migrate

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

### 1.4.2 Execute the Migration
```bash
# Run the migration command with the appropriate connection string
migrate -path {deepextension_base_dir}/migrations -database "postgres://{dbuser}:{dbpassword}@{dbhost}:{dbport}/postgres?sslmode=disable" up
```

### 1.4.3 Verify Migration
After running the migration, enter the database and check:
```sql
select is_init from sys_version_config where deploy_version = 0.1;
```
If the result of `is_init` is `true`, the schema migration has completed successfully.

Once migration is verified, you may start DeepExtension. If the schema was not properly initialized, the application will fail to start.

---

## 2. Clone the Repository

Clone the DeepExtension repository from GitHub.

```bash
cd /opt
git clone {deepextension_github_url} deepextension
cd deepextension
```

Check that the clone was successful and without errors.

---

## 3. Configure Database Access

**Create** the file `{deepextension_base_dir}/db_conf.data` and enter the following:

```
DB_HOST={psql_url}
DB_PORT={psql_port}
```

> 💡 If your system’s IP address changes frequently (e.g., on a MacBook or a server without a fixed IP), you may need to update it manually. For servers, we recommend setting a static IP address.

---

## 4. Configure AI Training Image

There are three options depending on your platform:

### A. CUDA (Linux, NVIDIA GPUs)

1. In `{deepextension_base_dir}/image.env`, find `CUSTOM_TRAINING_AI_IMAGE_VERSION` (e.g., `a1b2c3d4` as {ai_image_version})
2. Go to `{deepextension_base_dir}` and build the training image using the following command:

```bash
docker build --platform=linux/amd64 -t jianweisoft.cn/scpe/training-py:{ai_image_version} -f deep-e-python/Dockerfile .
```

### B. Apple macOS (M1–M4)

#### a. Prepare the MLX code

1. Download the entire repository from https://github.com/ml-explore/mlx-lm (tested successfully with v0.24.1)
2. Copy the `mlx_lm` directory into `{deepextension_base_dir}/deep-e-python`
3. Edit `{deepextension_base_dir}/deep-e-python/tuner/datasets.py`:

Change from:
```python
names = ("train", "valid", "test")
train = load_subset(data_path)
train, valid, test = [load_subset(data_path / f"{n}.jsonl") for n in names]
return train, valid, test
```
To:
```python
# names = ("train", "valid", "test")
train = load_subset(data_path)
# train, valid, test = [load_subset(data_path / f"{n}.jsonl") for n in names]
return train, train, None
```
4. Edit `tuner/trainer.py`:

Change from:
```python
mx.set_wired_limit(mx.metal.device_info()["max_recommended_working_set_size"])
```
To:
```python
# mx.set_wired_limit(mx.metal.device_info()["max_recommended_working_set_size"])
mx.set_wired_limit(8 * 1024 * 1024 * 1024)
```

> This sets a memory limit of 8GB, suitable for LoRA training on a 1.5B base model with a 16GB Mac. Adjust as needed for your system.

#### b. For users with Conda installed

1. Create a new environment (e.g., for Python 3.11):
```bash
conda create -n deepe_prod python=3.11
```
2. Activate the environment:
```bash
conda activate deepe_prod
```
3. Install dependencies:
```bash
pip3 install -r requirements.txt
```
4. Test installation:
```bash
python3 test_installation_with_tiny_training.py
```

#### c. For users without Conda

1. Create and activate a virtual environment:
```bash
python3 -m venv deepe_prod
source deepe_prod/bin/activate
pip3 install -r requirements.txt
```
2. Test installation:
```bash
python3 test_installation_with_tiny_training.py
```

#### d. Finalize with:

1. Install Node.js and NPM
2. Run:

```bash
npm install -g pm2
```

### C. No AI Image (no-training mode)

1. Create a file named `{deepextension_base_dir}/ai-image.conf`
2. Add:

```
WITH_AI_IMAGE = false
```

By default, training image is enabled if this file does not exist.

---

## 5. Start the Application

Run:

```bash
./run_compose.sh
```

Verify that:

- All images are downloaded
- All containers start successfully

Open `http://localhost:88` to check the Web UI.

---

## 6. Root User Setup (First Run Only)

During the first launch, a root user is created automatically. The initial password is saved at:

```
{deepextension_base_dir}/adminPassword/adminPassword.txt
```

### Steps:

1. Log in with this password
2. Immediately change it
3. **Delete** the password file for security

---

## Important

- Do **not** manually modify any files or configurations without contacting the DeepExtension team.
- Always follow upgrade instructions during version updates.
