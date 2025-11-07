# deepe_sd_series 部署工具

## 概述

DeepExtension 框架支持自定义部署平台集成。`deepe_sd_series` 是官方提供的标准自定义推理容器，用户也可自行构建部署工具，实现训练模型的快速部署。

本文档介绍 DeepExtension 与 `deepe_sd_series` 的联合使用方法。

## 使用场景

虽然 Ollama 支持大多数主流模型的部署，但仍存在部分模型缺乏原生支持。为提升使用灵活性，系统支持用户主动配置部署环境，并通过指定推理代码实现模型部署。

当前 `deepe_sd_series` 支持对 `stable-diffusion-3.5-medium` 训练后模型的推理部署。

## 系统要求

### 硬件要求
- GPU: NVIDIA GPU with 8GB+ VRAM (推荐 12GB+)
- 内存: 16GB+ RAM
- 存储: 50GB+ 可用空间

### 软件要求
- Docker: 20.10+
- NVIDIA Container Toolkit
- CUDA: 11.8+

## 安装方法

### 1. 环境准备
确保系统已安装 Docker 和 NVIDIA Container Toolkit：
```bash
# 验证 Docker 安装
docker --version

# 验证 NVIDIA Container Toolkit
nvidia-ctk --version
```

### 2. 部署执行
执行 GitHub 仓库中的 `./sd_docker_run.sh` 脚本即可安装并部署：

```bash
# 添加执行权限
chmod +x ./sd_docker_run.sh

# 执行部署脚本
./sd_docker_run.sh
```

### 脚本内容详解
脚本包含以下步骤：

```bash
# 打包基础镜像
docker build -f Dockerfile.base -t flux-base:latest --load .

# 打包应用镜像
DOCKER_BUILDKIT=0 docker build -t flux-app:latest .

# 运行容器
docker run -d --name flux_app_prod --gpus all -p 5051:5050 \
  -v /home/cicd/workspace/tongrui/fluxUse/flux_docker/flux_models:/app/flux_models \
  -v ./imageGeneration:/app/generated_images \
  -v ./flux_app/models_config.yaml:/app/models_config.yaml:rw \
  -v ./models:/app/models \
  -e CUDA_VISIBLE_DEVICES=0 -e PYTHONPATH=/app \
  flux-app:latest
```



## 故障排除

### 常见问题

1. **GPU 无法访问**
   ```bash
   # 验证 GPU 访问
   docker run --rm --gpus all nvidia/cuda:11.8-base nvidia-smi
   ```

2. **端口冲突**
   - 确保端口 5051 未被其他进程占用
   - 可修改脚本中的端口映射 `-p 5051:5050`

3. **存储权限问题**
   - 确保挂载目录具有读写权限
   - 检查 Docker 容器对挂载目录的访问权限

4. **模型加载失败**
   - 验证模型文件路径是否正确
   - 检查模型文件完整性
   - 查看容器日志获取详细错误信息

### 日志查看
```bash
# 查看容器日志
docker logs flux_app_prod

# 实时查看日志
docker logs -f flux_app_prod
```


## 技术支持

如遇问题，请：
1. 查看容器日志获取详细错误信息
2. 验证环境配置是否符合要求
3. 参考 GitHub 仓库的 Issues 页面
4. 联系技术支持团队