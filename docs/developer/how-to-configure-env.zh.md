# Python 环境管理指南

## 概述

为解决 DeepExtension 所支持模型种类繁杂导致的训练代码差异性问题，最新版本已支持使用 Conda 实现 Python 环境隔离。

本文档说明如何在系统中创建和使用新的 Conda 环境。

## 创建新环境

### 1. 进入 Python 容器
首先进入正在运行的 Docker 容器：
```shell
docker exec -it deepE-training-prod bash
```

### 2. 初始化 Conda（如需要）
进入容器后可能会遇到以下两种情况：

*   **情况 1：Conda 未初始化**。命令行提示符前没有 `(base)` 环境标识。
    请执行以下命令初始化 Conda 并重新进入容器：
    ```shell
    conda init
    exit
    docker exec -it deepE-training-prod bash
    ```

*   **情况 2：Conda 已初始化**。命令行提示符通常显示 `(base)` 前缀，可直接进行下一步操作。

### 3. 创建 Conda 环境
使用 `conda create` 命令创建新的隔离环境。请指定所需的环境名称（`env_name`）和 Python 版本。
```shell
conda create -n <环境名称> python=<版本号> -y
```
*示例：*
```shell
conda create -n my_training_env python=3.9 -y
```

### 4. 安装依赖包
可通过以下两种主要方法在新环境中安装依赖：

**方法 1：通过 requirements.txt 文件安装**
```shell
conda activate <环境名称>
pip install -r requirements.txt
```

**方法 2：通过本地包目录安装**

**在机器A上执行以下操作：**
```shell
# 进入训练容器
docker exec -it deepE-training-prod

# 激活目标环境
conda activate <环境名称>

# 安装conda-pack工具
conda install -c conda-forge conda-pack

# 打包当前环境（在容器内执行）
conda pack -n <环境名称> -o <环境名称>.tar.gz
```

**传输打包文件：**
- 将生成的 `<环境名称>.tar.gz` 文件从机器A传输到机器B

**在机器B上执行以下操作：**
```shell
# 进入项目目录，创建环境目录
mkdir -p ./conda/envs/<环境名称>

# 进入目标目录
cd ./conda/envs/<环境名称>

# 解压环境包
tar -xzf <环境名称>.tar.gz

# 进入训练容器
docker exec -it deepE-training-prod

# 运行conda-unpack修复路径（重要！）
source /opt/conda/envs/<环境名称>/bin/conda-unpack

# 清理临时文件（可选）
rm /opt/conda/envs/<环境名称>/bin/conda-unpack
```

**注意事项：**
- 请将 `<环境名称>` 替换为实际的conda环境名称
- 确保机器B的目录结构与机器A保持一致
- conda-unpack步骤必须执行，以修复环境中的硬编码路径

## 使用环境

环境创建完成后，即可在训练任务中指定使用。请在训练方法配置中找到 **`conda_env`** 字段，并填入您创建的环境名称（例如：`my_training_env`）。

关于训练方法配置的详细说明，请参阅 [训练配置文档]。