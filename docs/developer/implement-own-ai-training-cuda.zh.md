# 如何实现自定义训练方法

DeepExtension 支持您将自定义 AI 训练代码集成到其可视化界面驱动的工作流中。  
只要您的训练代码可以在独立的 Python 环境中运行，就有很大可能可以改造为在 DeepExtension 中执行。

本指南介绍了如何修改并注册您自己的训练脚本，使其成为一个自定义方法（如 `custom01`、`custom02`）供 DeepExtension 调用。

---

> 内置的训练方法 **SFT-Demo** 和 **GRPO-Demo** 的实现过程见  
> [我们是如何实现 SFT-Demo 和 GRPO-Demo（CUDA）的](implement-sft-grpo-demo.md)。这两者就是严格遵循本指南的方式实现的，您可以参考它们来实现自己的训练方法。

---

## 基本思路

只要您的训练代码满足以下条件，就可以集成至 DeepExtension：

- 可以接收来自 UI 的参数输入
- 支持日志回调函数 logging callback
- 使用标准接口保存模型

本质上，您只需完成以下四步：

1. 将您的训练代码复制到模板文件中
2. 接入参数输入
3. 附加日志回调函数
4. 模型保存与训练触发将由 DeepExtension 后台统一处理

---

## 涉及的文件

假设 `{deepextension_base_dir}` 是您安装 DeepExtension 的根目录。

进入目录 `{deepextension_base_dir}/deep-e-python`，您会看到以下文件：

- `custom-template.py`  
- `run_local_train_test_template.py`  

> `{deepextension_base_dir}/deep-e-python` 是所有 AI 相关代码的基础目录。  
> 除非特别说明，后续所有操作均应在该目录下进行。
> 
> **请勿修改**模板文件，务必在其副本上操作。

---

## 准备您的自定义训练方法

假设您要实现的训练方法文件是 `{deepextension_base_dir}/deep-e-python/custom01.py`，该方法会在 [训练方法管理](../user-guide/training-methods.md) 页面中列出。

### 步骤一：创建方法文件

> 如果 `custom01.py` 已存在，请先备份。

```bash
cp custom-template.py custom01.py
```

### 步骤二：将训练逻辑粘贴到定义区域

打开 `custom01.py`，您会看到如下代码块：

```python
#============ from here add your own train code

#============ end here with your own train code
```

请将您的训练逻辑粘贴到上述两行之间。

您的代码需定义以下对象：

- 具有 `save_pretrained()` 方法的 `model` 对象  
- 具有 `save_pretrained()` 方法的 `tokenizer` 对象  
- 具有 `train()` 方法的 `trainer` 对象  

如对象名称不同，请重命名为以上名称。

### 步骤三：映射 UI 参数

将以下 UI 参数接入训练逻辑中：

```text
MODEL_PATH, MAX_SEQ_LENGTH, LORA_RANK, LOAD_IN_4BIT
DATASET_PATH, MAX_INPUT_LENGTH, MAX_CONTENT_LENGTH, MAX_SAMPLES
NUM_GENERATIONS, MAX_GRAD_NORM, OUTPUT_DIR, MAX_STEPS
BATCH_SIZE, GRAD_ACCUM_STEPS, LEARNING_RATE, WARMUP_STEPS
PromptInputColumn, PromptOutputColumn
```

> 至少需正确接入 `MODEL_PATH` 和 `DATASET_PATH`。

### 步骤四：绑定日志回调函数

在 `trainer` 初始化中添加：

```python
trainer = ...(
    callbacks=[callback],
)
```

该操作用于将日志推送回 DeepExtension UI。

### 步骤五：移除模型保存与训练触发代码

**请勿包含以下代码：**

```python
trainer.train()
model.save_pretrained(...)
tokenizer.save_pretrained(...)
```

上述操作将由 DeepExtension 后台自动完成。

---

## 本地测试您的自定义代码

在通过 UI 执行之前，建议先在本地测试。

### 步骤 A：准备本地测试脚本

```bash
cp run_local_train_test_template.py run_local_train_test.py
```

### 步骤 B：修改以下字段

在 `run_local_train_test.py` 中替换：

- `'your-model_path'` → 实际基础模型的绝对路径
- `'your-dataset_path'` → 实际数据集的绝对路径
- `'your-output_dir'` → 输出目录
- `'your-custom-file.py'` → `custom01.py`
- 其他您希望测试的训练参数

### 步骤 C：运行

```bash
python3 run_local_train_test.py
```

### 步骤 D：验证

确保：

- 训练过程顺利完成
- 输出写入到指定目录中

---

## 一切就绪后

您现在可以在 DeepExtension 的 Web 界面中使用 **自定义训练方法 1** 启动训练任务。

关于如何启动训练任务，请参见：  
[模型训练](../user-guide/model-training.md)

---

*DeepExtension —— 让您的 AI 训练逻辑无缝接入企业级流水线，零后端改动。*
