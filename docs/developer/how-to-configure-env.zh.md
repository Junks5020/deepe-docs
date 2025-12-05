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

## 环境配置案例

### Qwen3模型训练环境配置

对于`Qwen3`模型的训练，我们提供了一个预配置的环境依赖文件。您可以通过以下步骤快速创建可用的训练环境：

**步骤 1：创建环境**
```shell
conda create -n transformer_env python=3.10 -y
conda activate transformer_env
```

**步骤 2：安装依赖**
将以下内容保存为 `requirements_qwen25.txt` 文件：

```txt
name: transformer_env
channels:
  - conda-forge
  - defaults
dependencies:
  - _libgcc_mutex=0.1=main
  - _openmp_mutex=5.1=1_gnu
  - bzip2=1.0.8=h5eee18b_6
  - ca-certificates=2025.10.5=hbd8a1cb_0
  - conda-pack=0.8.1=pyhd8ed1ab_1
  - expat=2.7.1=h6a678d5_0
  - ld_impl_linux-64=2.44=h153f514_2
  - libffi=3.4.4=h6a678d5_1
  - libgcc=15.2.0=h767d61c_7
  - libgcc-ng=15.2.0=h69a702a_7
  - libgomp=15.2.0=h767d61c_7
  - libnsl=2.0.0=h5eee18b_0
  - libstdcxx-ng=11.2.0=h1234567_1
  - libuuid=1.41.5=h5eee18b_0
  - libxcb=1.17.0=h9b100fa_0
  - libzlib=1.3.1=hb25bd0a_0
  - ncurses=6.5=h7934f7d_0
  - openssl=3.5.4=h26f9b46_0
  - pip=25.2=pyhc872135_1
  - pthread-stubs=0.3=h0ce48e5_1
  - python=3.10.19=h6fa692b_0
  - readline=8.3=hc2a1206_0
  - setuptools=80.9.0=py310h06a4308_0
  - sqlite=3.50.2=hb25bd0a_1
  - tk=8.6.15=h54e0aa7_0
  - wheel=0.45.1=py310h06a4308_0
  - xorg-libx11=1.8.12=h9b100fa_1
  - xorg-libxau=1.0.12=h9b100fa_0
  - xorg-libxdmcp=1.1.5=h9b100fa_0
  - xorg-xorgproto=2024.1=h5eee18b_1
  - xz=5.6.4=h5eee18b_1
  - zlib=1.3.1=hb25bd0a_0
  - pip:
      - accelerate==1.8.1
      - aiohappyeyeballs==2.6.1
      - aiohttp==3.13.2
      - aiosignal==1.4.0
      - annotated-doc==0.0.3
      - annotated-types==0.7.0
      - anyio==4.11.0
      - astor==0.8.1
      - async-timeout==5.0.1
      - attrs==25.4.0
      - bitsandbytes==0.48.2
      - blake3==1.0.8
      - blinker==1.9.0
      - cachetools==6.2.1
      - cbor2==5.7.1
      - certifi==2025.10.5
      - cffi==2.0.0
      - charset-normalizer==3.4.4
      - click==8.2.1
      - cloudpickle==3.1.1
      - compressed-tensors==0.11.0
      - cupy-cuda12x==13.6.0
      - cut-cross-entropy==25.1.1
      - datasets==4.3.0
      - depyf==0.19.0
      - diffusers==0.35.2
      - dill==0.4.0
      - diskcache==5.6.3
      - distro==1.9.0
      - dnspython==2.8.0
      - docstring-parser==0.17.0
      - einops==0.8.1
      - email-validator==2.3.0
      - exceptiongroup==1.3.0
      - fastapi==0.120.4
      - fastapi-cli==0.0.14
      - fastapi-cloud-cli==0.3.1
      - fastrlock==0.8.3
      - filelock==3.20.0
      - flask==3.1.2
      - frozendict==2.4.6
      - frozenlist==1.8.0
      - fsspec==2025.9.0
      - gguf==0.17.1
      - h11==0.16.0
      - hf-transfer==0.1.9
      - hf-xet==1.2.0
      - httpcore==1.0.9
      - httptools==0.7.1
      - httpx==0.28.1
      - huggingface-hub==0.36.0
      - idna==3.11
      - importlib-metadata==8.7.0
      - interegular==0.3.3
      - itsdangerous==2.2.0
      - jinja2==3.1.6
      - jiter==0.11.1
      - jsonschema==4.25.1
      - jsonschema-specifications==2025.9.1
      - lark==1.2.2
      - llguidance==0.7.30
      - llvmlite==0.44.0
      - lm-format-enforcer==0.11.3
      - markdown-it-py==4.0.0
      - markupsafe==3.0.3
      - mdurl==0.1.2
      - mistral-common==1.8.5
      - mpmath==1.3.0
      - msgpack==1.1.2
      - msgspec==0.19.0
      - multidict==6.7.0
      - multiprocess==0.70.16
      - networkx==3.4.2
      - ninja==1.13.0
      - numba==0.61.2
      - numpy==2.2.6
      - nvidia-cublas-cu12==12.8.4.1
      - nvidia-cuda-cupti-cu12==12.8.90
      - nvidia-cuda-nvrtc-cu12==12.8.93
      - nvidia-cuda-runtime-cu12==12.8.90
      - nvidia-cudnn-cu12==9.10.2.21
      - nvidia-cufft-cu12==11.3.3.83
      - nvidia-cufile-cu12==1.13.1.3
      - nvidia-curand-cu12==10.3.9.90
      - nvidia-cusolver-cu12==11.7.3.90
      - nvidia-cusparse-cu12==12.5.8.93
      - nvidia-cusparselt-cu12==0.7.1
      - nvidia-nccl-cu12==2.27.3
      - nvidia-nvjitlink-cu12==12.8.93
      - nvidia-nvshmem-cu12==3.3.20
      - nvidia-nvtx-cu12==12.8.90
      - openai==2.6.1
      - openai-harmony==0.0.4
      - opencv-python-headless==4.12.0.88
      - outlines-core==0.2.11
      - packaging==25.0
      - pandas==2.3.3
      - partial-json-parser==0.2.1.1.post6
      - peft==0.17.1
      - pillow==12.0.0
      - prometheus-client==0.23.1
      - prometheus-fastapi-instrumentator==7.1.0
      - propcache==0.4.1
      - protobuf==6.33.0
      - psutil==7.1.3
      - py-cpuinfo==9.0.0
      - pyarrow==22.0.0
      - pybase64==1.4.2
      - pycountry==24.6.1
      - pycparser==2.23
      - pydantic==2.12.3
      - pydantic-core==2.41.4
      - pydantic-extra-types==2.10.6
      - pygments==2.19.2
      - python-dateutil==2.9.0.post0
      - python-dotenv==1.2.1
      - python-json-logger==4.0.0
      - python-multipart==0.0.20
      - pytz==2025.2
      - pyyaml==6.0.3
      - pyzmq==27.1.0
      - ray==2.51.1
      - referencing==0.37.0
      - regex==2025.10.23
      - requests==2.32.5
      - rich==14.2.0
      - rich-toolkit==0.15.1
      - rignore==0.7.3
      - rpds-py==0.28.0
      - safetensors==0.6.2
      - scipy==1.15.3
      - sentencepiece==0.2.1
      - sentry-sdk==2.43.0
      - setproctitle==1.3.7
      - shellingham==1.5.4
      - shtab==1.7.2
      - six==1.17.0
      - sniffio==1.3.1
      - soundfile==0.13.1
      - soxr==1.0.0
      - starlette==0.49.3
      - sympy==1.14.0
      - tiktoken==0.12.0
      - tokenizers==0.22.1
      - torch==2.8.0
      - torchao==0.14.1
      - torchaudio==2.8.0
      - torchvision==0.23.0
      - tqdm==4.67.1
      - transformers==4.57.1
      - triton==3.4.0
      - trl==0.23.0
      - typeguard==4.4.4
      - typer==0.20.0
      - typing-extensions==4.15.0
      - typing-inspection==0.4.2
      - tyro==0.9.35
      - tzdata==2025.2
      - unsloth==2025.10.12
      - unsloth-zoo==2025.10.13
      - urllib3==2.5.0
      - uvicorn==0.38.0
      - uvloop==0.22.1
      - vllm==0.11.0
      - watchfiles==1.1.1
      - websockets==15.0.1
      - werkzeug==3.1.3
      - xformers==0.0.32.post1
      - xgrammar==0.1.25
      - xxhash==3.6.0
      - yarl==1.22.0
      - zipp==3.23.0
prefix: /opt/conda/envs/transformer_env
```

然后安装依赖：
```shell
pip install -r requirements_qwen25.txt
```

**步骤 3：验证安装**
```python
# 验证关键包版本
python -c "import torch; print(f'PyTorch: {torch.__version__}'); import transformers; print(f'Transformers: {transformers.__version__}'); import peft; print(f'PEFT: {peft.__version__}')"
```

**步骤 4：导出环境（可选）**
如果需要将环境迁移到其他机器，可以使用 conda-pack 打包：
```shell
conda install -c conda-forge conda-pack
conda pack -n qwen25_training -o qwen25_training.tar.gz
```

## 使用环境

环境创建完成后，即可在训练任务中指定使用。请在训练方法配置中找到 **`conda_env`** 字段，并填入您创建的环境名称（例如：`my_training_env` 或 `transformer_env`）。

关于训练方法配置的详细说明，请参阅 [训练配置文档](../user-guide/training-methods.zh.md)。