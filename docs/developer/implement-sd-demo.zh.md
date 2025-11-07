# SD-Demo 实现说明

本文档说明了 DeepExtension 内部如何实现内置训练方法 **SD-Demo**。

SD-Demo 是一个只读参考示例，展示了如何将第三方训练代码集成到 DeepExtension 的工作流中。

---

## 示例来源

**SD-Demo** 基于 [SimpleTuner 项目](https://github.com/bghira/SimpleTuner.git) 中的 LoRA 训练实现。由于仅对指定哈希值版本进行测试，且对依赖版本和入口脚本进行了微调，我们提供了调整后的可用下载包。

[获取 SimpleTuner 调整版本](../assets/datasets/SimpleTuner.zip)

---

## 前提条件：本地运行环境准备

默认情况下，SD 示例从目录读取数据集，而 DeepExtension 要求以文件作为输入格式。

### 基础模型（本地）

请确保已下载兼容的基础模型（如 `stable-diffusion-3.5-medium`）至以下路径：

```
{deepextension_base_dir}/models/stable-diffusion-3.5-medium
```

> 提示：您也可以使用其他任意本地可用的 SD 兼容模型。

### 数据集（本地）

SD-Demo 使用的数据集位于 SimpleTuner 目录中：

```
SimpleTuner/datasets/sd3.5_generated_hard_examples
```

> 注意：由于 SimpleTuner 项目的局限性，当前数据集采用固定路径，后续将接入系统统一管理。

---

## 环境安装与本地测试

在集成前，请先验证 SimpleTuner 示例代码是否可在本地正常运行：

```bash
# 创建 Conda 环境
conda create -n sd-demo python=3.11 -y
conda activate sd-demo

# 进入项目目录并安装依赖
cd SimpleTuner/
pip install -U poetry pip -i https://pypi.tuna.tsinghua.edu.cn/simple --trusted-host pypi.tuna.tsinghua.edu.cn
poetry config virtualenvs.create false
poetry source add --priority=default tsinghua https://pypi.tuna.tsinghua.edu.cn/simple/
poetry lock
poetry install

# 运行训练脚本
./train.sh
```

如果一切设置正确，脚本应能正常运行并在完成若干迭代后结束。

> **重要：仅当本地测试通过后，才建议进行后续集成步骤。**

---

## 集成 `sd-demo.py`

验证训练脚本后，我们创建了 `sd-demo.py` 入口文件。容器中的环境配置可见[如何配置环境](how-to-configure-env.zh.md)

现阶段，所有训练代码均采用统一格式启动：

```python
cmd = ['conda', 'run', '-n', envName, 'python', pythonFile]
```

这种方式具有更好的模块化特性，提供了一定的灵活性，并有利于后期的维护与扩展。

---

## 总结

- **SD-Demo** 展示了如何将基于 SimpleTuner 的训练流程集成到 DeepExtension 平台
- 验证了生图模型通过 DeepExtension 参与训练任务的可行性

---

> DeepExtension —— 将真实训练流程纳入您的企业 AI 栈。
> 无需 hack，无需绕路，只需干净整合。