# SD-Demo 实现说明

本文档详细说明 DeepExtension 平台中内置训练方法 **SD-Demo** 的技术实现方案。该示例作为只读参考，展示第三方训练代码与平台工作流的集成方法。

---

## 技术架构

### 实现基础
**SD-Demo** 基于 [SimpleTuner 项目](https://github.com/bghira/SimpleTuner.git) 的 LoRA 训练模块构建。为确保兼容性，我们对指定提交版本进行了以下调整：

- 依赖版本适配

- 入口脚本优化

- 数据接口标准化

[获取适配版本](../assets/datasets/SimpleTuner.zip)

---

## 环境配置

### 资源准备

#### 基础模型

平台要求基础模型存放于指定路径：
```
{deepextension_base_dir}/models/stable-diffusion-3.5-medium
```
> 注：支持任意兼容的 SD 系列模型

#### 数据集
训练数据集采用标准格式，可从以下位置获取：

[`sd-in-video`](../assets/datasets/sd-in-video.zip)

数据集上传流程详见：[数据集管理指南](../user-guide/dataset-management.zh.md)

#### 训练代码

将适配版 SimpleTuner 解压至项目根目录下的 `deep-e-python` 文件夹。

---

## 环境验证

### 本地测试流程
在集成前需完成环境验证：

```bash
# 创建隔离环境
conda create -n sd python=3.11 -y
conda activate sd

# 安装依赖
cd SimpleTuner/
pip install -U poetry pip -i https://pypi.tuna.tsinghua.edu.cn/simple --trusted-host pypi.tuna.tsinghua.edu.cn
poetry config virtualenvs.create false
poetry source add --priority=default tsinghua https://pypi.tuna.tsinghua.edu.cn/simple/
poetry lock
poetry install

# 执行验证
./train.sh
```

预期结果：脚本正常执行并完成预设迭代次数。

> **关键要求：必须通过本地验证后方可进行平台集成**

---

## 平台集成

### 入口实现
通过 `sd-demo.py` 入口文件实现训练任务调度，环境配置详见：[环境配置指南](how-to-configure-env.zh.md)

### 执行机制
平台采用标准化启动命令：
```python
cmd = ['conda', 'run', '-n', envName, 'python', pythonFile]
```

该设计具备以下优势：

- **模块化**：各训练方法独立运行

- **灵活性**：支持多环境并行

- **可维护性**：统一的执行接口

---

## 容器环境部署

### 方案一：实时安装
按照上述"环境验证"步骤在容器内执行。

### 方案二：预置环境
系统为 SD 类模型预设环境名称为 `sd`，可通过以下方式预置：

```bash
# 环境打包 原已装环境机器
conda install -c conda-forge conda-pack
conda pack -n sd -o sd.tar.gz

# 环境部署 需要新装依赖机器
cd {deepextension_dir}/conda/envs
mkdir -p sd
tar -xzf sd.tar.gz -C sd

# 容器内激活
docker exec -it deepE-training-prod bash
## 初次进入容器内部 
conda init
exit
source /opt/conda/envs/sd/bin/conda-unpack
# 你会看到
# bash: import: command not found
# bash: import: command not found
# bash: import: command not found
# bash: import: command not found
# bash: import: command not found
# bash: on_win: command not found
# bash: /opt/conda/envs/sd/bin/conda-unpack: line 48: syntax error near unexpected token `('
# bash: /opt/conda/envs/sd/bin/conda-unpack: line 48: `SHEBANG_REGEX = ('
```


---

## 技术验证

### 实现成果

- ✅ 第三方训练代码无缝集成

- ✅ 标准化工作流支持

- ✅ 生图模型训练任务调度

### 平台兼容性

- 支持多种 SD 基础模型

- 适配标准数据集格式

- 提供完整环境管理方案

---

## 总结

SD-Demo 成功验证了 DeepExtension 平台对复杂训练流程的集成能力，为后续生图模型训练任务的标准化提供了技术基础。

> DeepExtension —— 企业级 AI 训练流程标准化平台  
> 专业集成 | 稳定运行 | 高效调度