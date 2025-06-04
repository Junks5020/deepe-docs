# 安装指南

DeepExtension 是一个企业级 AI 平台。虽然我们力求简化安装过程，但仍需进行一些初始配置。我们推荐使用基于 Docker 的部署方式，以充分利用容器化与云原生基础设施的优势。

---

## 定义安装目录

选择一个目录作为你的 DeepExtension 基础目录。我们将在本指南中用 `{deepextension_base_dir}` 来引用该路径。

- **推荐路径**：/opt/deepextension

---

## 1. 克隆仓库

从 GitHub 克隆 DeepExtension 仓库。

```bash
cd /opt
git clone git@github.com:DeepExtension-AI/DeepExtension.git deepextension
cd deepextension
```

确保克隆过程成功且无报错。

---

## 2. 准备数据库

我们**不建议**使用 Docker 来运行 PostgreSQL 数据库。推荐使用本地或专用数据库服务器，以提升稳定性。

1. 安装本地 PostgreSQL 数据库（建议使用 16 版本）
2. 为确保初始化成功，**必须使用默认超级用户**：  
   **dbuser = postgres**  
3. 请记下以下参数，稍后需要用到：{dbname}, {dbuser}, {dbpassword}, {dbhost}, {dbport}
4. 使用 **golang-migrate** 工具初始化数据库 schema：

### 2.4.1 安装 golang-migrate

你可以通过 CLI 或 Homebrew（macOS 用户）安装此工具：

#### 选项 A：命令行（推荐）

```bash
cd {deepextension_base_dir}/migrate
chmod +x install_migrate.sh
./install_migrate.sh
migrate -version
# 示例输出：v4.18.3
```

#### 选项 B：Homebrew（仅适用于 macOS）

```bash
brew install golang-migrate
migrate -version
# 示例输出：v4.18.3
```

### 2.4.2 执行迁移

```bash
cd {deepextension_base_dir}
migrate -path migrations -database "postgres://{dbuser}:{dbpassword}@{dbhost}:{dbport}/{dbname}?sslmode=disable" up
```

执行迁移后，如果无报错，你应看到类似如下输出：

```
1747303002/u create_initialize_type (***ms)
1747303003/u create_initialize_table (***ms)
```

这表示迁移成功完成。你可以继续进行安装的下一步。

> 如果 schema 初始化不正确，程序将无法启动。

---

### 2.5 配置数据库访问

**从模板创建**配置文件 {deepextension_base_dir}/custom.conf：

```bash
cd {deepextension_base_dir}
cp custom.conf.template custom.conf
```

使用任何文本编辑器打开 custom.conf 并编辑以下字段：

```
DB_PORT={dbport}
DB_USER=postgres
DB_PASS={dbpassword}
DB_NAME={dbname}
```

如果数据库位于与 DeepExtension 安装在**同一台机器**上，  
则无需修改 {dbhost} —— 默认值已在 {deepextension_base_dir}/prod.env 中指定。

如果数据库托管在**其他机器**上，必须显式设置主机 IP，在 {deepextension_base_dir}/custom.conf 中添加以下行：

```bash
DB_HOST={dbhost}
```

> 💡 重要提示：
>
> - 如果数据库机器的 IP 地址经常变化（如笔记本或没有静态 IP 的网络），则需要手动更新该值。
> - 在生产服务器上，强烈建议配置静态 IP 地址，以避免连接问题。

---

## 3. 设置模型训练环境

> **注意**
>
> DeepExtension 提供多种安装选项，取决于平台能力：
>
> - 在 **CUDA（Linux 或 Windows 通过 WSL）** 系统中，模型训练可在 **Docker 容器中运行**，因为 Docker 支持 NVIDIA 的 CUDA 原生集成。这提供了良好的隔离性、可复现性与部署便利。
>
> - 在 **macOS (M1–M4)** 系统中，GPU 加速通过 **Metal Performance Shaders (MPS)** 提供。Docker 在 macOS 上**不支持 GPU 透传**，因此训练必须**在主机上直接运行**。
>   为了模拟 Docker 管理进程的行为（如自动重启、后台执行、日志记录），我们使用 **PM2**，一个 Node.js 的进程管理器。
>
> - **“无 AI 镜像”（不训练模式）** 适用于仅想探索 DeepExtension 功能而无 GPU 硬件的用户，但**不推荐**生产使用。

---

### 选项 A：CUDA（Linux 或 Windows via WSL）

确保环境支持 GPU 透传给 Docker。

```bash
docker run -it --rm --gpus all pytorch/pytorch:latest python -c "import torch; print(torch.cuda.is_available())"
```

- 输出为 True 表示设置正确
- False 或报错表示驱动或 Docker GPU 设置需修复

> 💡 Linux 系统请安装 NVIDIA Container Toolkit：
> [https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)

接下来可以操作如下步骤：

