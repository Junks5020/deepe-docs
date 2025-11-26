
# DeepText

**DeepText** is a powerful prompt experimentation tool within DeepExtension that allows users to design, 
test, and compare structured prompts across different model states and sources. It is designed for **business 
logic alignment**, **prompt evaluation**, and **reproducible model behavior** — all without writing code.

---

## What Makes DeepText Unique

Unlike traditional prompt playgrounds, DeepText provides **tight integration with your models and embedded enterprise documents**, enabling deeper control and more realistic testing environments.

Key features include:

- **Inference with Customized Models**: You can run prompts directly against **trained adapters or PEFT checkpoints** — even before they are merged into a base model. During model selection, **customized models** and all **third-party models** are listed, and each is clearly labeled by type.

- **Embedded Document Integration**: Reference enterprise documents or embedded knowledge bases directly 
inside your prompts. This is especially useful for retrieval-augmented generation (RAG) use cases.

- **System Prompt Control**: You are strongly encouraged to define a **System Prompt** — this guides model 
behavior and improves inference quality. If left blank, a default system message like *"I am an AI 
assistant."* will be automatically injected.

- **Side-by-Side Model Comparison**: Easily compare inference results from two different models by clicking 
**“Add a model”**. All prompt settings from the upper model can be cloned to the lower section using **“Copy 
parameters”**, enabling fair comparisons with minimal effort.

- **Realistic Production Simulation**: Test partial or intermediate training outputs in a simulated 
production flow. This allows for **early evaluation** of prompt effectiveness before full model deployment or 
merging.

- **Multimodal Image-to-Text**: Supports visual understanding tasks by **generating textual descriptions from images**, enabling applications like automated captioning and visual content analysis.

---

### Important Notes

- For **customized models**, the corresponding **complete models** (after merging) are expected to produce identical outputs during inference.
- We strongly recommend using **live models** for production scenarios, as they offer **significantly better inference speed and stability**.
- The inference capability for customized models is primarily intended for **validation and experimentation**, not for high-load or low-latency production usage.
- **Base models** are not available for direct inference here. If you wish to use them, we recommend deploying them first to benefit from **much faster performance**.

---

## Use Cases

- Evaluate prompt robustness across model versions  
- Compare inference behavior across different configurations for testing across multiple dimensions.
- Test business rules using real enterprise data  
- Validate document-aware inference
- Tune prompts for internal tools or APIs

---

## Next Steps

- Select the model type
- Start by selecting a model and input prompt  
- Embed reference data or system instructions as needed  
- Use the comparison mode to evaluate inference side by side  
- Share and log prompt tests with your team

---

*DeepExtension — Precision prompting meets enterprise-grade model management*

