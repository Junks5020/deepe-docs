# Installation Guide

DeepExtension is an enterprise-level AI platform, and while we aim to make setup as easy as possible, some initial configuration is still required. We recommend using Docker-based deployment to leverage the benefits of containerization and cloud-native infrastructure.

---

## Define Installation Directory

Choose a directory as your DeepExtension base folder. We'll refer to this path as `{deepextension_base_dir}` throughout this guide.

- **Recommended path**: `/opt/deepextension`

---

## 1. Prepare the Database

We recommend **not** using Docker to run your PostgreSQL database. Use a local or dedicated database server for better stability.

1. Install a local PostgreSQL server ((version 16.1 is known to run stably))
2. Choose an IP and port (e.g., `5439`), referred to as `{psql_url}` and `{psql_port}`
3. (Optional for advanced users) Change the DB password and update it in the configuration file `de-psql.conf`
4. Use the provided migrator to initialize the schema

    - Run the migration script: `***`
    - Confirm tables are successfully created

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

### a. CUDA (Linux, NVIDIA GPUs)

1. In `{deepextension_base_dir}/image.env`, find `CUSTOM_TRAINING_AI_IMAGE_VERSION` (e.g., `a1b2c3d4` as {ai_image_version})
2. Go to {deepextension_base_dir} and build the training image using the following command:

```bash
docker build --platform=linux/amd64 -t jianweisoft.cn/scpe/training-py:{ai_image_version} -f deep-e-python/Dockerfile .
```

### b. Apple macOS (M1–M4)

1. Install Node.js and NPM
2. Run:

```bash
npm install -g pm2
```

### c. No AI Image (no-training mode)

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
{deepextension_base_dir}/resources/initial_root_password.txt
```

### Steps:

1. Log in with this password
2. Immediately change it
3. **Delete** the password file for security

---

## Important

- Do **not** manually modify any files or configurations without contacting the DeepExtension team.
- Always follow upgrade instructions during version updates.
