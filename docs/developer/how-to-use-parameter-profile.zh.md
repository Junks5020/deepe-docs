# 使用训练参数文件

## 参数创建
您可以通过前端界面按参考[训练配置文件](../user-guide/model-parameter-profile.zh.md)的文档创建参数。

---

## 训练代码中的参数使用

### 基础参数处理
Python模板文件`custom-template.py`已预定义了训练任务的所有可选/必选参数。要使用配置文件中的自定义参数，您需要在保持原有参数接收的基础上扩展参数解析器。

**配置示例**：  

| 参数标签       | 参数名称          | 值 | 类型   | 是否必填 |
|----------------|-------------------|----|--------|----------|
| 训练周期数     | `num_train_epoch` | 1  | int    | 是       |

**实现代码**：
```python
# 参数解析
parser = argparse.ArgumentParser()
parser.add_argument('--num_train_epoch', type=int, required=True)

# 解析参数
known_args, unknown_args = parser.parse_known_args()
args = known_args

# 参数赋值
NumTrainEpoch = args.num_train_epoch
```

**关键注意事项**：
1. 前端定义与Python代码中的参数类型必须一致  
2. 必填参数必须声明`required=True`  
3. 使用以下方式调试参数：  
   ```python
   print("已知参数:", known_args)    # 成功解析的参数
   print("未知参数:", unknown_args)  # 未能识别的参数
   ```

---

### 可选参数处理
对于可选参数，使用条件字典解包模式：

```python
trainer = SFTTrainer(
    args=TrainingArguments(
        # 条件参数注入
        **({"num_train_epochs": NumTrainEpoch} if NumTrainEpoch is not None else {}),
        **({"max_steps": MAX_STEPS} if MAX_STEPS is not None else {}),
        # 其他固定参数
        per_device_train_batch_size=4,
        gradient_accumulation_steps=4,
        ...
    ),
    ...
)
```

**最佳实践**：  
    1. 始终为条件参数提供空字典`{}`作为回退  
    2. 保持配置和代码中的参数命名一致性  
    3. 在前端标签和代码注释中都记录可选参数  
