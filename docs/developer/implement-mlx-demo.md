# How We Implemented MLX-Demo (MacOS)

This document explains how DeepExtension internally implemented the built-in training method: **MLX-Demo**.

The MLX-Demo serves as a read-only reference example that demonstrates how to integrate third-party training code into the DeepExtension workflow.

---

## Demo Source

- **MLX-Demo** is based on the LoRA training implementation from the [mlx-lm project](https://github.com/ml-explore/mlx-lm)

After following the [Installation Guide](developer/install.md), the necessary files are located at:

```
{deepextension_base_dir}/deep-e-python/mlx_lm
```

---

## Prerequisites: Make It Runnable Locally

By default, the MLX example reads datasets from directories, while DeepExtension requires file-based inputs.  
Some minor changes are necessary and are automatically applied when running `prepare_mlx_changes.sh` during installation.

### Base Model (Local)

Ensure a compatible base model (e.g., `Qwen2.5-1.5B-Instruct`) is downloaded to:

```
{deepextension_base_dir}/models/Qwen2.5-1.5B-Instruct
```

> You may use any other MLX-compatible base model available locally.

### Dataset (Local)

For the MLX-Demo, use the following dataset:

```
examples/mlx-demo-train-dataset.jsonl
```

---

## Test the Localized Script

Before integrating, verify that the MLX demo code runs correctly on your machine.

```bash
cd {deepextension_base_dir}/deep-e-python
```

```bash
python3 -m mlx_lm.lora \
    --model ../models/Qwen2.5-1.5B-Instruct \
    --train \
    --data examples/mlx-demo-train-dataset.jsonl \
    --iters 2
```

If everything is set up properly, the script should run and terminate without errors.

> **Only proceed to the next integration steps if this test is successful.**

---

## Integrating `mlx-demo.py`

After validating the training script, we created `mlx-demo.py`.

Unlike the CUDA demo described in [How You Implement Own Training (CUDA)](implement-own-ai-training-cuda.md), which embeds training logic directly inside a script,  
`mlx-demo.py` instead invokes training using a subprocess call:

```python
cmd = ['python3', '-m', 'mlx_lm.lora', ...]
```

This makes the integration more modular and easier to maintain when using well-structured external modules like `mlx_lm`.

---

## Summary

- **MLX-Demo** is a working example that shows how to integrate MLX-based training pipelines into DeepExtension.
- It demonstrates that even non-CUDA environments like MacOS can support training workflows via DeepExtension.
- The script structure makes it easy to replicate for other MLX-compatible fine-tuning tools.

---

> DeepExtension — Bring real training examples into your enterprise AI stack.  
> No hacks. No surprises. Just clean integration.
