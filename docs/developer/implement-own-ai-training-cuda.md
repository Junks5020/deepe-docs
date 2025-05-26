
# How to Implement Your Own Training

DeepExtension allows you to integrate your custom AI training code into its UI-driven workflow.  
If your training code can run in a standalone Python environment, it can likely be adapted to run inside DeepExtension.

This guide explains how to modify and register your own training script for use as a custom method (e.g., `custom01`, `custom02`).

---

> The built-in training methods **SFT-Demo** and **GRPO-Demo**, described in  
> [How We Implemented SFT-Demo and GRPO-Demo (CUDA)](implement-sft-grpo-demo.md), follow the exact same steps outlined in this guide. 
> You can use them as real, working references for implementing your own training method.

---
## Basic Idea

Any trainable Python code can be connected to DeepExtension as long as it meets the following:

- Can accept parameters passed from the UI
- Supports logging via a callback
- Saves models using standard interfaces

In essence, you only need to:

1. Copy your training code into a designated template
2. Wire up the parameter inputs
3. Assign the logging callback
4. Leave saving and training triggers to DeepExtension

---

## Files Involved

Let `{deepextension_base_dir}` be the directory where you installed your DeepExtension.

Navigate to the `{deepextension_base_dir}/deep-e-python` directory.
You will find the following files:

- `custom-template.py`  
- `run_local_train_test_template.py`  


> `{deepextension_base_dir}/deep-e-python` is the **base directory** for all AI-related code. 
> Unless otherwise specified, all subsequent operations should be performed within this directory.
> 
> Do **not** modify these base templates. Only work within a copy of the template.
> 
---

## Prepare Your Custom Training Method

Assume you want to implement `{deepextension_base_dir}/deep-e-python/custom01.py`, a customizable training method listed in [Training Method Management](../user-guide/training-methods.md).

### Step 1: Create Your Method File

> If `custom01.py` already exists, back it up first.

```bash
cp custom-template.py custom01.py
```
### Step 2: Paste Your Code into the Defined Block

Inside `custom01.py`, you will see the block:

```python
#============ from here add your own train code

#============ end here with your own train code
```

Paste your training logic between these two lines.

Your code should define:

- A `model` object with `save_pretrained()` method  
- A `tokenizer` object with `save_pretrained()` method  
- A `trainer` object with `train()` method  

If your object names differ, rename them accordingly to match.

### Step 3: Map Parameters

Assign the following parameters (passed from UI) into your code logic:

```text
MODEL_PATH, MAX_SEQ_LENGTH, LORA_RANK, LOAD_IN_4BIT
DATASET_PATH, MAX_INPUT_LENGTH, MAX_CONTENT_LENGTH, MAX_SAMPLES
NUM_GENERATIONS, MAX_GRAD_NORM, OUTPUT_DIR, MAX_STEPS
BATCH_SIZE, GRAD_ACCUM_STEPS, LEARNING_RATE, WARMUP_STEPS
PromptInputColumn, PromptOutputColumn
```

> At minimum, `MODEL_PATH` and `DATASET_PATH` must be connected correctly into your training code.

### Step 4: Attach Logging Callback

In your `trainer` initialization, add:

```python
trainer = ...(
    callbacks=[callback],
)
```

This is required to push logs back to DeepExtension UI.

### Step 5: Remove Final Training and Save Triggers

Do **not** include direct calls to:

```python
trainer.train()
model.save_pretrained(...)
tokenizer.save_pretrained(...)
```

These will be handled by DeepExtension's backend automatically.

---

## Test Your Custom Code Locally

Before testing and executing from the UI, test your custom method locally:

### Step A: Prepare Local Test Script

```bash
cp run_local_train_test_template.py run_local_train_test.py
```

### Step B: Modify the Following Fields

In `run_local_train_test.py`, replace:

- `'your-model_path'` → an absolute path of a registered base model
- `'your-dataset_path'` → an absolute dataset file path
- `'your-output_dir'` → a folder to write temporary output
- `'your-custom-file.py'` → `custom01.py`
- Any other training parameters you want to test

### Step C: Run

```bash
python3 run_local_train_test.py
```

### Step D: Verify

Ensure:

- Training completes successfully
- Output files are written to `your-output_dir`

---

## If All Looks Good

You can now start a training job using the **Custom Training 1** method directly from the DeepExtension UI.

For how to launch a training job, see:  
[Model Training](../user-guide/model-training.md)

---

*DeepExtension — Bring your AI training logic into an enterprise-grade pipeline, with zero backend hacks.*
