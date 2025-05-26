# How We Implemented SFT-Demo and GRPO-Demo (CUDA)

This document shows how DeepExtension internally implemented two built-in training methods: **SFT-Demo** and **GRPO-Demo**.

These demos are read-only examples, showing how to plug in third-party training code into the DeepExtension workflow.  
They are direct applications of the principles described in [How You Implement Own Training (CUDA)](implement-own-ai-training-cuda.md).

---

## Demos Used

- **SFT-Demo** is based on Unsloth’s [Qwen2.5 (7B) Alpaca.ipynb]
- **GRPO-Demo** is based on [Qwen2.5 (3B) GRPO.ipynb]

We downloaded the original Python scripts from the Unsloth repository and prepared them for easier integration:

- `examples/qwen2_5_(7b)_alpaca.py`
- `examples/qwen2_5_(3b)_grpo.py`

Since both share the same integration pattern, this guide focuses only on `qwen2_5_(7b)_alpaca.py`.

---

## Prerequisites: Make It Runnable Locally

By default, the Unsloth examples download models and datasets from the internet.  
To work with DeepExtension, they must be localized.

### Base Model (Local)

Make sure a base model like `Qwen2.5-1.5B-Instruct` is downloaded and placed in:

```
{deepextension_base_dir}/models/Qwen2.5-1.5B-Instruct
```

> You can also use any other locally available compatible model.

### Dataset (Local)

- For **SFT-Demo**, the original dataset is `yahma/alpaca-cleaned`.  
  We extract the first 100 lines and save it to:

  ```
  examples/alpaca_data_cleaned_first_100_lines.jsonl
  ```

- For **GRPO-Demo**, the original dataset is `openai/gsm8k`.  
  We extract the first 100 lines and save it to:

  ```
  examples/openai-gsm8k_first_100_lines.jsonl
  ```

### Localized Training Scripts

We then created localized versions of the demo code:

- `examples/qwen2_5_(7b)_alpaca_local.py`
- `examples/qwen2_5_(3b)_grpo_local.py`

These modified versions use local paths instead of downloading.

> To check what has changed:
>
> ```bash
> diff examples/qwen2_5_\(7b\)_alpaca.py examples/qwen2_5_\(7b\)_alpaca_local.py
> ```

### Test the Localized Script

Now it's time to verify that the localized script runs correctly in your environment.

```bash
cd {deepextension_base_dir}/deep-e-python/examples
python3 qwen2_5_\(7b\)_alpaca_local.py
```

If everything is set up properly, the program should terminate normally without errors.

> **Only proceed to the next integration steps if this test succeeds.**

---

## Implementing `sft-demo.py`

This section shows how `sft-demo.py` was created by following the instructions in  
[How You Implement Own Training (CUDA)](implement-own-ai-training-cuda.md).

### Step 1: Copy Template

```bash
cd {deepextension_base_dir}/deep-e-python
cp custom-template.py sft-demo.py
```

### Step 2: Insert Training Code

Copy the entire content of `qwen2_5_(7b)_alpaca_local.py` and paste it into `sft-demo.py` between the two markers:

```python
#============ from here add your own train code
#    ← paste here
#============ end here with your own train code
```

### Step 3: Map Parameters

Connect DeepExtension's runtime parameters (e.g., `MODEL_PATH`, `DATASET_PATH`) to the variables used in your logic.

You can check the differences by:

```bash
diff sft-demo.py examples/qwen2_5_(7b)_alpaca_local.py
```

> 💡 Note: We intentionally did not map PromptInputColumn and PromptOutputColumn into the Training Methods.
> This was done to make the first runs easier and more approachable for new users.
> These parameters can be used for training methods that require field-level control over prompt formatting.

### Step 4: Add Logging Callback

Make sure your `trainer` initialization includes:

```python
trainer = ...(
    callbacks=[callback],
)
```

This allows DeepExtension to receive training logs.

### Step 5: Remove Manual Trigger and Save

Comment out or delete the following lines at the end of the code block:

```python
trainer.train()
model.save_pretrained(...)
tokenizer.save_pretrained(...)
```

In this step, we deleted all lines starting from the line `# @title Show current memory stats` (inclusive) up to, but not including, the line `#============ end here with your own train code`.

DeepExtension will handle training execution and saving.

---

## Test Your Code

Before connecting to the UI, validate that your method runs correctly in standalone mode.

### Step A: Create Local Test Script

```bash
cp run_local_train_test_template.py run_local_train_test.py
```

### Step B: Set Parameters

Modify the following fields in `run_local_train_test.py`:

- `'your-model_path'` → absolute path of `Qwen2.5-1.5B-Instruct`
- `'your-dataset_path'` → absolute path of `examples/alpaca_data_cleaned_first_100_lines.jsonl`
- `'your-output_dir'` → output folder for temp files
- `'your-custom-file.py'` → `sft-demo.py`

### Step C: Run Test

```bash
python3 run_local_train_test.py
```

### Step D: Verify Output

- Training completes successfully
- Output files appear in the specified directory
- No runtime errors or missing parameters

---

## Summary

- The **SFT-Demo** and **GRPO-Demo** are fully functional examples integrated into DeepExtension.
- They follow the same steps described in the custom method guide.
- Their origin is the Unsloth training notebooks, with slight adaptations for local use.
- You can run `diff` to understand what was changed.
- Both demos are great references for implementing your own method.

---

> DeepExtension — Bring real training examples into your enterprise AI stack.  
> No hacks. No surprises. Just clean integration.
