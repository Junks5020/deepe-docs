
# Fine-Tuning Small Models with GRPO: Improving the Understanding of Time Range and Granularity

In real-world business scenarios, it's often necessary to convert user natural language instructions into structured parameters. For example:

> "today=20300720 Business requirement: show the planned production quantities between the same date in the last year and today in day and week"

Although this seems like a simple sentence on the surface, it requires the AI to accurately understand the temporal context and generate corresponding structured output, such as:

```json
{"from":"2029-07-20", "to":"2030-07-20", "granularity":["Day","Week"]}
```

In testing multiple mainstream large models (such as ChatGPT and DeepSeek), we found that these models generally produce stable and expected structured JSON results. However, the key question is:

> **Can small models (like 7B or 8B scale) achieve the same capability through fine-tuning?**

This is the starting point and research direction of this fine-tuning experiment.

---

## Motivation for Fine-Tuning: Empowering Small Models with "Time Awareness"

We believe that truly practical AI tools should be low-threshold, deployable, and not dependent on closed-source models. This makes improving small model capabilities especially important.

This post advocates that practical AI tools should have low entry barriers, easy deployment, and no dependency on closed pre-trained models. Enhancing small model capabilities is crucial in this context. For time range extraction and granularity recognition tasks, this experiment aims to verify two key questions:

- Can small models acquire accurate time-awareness through effective fine-tuning?
- For tasks that are "structurally clear and logically defined", which fine-tuning method yields the best results?

---

## Why GRPO Was Chosen

Compared to traditional Supervised Fine-Tuning (SFT) or Reinforcement Learning with Human Feedback (RLHF), GRPO (Guided Reinforcement with Prompt Optimization) is more efficient when data is limited, so it's a great fit for engineering tasks where structured answers are expected, but training samples are hard to collect.

In this task, the output is a clear JSON object, with the following traits:

- Standardized and measurable answers
- The training objective allows for multiple valid outputs rather than requiring a single correct answer
- Reward functions can be defined based on rules across multiple dimensions

Considering all these, GRPO was selected as the core training method for this experiment.

---

## Dataset Construction and Structure Design

When using GRPO, the training dataset structure is extremely simple. Each training sample consists of:

- A `prompt` with a corresponding `completion`
- The prompt is a natural language context including a specific time marker (today=xxxxxx) and a business requirement description
- The completion is the structured JSON output the model must generate

Examples:

- prompt: today=20300301 Business requirement: view financial performance from Q1 2029 to Q2 2030, display by month and quarter  
  completion: {"to":"2030-06-30","from":"2029-01-01","granularity":["Month","Quarter"]}

- prompt: today=20300720 Business requirement: show the planned production quantities between the same date in the last year and today in day and week
  completion: {"to":"2030-07-20","from":"2029-07-20","granularity":["Day","Week"]}

The dataset used in this experiment contains 1103 samples. Some were derived from real customer queries; others were generated and augmented using high-quality large models.

---

## Reward Function: Multi-Dimensional Definition of High-Quality Answers

GRPO's strength lies not just in training simplicity but in its flexibility to define high-quality answer standards. For this task, we designed multi-dimensional reward functions to comprehensively evaluate model output:

- JSON structure completeness and parseability
- Correct date formatting, logical consistency, and appropriate time coverage
- Inclusion and exact match of expected time granularities
- Logical consistency between `today` tag and generated dates (e.g., correct time calculations)

Each dimension has its own scoring mechanism, and the final reward is a weighted combination of all scores. This design ensures the model doesn't merely aim for "correct format" but deeply understands the logic behind time expressions, producing answers that truly meet user needs.

---

## Training Environment and Duration

Training was conducted on a local server with a single NVIDIA GeForce RTX 4090 GPU (24GB VRAM), using CUDA and the DeepExtension framework for full-process training.

We fine-tuned different model sizes including 1.5B, 7B, and 8B models. Training for each was completed within one hour.

---

## Training Outcome: Loss Curve and Reward Feedback

Here are the Loss and Reward curves during training:

- ![Training Loss Curve](curve.png)
- ![Reward Score Curve](reward.png)

It’s evident that the model quickly learned the structural and logical patterns during training. The reward values steadily increased, indicating continuous performance improvement.

---

## Final Results: Model Evaluation Comparison

Using DeepExtension’s Model Assessment functionality, we conducted detailed comparative evaluations across multiple model configurations. Key comparison results:

1. **Original Qwen2.5-7B vs Fine-Tuned Qwen2.5-1.5B**  
   → Wins: 23, Ties: 68, Losses: 1012

2. **Fine-Tuned Qwen2.5-7B vs Fine-Tuned Qwen2.5-1.5B**  
   → Wins: 1079, Ties: 23, Losses: 1

The results show that the fine-tuned 7B model performed exceptionally well in most scenarios, demonstrating high stability and accuracy—fully meeting production deployment standards. Based on this, we adopted the fine-tuned Qwen2.5-7B model as the main production model for this task.

---

## Conclusion

This case study demonstrates:

- Small models are viable when trained with the **right strategy**
- GRPO shows significant advantages for rule-driven tasks like time range extraction
- Designing effective reward functions is central to successful training
- With DeepExtension, the fine-tuning process can be executed efficiently and cost-effectively

> For researchers and practitioners seeking lightweight solutions for domain-specific tasks, this study offers a practical and efficient path forward.