1. 在 {deepextension_base_dir}/prod.env 中找到 TRAINING_AI_IMAGE_NAME (设为{ai_image_name}) 和 TRAINING_AI_IMAGE_VERSION (设为{ai_image_version})
2. 构建训练镜像：

```bash
cd {deepextension_base_dir}/deep-e-python
docker build -t {ai_image_name}:{ai_image_version} -f Dockerfile . --load
```

---

### 选项 B：Apple macOS (M1–M4)

> ⚠️ **注意**
> MLX 训练要求 macOS 版本 ≥ 13.5，不满足请跳转到“无训练模式”

#### a. 准备 MLX 代码

1. 下载 [https://github.com/ml-explore/mlx-lm](https://github.com/ml-explore/mlx-lm) 仓库（测试版本 v0.24.1）
2.  将 `mlx-lm`项目中的 `mlx_lm` 子目录复制到 {deepextension_base_dir}/deep-e-python 目录中
3. 运行准备脚本：

```bash
cd {deepextension_base_dir}/deep-e-python
chmod +x prepare_mlx_changes.sh
./prepare_mlx_changes.sh
```

该脚本将对以下代码做兼容性修改（详见原文）

#### b. 安装依赖

方案 1：使用 Conda：

```bash
conda create -n deepe_prod python=3.11
conda activate deepe_prod
pip3 install -r requirements_mac.txt
```

方案 2：使用 venv：

```bash
python3 -m venv deepe_prod
source deepe_prod/bin/activate
pip3 install -r requirements_mac.txt
```

完成后可参考文档 [How We Implemented MLX-Demo (MacOS)](implement-mlx-demo.md) 进行验证。

---

#### c. 安装 pm2

1. 安装 Node.js 与 NPM
2. 安装 pm2：

```bash
npm install -g pm2
```

#### d. 排查 Python 环境问题

> **注意**  
> 在测试中我们发现，根据 Python 版本以及是调用 python 还是 python3，可能会出现不同的问题。请耐心调整环境配置。

如果训练服务启动失败或行为异常：

- 查看日志：

```bash
pm2 logs training-py
```

- 若遇到缺失依赖或版本不匹配：

```bash
pm2 delete training-py
```

- 修复后重新启动训练服务（见步骤 5）

> 实践表明，虽然首次配置可能较慢，但环境一旦配置好，将非常稳定。

---

### 选项 C：无 AI 镜像（不训练模式）

若不需要训练能力，请编辑 {deepextension_base_dir}/custom.conf，添加：

```bash
WITH_AI_IMAGE=false
```

> 默认情况下，WITH_AI_IMAGE 为 true。
> 若需启用“无训练模式”，必须手动设为 false。

---

## 4. 配置可选环境参数

Web UI 默认使用端口 **88**，在 {deepextension_base_dir}/prod.env 中由 {UI_AI_EXPOSED_PORT} 定义。  
如需修改：

```ini
UI_AI_EXPOSED_PORT={preferred_webui_port}
```

AI Redis 默认端口为 **6490**，在 {deepextension_base_dir}/prod.env 中由 {AI_PY_REDIS_EXPOSED_PORT} 定义。  
如需修改：

```ini
AI_PY_REDIS_EXPOSED_PORT={preferred_redis_port}
```

---

## 5. 启动应用

运行：

```bash
./run_compose.sh
```

验证：

- 镜像下载完成
- 所有容器成功启动

访问：[http://localhost:88](http://localhost:88) 或 [http://localhost:{preferred_webui_port](http://localhost:{preferred_webui_port})

生命周期管理命令：

- 停止容器（不删除）：

```bash
./run_compose.sh stop
```

- 停止并删除容器（不影响镜像与数据）：

```bash
./run_compose.sh down
```

> 类似 docker compose stop / down，可用于升级、维护或切换环境。

---

### 首次运行验证数据库初始化

首次启动时系统会向数据库写入初始化数据。  
可通过以下 SQL 验证：

```sql
select is_init from sys_version_config where deploy_version = 0.1;
```

若 is_init 为 true，表示初始化成功。

---

## 6. 设置管理员账户（首次运行）

首次启动时会自动创建管理员账户，初始密码位于：

```
{deepextension_base_dir}/adminPassword/adminPassword.txt
```

### 步骤：

1. 登录：

    - **项目代码**：1001  
    - **用户名**：admin  
    - **初始密码**：见上述文件

2. 登录后立即修改密码  
3. 删除 adminPassword.txt 文件确保安全  
4. 访问 [用户管理](../user-guide/user-management.md) 添加普通用户  
   > **管理员**账户只应该执行管理操作，业务操作需通过普通用户账户访问系统。

---

## 重要提示

- 请勿在未联系 DeepExtension 团队的情况下手动修改配置文件或系统文件
- 升级时务必遵循官方版本升级指南
- 如遇到问题或对本指南有建议，请邮件联系：install@deepextension.ai
