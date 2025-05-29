# 我们是如何实现 MLX-Demo（macOS）的

本文档说明了 DeepExtension 内部是如何实现内置训练方法 **MLX-Demo** 的。

MLX-Demo 是一个只读参考示例，展示了如何将第三方训练代码集成到 DeepExtension 的工作流中。

---

## 示例来源

- **MLX-Demo** 基于 [mlx-lm 项目](https://github.com/ml-explore/mlx-lm) 中的 LoRA 训练实现

在完成 [安装指南](developer/install.md) 中的步骤后，相关文件将位于：

```
{deepextension_base_dir}/deep-e-python/mlx_lm
```

---

## 前提条件：使其可在本地运行

默认情况下，MLX 示例从目录中读取数据集，而 DeepExtension 要求以文件为输入格式。  
安装过程中会自动执行 `prepare_mlx_changes.sh` 脚本，对其进行轻量修改以适配。

### 基础模型（本地）

请确保已下载兼容的基础模型（如 `Qwen2.5-1.5B-Instruct`）至以下路径：

```
{deepextension_base_dir}/models/Qwen2.5-1.5B-Instruct
```

> 您也可以使用其他任意本地可用的 MLX 兼容模型。

### 数据集（本地）

MLX-Demo 所使用的数据集位于：

```
examples/mlx-demo-train-dataset.jsonl
```

---

## 测试本地脚本

在集成前，请先验证 MLX 示例代码是否可在您本地运行：

```bash
cd {deepextension_base_dir}/deep-e-python
```

```bash
python3 -m mlx_lm.lora     --model ../models/Qwen2.5-1.5B-Instruct     --train     --data examples/mlx-demo-train-dataset.jsonl     --iters 2
```

如果一切设置正确，脚本应能正常运行并在几步迭代后结束。

> **仅当本地测试无误后，才建议进入后续集成步骤。**

---

## 集成 `mlx-demo.py`

验证训练脚本后，我们创建了 `mlx-demo.py` 文件。

与 [如何实现自定义训练（CUDA）](implement-own-ai-training-cuda.md) 中直接在脚本内编写训练逻辑的方式不同，  
`mlx-demo.py` 采用调用子进程的方式来执行训练命令：

```python
cmd = ['python3', '-m', 'mlx_lm','lora']
```

这种方式更具模块化特点，尤其适用于像 `mlx_lm` 这样的结构化外部模块，有助于后期维护与扩展。

---

## 总结

- **MLX-Demo** 展示了如何将基于 MLX 的训练流程集成至 DeepExtension 中。
- 它验证了即使是非 CUDA 的平台（如 macOS）也可通过 DeepExtension 参与训练任务。
- 脚本结构清晰，便于扩展和迁移到其他 MLX 兼容的微调工具。

---

> DeepExtension —— 将真实训练流程纳入您的企业 AI 栈。  
> 无需 hack，无需绕路，只需干净整合。
