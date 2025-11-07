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

- **Text-to-Image**: Generate images based on text descriptions.
- **Image-to-Image**: Transform an existing image or generate a new one based on it.
- **Image-to-Image+**: Combine text descriptions with an existing image to generate a new image.

---

*DeepExtension — Make prompts more precise, and model management more enterprise-grade*