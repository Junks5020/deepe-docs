# DeepImage
**DeepImage is a submodule of DeepExtension for working with image models. It supports image generation in any aspect ratio, including 1:1, 9:16, 16:9, and custom resolutions. It supports text-to-image, image-to-image, and image-to-image+ workflows.**

---
## Why DeepImage

- **Any aspect ratio generation**: Native support for 1:1, 9:16, 16:9, and any custom resolution, outputting high-quality images without the need for cropping.
- **Unified text-to-image / image-to-image / image-to-image+**: Complete text-to-image, image-to-image, and "image + text" hybrid generation on the same canvas without switching tools.
- **Plug-and-play custom models**: Directly load local or cloud PEFT checkpoints (LoRA, DyLoRA, etc.) for inference without merging; the model list clearly labels "Customized Models" and "Third-party Models" for easy identification.
- **Batch generation**: Generate up to 4 variations with a single prompt and preview in real time; supports side-by-side comparison of results from different models.

---
## Notes

- Ensure the image model you use is compatible with DeepImage; using the latest model versions is recommended.
- For **trained models**, their corresponding **Customized Models** should theoretically produce the same inference outputs after merging.
- For best results, use **detailed** and **accurate** prompts; avoid vague or overly general descriptions.
- Compare **results across different models** to choose the optimal one.
- The aspect ratio can follow the **ratio of the first uploaded image**, or be set to a custom ratio.

---
## Typical Use Cases

This module's core functionality is based on diffusion model technology, providing various modes of image generation and transformation capabilities, designed to serve professional scenarios such as model evaluation, content enhancement, and creative generation.

### **1. Text-to-Image**

**Function Description**
This function enables end-to-end generation from text semantics to visual content. The system synthesizes pixel-level images matching the text by parsing natural language prompts in the latent space.

**Operational Process**

1. **Prompt**: Enter a specific description of the desired image in the "Prompt" text box. Using structured, detailed sentences is recommended (e.g., "An astronaut riding a horse through an autumn forest, cinematic lighting, surrealist style").

2.  **Execute Generation**: Click the **【Generate】** button to submit the task to the rendering queue. The generated result will be displayed in the output area.

**Typical Application Scenarios**

- Rapid prototyping of ideas and automated generation of visual content.

- Validating the model's ability to render semantic diversity and complex scenes.

### **2. Image-to-Image**

**Function Description**
Generates content variations, performs style transfer, or conducts partial reconstruction based on an input image. The system uses the source image as an initial condition, integrating semantic and structural information during the generation process to output diverse variants.

**Operational Process**

1.  **Upload Base Image**: Load a reference image via the **【Upload Image】** button in the lower left corner of the interface.

2.  **Set Quantity**: Use the **"Number of Images to Generate"** parameter to control the total number of images output per task, useful for batch generation or multi-result selection.

3.  **Execute Generation**: Click **【Generate】**. The system will generate the specified number of derivative results based on the input image.

**Typical Application Scenarios**

-   Generating multiple style variations based on the same composition for A/B testing or content extension.

-   Batch generating alternative backgrounds, textures, or color schemes while preserving the main structure.

### **3. Enhanced Image-to-Image**

**Function Description**
Integrates dual conditional inputs—both an image and text—enabling refined control over the generated output. The image serves as the base for structure and content, while the text provides semantic modification and style guidance, jointly influencing the generation process.

**Operational Process**

    1.  **Provide Dual Inputs**:

        -   Upload a base image as a visual reference.

        -   Enter instructions for desired content changes or style in the prompt box (e.g., "Replace the sky with a dusk scene, add flying birds").

    2.  **Execute and Iterate**:

        -   Click **【Generate】** to obtain initial results.

        -   The results area provides the following operation options:

            -   **【Save】**: Archive satisfactory images to the project or local storage.

            -   **【Reference】**: Set the current generated image as the base image for the next generation round, enabling progressive refinement and iterative visual development.

            -   **【Delete】**: Remove unsatisfactory results to maintain a clear workflow.


**Typical Application Scenarios**

-   Multi-round refinement based on an initial concept sketch, gradually approaching the target visual expression.

-   Creative tasks requiring continuous visual evolution, such as character design or scene building.

---

*DeepExtension — Make prompts more precise, and model management more enterprise-grade*