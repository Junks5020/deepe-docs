# 我们是如何实现 SFT-Demo 和 GRPO-Demo（CUDA）的

本文档展示了 DeepExtension 是如何实现两个内置训练方法：**SFT-Demo** 和 **GRPO-Demo** 的。

这两个演示为只读示例，展示了如何将第三方训练代码接入 DeepExtension 的工作流。  
它们完全遵循 [如何实现自定义训练（CUDA）](implement-own-ai-training-cuda.zh.md) 中的指导原则。

---

## 使用的示例

- **SFT-Demo** 基于 Unsloth 的 [Qwen2.5 (7B) Alpaca.ipynb]
- **GRPO-Demo** 基于 [Qwen2.5 (3B) GRPO.ipynb]

我们从 Unsloth 仓库下载了原始 Python 脚本并进行了本地集成准备：

- `examples/qwen2_5_(7b)_alpaca.py`
- `examples/qwen2_5_(3b)_grpo.py`

由于这两个脚本的集成流程相同，本文仅聚焦于 `qwen2_5_(7b)_alpaca.py`。

---

## 前提条件：使其可在本地运行

默认情况下，Unsloth 示例从互联网下载模型与数据集。  
要与 DeepExtension 兼容，必须将其本地化。

### 基础模型（本地）

请确保如 `Qwen2.5-1.5B-Instruct` 的基础模型已下载并放置在：

```
{deepextension_base_dir}/models/Qwen2.5-1.5B-Instruct
```

> 也可使用其他本地可用的兼容模型。

### 数据集（本地）

- 对于 **SFT-Demo**，原始数据集为 `yahma/alpaca-cleaned`。  
  我们提取前 100 行，保存为：

  ```
  examples/alpaca_data_cleaned_first_100_lines.jsonl
  ```

- 对于 **GRPO-Demo**，原始数据集为 `openai/gsm8k`。  
  同样提取前 100 行，保存为：

  ```
  examples/openai-gsm8k_first_100_lines.jsonl
  ```

### 本地化训练脚本

我们创建了本地化版本的训练脚本：

- `examples/qwen2_5_(7b)_alpaca_local.py`
- `examples/qwen2_5_(3b)_grpo_local.py`

这些版本将所有下载路径改为本地路径。

> 查看变更内容：
>
> ```bash
> diff examples/qwen2_\(7b\)_alpaca.py examples/qwen2_\(7b\)_alpaca_local.py
> ```

### 本地运行测试

验证本地化脚本是否可以正常运行：

```bash
cd {deepextension_base_dir}/deep-e-python/examples
python3 qwen2_5_\(7b\)_alpaca_local.py
```

若一切配置正确，程序应正常退出且无报错。

> **仅在测试成功后，方可继续集成步骤。**

---

## 实现 `sft-demo.py`

本节展示如何基于  
[如何实现自定义训练（CUDA）](implement-own-ai-training-cuda.md) 创建 `sft-demo.py`。

### 步骤一：复制模板

```bash
cd {deepextension_base_dir}/deep-e-python
cp custom-template.py sft-demo.py
```

### 步骤二：插入训练代码

将 `qwen2_5_(7b)_alpaca_local.py` 全部内容复制粘贴到 `sft-demo.py` 中的指定区块：

```python
#============ from here add your own train code
#    ← 在此处粘贴
#============ end here with your own train code
```

### 步骤三：参数映射

将 DeepExtension 的运行参数（如 `MODEL_PATH`, `DATASET_PATH`）接入训练逻辑。

查看变更差异：

```bash
diff sft-demo.py examples/qwen2_5_(7b)_alpaca_local.py
```

> 💡 注意：我们有意未将 PromptInputColumn 和 PromptOutputColumn 映射进训练方法，  
> 这是为了降低首次运行的复杂度。  
> 若需控制提示字段，可在更高级方法中使用这两个参数。

### 步骤四：添加日志回调

确保您的 `trainer` 初始化包含以下参数：

```python
trainer = ...(
    callbacks=[callback],
)
```

用于将日志推送至 DeepExtension UI。

### 步骤五：移除手动调用

请注释或删除以下代码：

```python
trainer.train()
model.save_pretrained(...)
tokenizer.save_pretrained(...)
```

我们删除了从 `# @title Show current memory stats` 行起至 `#============ end here with your own train code` 之间的所有语句。

训练执行与模型保存将由 DeepExtension 自动处理。

---

## 本地测试方法

在连接 UI 前，请先在本地验证您的方法是否可正常运行。

### 步骤 A：创建测试脚本

```bash
cp run_local_train_test_template.py run_local_train_test.py
```

### 步骤 B：设置参数

修改 `run_local_train_test.py` 中以下字段：

- `'your-model_path'` → `Qwen2.5-1.5B-Instruct` 的绝对路径
- `'your-dataset_path'` → `examples/alpaca_data_cleaned_first_100_lines.jsonl` 的绝对路径
- `'your-output_dir'` → 输出目录
- `'your-custom-file.py'` → `sft-demo.py`

### 步骤 C：运行测试

```bash
python3 run_local_train_test.py
```

### 步骤 D：验证输出

确保：

- 训练正常结束
- 输出写入指定目录
- 无运行时错误或缺失参数

---

## 总结

- **SFT-Demo** 与 **GRPO-Demo** 是已集成至 DeepExtension 的完整训练示例。
- 它们严格遵循自定义方法的实现指南。
- 来源为 Unsloth 项目的训练笔记本，并做了本地化处理。
- 可使用 `diff` 对比变化点。
- 非常适合作为实现自定义方法的参考。

---

> DeepExtension —— 将真实训练流程纳入企业 AI 工程体系。  
> 无需 hack，无需绕路，只需干净整合。
