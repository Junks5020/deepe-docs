# 添加基础模型

在 DeepExtension 中启动训练或进行微调之前，必须先添加一个基础模型。由于该操作涉及访问后端文件系统，因此我们将其归类为 **开发者任务** —— 通常只有 **管理员用户** 才具备所需权限。

本指南将逐步介绍如何注册模型，例如 `Qwen2.5-7B-Instruct`，并将其纳入 DeepExtension 的训练流程中。

---

## 步骤一：下载模型文件

以 Hugging Face 上的模型为例，您可以使用搜索引擎搜索：

```
huggingface qwen2 5 7b instruct
```

通常会找到 `Qwen/Qwen2.5-7B-Instruct` 的官方页面。在 **“Files and versions”** 标签页中（请确保选择的版本为 `main`），下载以下文件：

- `config.json`
- 一个或多个 `*.safetensors` 模型权重文件
- `tokenizer.json`, `tokenizer_config.json` 等分词器文件

新建一个本地目录，命名为：

```
Qwen2.5-7B-Instruct
```

并将上述所有文件保存至该目录中。

---

## 步骤二：移动至 DeepExtension 的模型目录

假设 `{deepextension_base_dir}` 是 DeepExtension 的安装根目录。其下应包含一个名为 `models` 的子目录。

将刚才创建的模型目录移动至：

```
{deepextension_base_dir}/models/Qwen2.5-7B-Instruct
```

该目录路径将在注册时作为 **模型路径** 使用。

---

## 步骤三（可选）：获取部署模板（用于 Ollama）

如果您打算通过 **Ollama** 部署该模型，还需要准备一个 **模型部署模板**。

1. 在线搜索：
   ```
   ollama modelfile qwen2 5 7b instruct
   ```
2. 找到官方的 Ollama 模型页面（如 `qwen2.5:7b-instruct`）
3. 点击 **template** 链接
4. 复制模板内容，供后续粘贴使用

> 如果您暂不计划使用 Ollama 部署，可跳过此步骤。

---

## 步骤四：在 DeepExtension 中注册基础模型

进入 DeepExtension Web UI 的 **基础模型（Base Models）** 页面，点击 **“新增模型”**。

填写以下字段：

| 字段名称               | 示例值                         | 说明                                                         |
|------------------------|----------------------------------|--------------------------------------------------------------|
| 技术名称               | `qw2.5-7-i`                      | 简短且唯一的标识符                                           |
| 模型名称               | `Qwen2.5-7B-Instruct`            | 完整描述性名称                                               |
| 模型路径               | `models/Qwen2.5-7B-Instruct`     | 必须与步骤二中的目录路径一致                                 |
| 部署模板               | *（粘贴步骤三中的内容）*         | 仅在 Ollama 部署时需要填写                                   |

> 您也可以暂时留空 **部署模板** 字段，稍后通过 **“更新部署模板文件”** 操作补充。

---

## 步骤五：确认模型注册成功

返回 **基础模型** 页面并刷新，您应能看到新添加的模型已列出。

您还将看到：

- 磁盘占用信息（Qwen2.5-7B-Instruct 约为 **14GB**）
- 模型元信息及自动生成的 **模型卡**

完成！该基础模型现在已可用于微调、评估和部署。

---

有关部署模板与 Ollama 设置的更多说明，请参阅：

- [基础模型](../user-guide/base-models.md)  
- [部署工具配置](../user-guide/deployment-tool-configuration.md)
