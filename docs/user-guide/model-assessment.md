
# Model Assessment

The **Model Assessment** module in DeepExtension provides a powerful, batch-based framework 
for evaluating and comparing language model outputs using real-world datasets. It is designed 
to help you assess model behavior, quality, and alignment — both quantitatively and 
qualitatively — at scale.

---

## Assessment Modes

DeepExtension supports four flexible assessment modes:

- **Single Candidate**: Generate answers from one model — no judgment, just output.
- **Two Candidates**: Generate answers from two models for side-by-side comparison.
- **1 Candidate + 1 Judge**: A judge model evaluates a single model's answer based on 
predefined criteria.
- **2 Candidates + 1 Judge**: A judge model compares both answers and selects the better one 
with explanation or scoring.

---

## Create a New Assessment

1. Click **"Create a New"** on the Model Assessment page.
2. Select an **assessment mode**, **dataset**, and **sample size** (default: all rows).  
   - Datasets support image fields. Users can select datasets containing images to enable vision model assessment.
3. Choose **Model A**, and if applicable, **Model B** and the **Judge Model**. Model selection follows the same scope and rules as described in [DeepText](deep-prompt.md), and may include(including visual models):

    - Third-party API models (e.g., OpenAI, Anthropic, ModelScope, etc.)
    - Customized Models
    - Live models

4. Define prompts:

    - **Candidate System Prompt**: Standard system prompt for inference (see [DeepText](deep-prompt.md)). If blank, a default like *"I am an AI assistant."* is applied.
    - **Candidate User Prompt**: 
      - Supports dynamic placeholders like `{{column_name}}` to pull values from the dataset (e.g., `Give a short answer to the question: {{question}}`), `{{question}}` is the name of a field in a certain column of the dataset
      - Supports natural language prompts involving images (e.g., `Compare the differences between Picture 1 and Picture 2`). 
      - When using image fields in prompts, select image fields like `image1`, `image2` from the dropdown menu. Selected image fields will automatically be used as model inputs with adjustable order.
    - **Judge System Prompt**: Tells the judge model what criteria to use; can include `{{CandidateSystemPrompt}}`.
    - **Judge User Prompt**: 
      - Uses placeholders like `{{ResponseA}}`, `{{ResponseB}}`, `{{ref_answer}}` (e.g., `Compare answer A: {{ResponseA}} and B: {{ResponseB}} based on reference: {{ref_answer}}`)
      - When using image fields in prompts, select image fields like `image1`, `image2` from the dropdown menu. Selected image fields will automatically be used as model inputs with adjustable order.

---

## Preview Before Execution

Before launching the assessment, you may **preview the result** using up to 5 data samples to 
validate correctness:

- Click **"Preview"**
- Review model outputs and prompt injection
- If the dataset contains image fields, the preview interface will display corresponding images for the questions
- Adjust parameters as needed

Only when you're satisfied, click **"Submit the Assessment"** — the process will then run in 
**background mode**.

---

## View an Assessment

On the Model Assessment main page:

- Click **"View"** to inspect a completed assessment
- Three tabs will be available:
  - **Assessment Overview**: Displays all configuration details
  - **Log**: System logs during the background process
  - **Result**: Shows final results in table format. If the dataset contains image fields, the result page will display corresponding images for each question

---

## Download Results

Click **"Download"** next to a completed assessment to export results as a `.csv` file.

---

## Copy an Existing Assessment

To replicate and tweak an existing assessment:

- Open any completed assessment and go to the **Assessment Overview** tab
- Click **"Copy"**
- This will pre-fill all values, letting you make quick changes and run another assessment

---

*DeepExtension — Scalable, flexible, and explainable model evaluation built for the 
enterprise*

