
# Document Embedding

The **Document Embedding** module in DeepExtension allows users to convert documents into vector representations 
for use in **retrieval-augmented generation (RAG)** and related knowledge-aware AI workflows. This is especially 
useful for enterprise applications that require grounding LLM outputs in internal documentation.

---

## Create a Knowledge Base

To set up a new Knowledge Base:

1. Click **"Create a Knowledge Base"** on the Embedding page.  
2. Fill in the **Knowledge Base name** and a short **description**.  
3. Select an embedding model. If no models appear, register a usable embedding model via [Thirdparty 
Models](thirdparty-models.md).  
4. Click **"Save"** — your Knowledge Base will be created immediately.

---

## Add Embedded Documents

To add documents to an existing Knowledge Base:

1. Click **"Edit"** on the Knowledge Base you want to modify.  
2. You’ll see a list of already embedded documents (initially empty).  
3. Click **"Upload Document"**, then select a file in `.pdf`, `.docx`, `.txt`, `.xlsx`, or `.csv` format from your 
local directory.  
4. Choose whether to enable **“Parsing During Creation”** (this will trigger immediate embedding using the 
selected model) or skip for later parsing.  
5. Click **"Execute"** to begin uploading. The process runs in **batch mode**.  
6. If an error occurs, click **"Log"** to inspect detailed error messages.

---

## Document Embedding Behavior

While document upload and embedding are supported, full **Knowledge Base search and RAG-style retrieval** are 
still under development and listed on our roadmap for future releases.

---

*DeepExtension — Make your documents searchable, contextual, and ready for generation*

