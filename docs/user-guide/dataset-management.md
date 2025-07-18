# Dataset Management  

The **Dataset Management** module is a core component of DeepExtension, designed for structured data processing. It supports standardized dataset uploads, versioned management, and end-to-end tracking, providing high-quality data for model training and evaluation.  

## Key Features  
- Supports **JSONL** format datasets  
- Handles both **single-file** and **multimodal** datasets  
- Asynchronous background processing for stable large-file uploads  
- Comprehensive validation and error logging  
- **Coming Soon**: Version control (under development)  

> **Note**: Currently, only **JSONL** format is supported. For other formats (JSON/CSV/Parquet), please preprocess using conversion tools. Native support for additional formats is on our roadmap.  

---

## Dataset Upload Guide  

### Upload Process  
1. Navigate to **Datasets** → Click **【Upload Dataset】**  
2. Select dataset type:  

   - **Single-File Dataset**: Standalone JSONL file  
   - **Multimodal Dataset**: Folder containing JSONL + images  

3. Provide metadata:    

   - **Dataset Name** (required)  
   - **Description** (recommended for traceability)  

4. File selection:    

   - Single-file: Upload a JSONL file  
   - Multimodal: Select a properly structured folder 

5. Submit (processed asynchronously in the background)    
6. Check results:    

   - Success: Preview dataset  
   - Failure: View detailed error logs  

### Format Specifications  

#### Single-File Dataset  
1. Encoding: **UTF-8**  
2. Structural requirements:  

   - Each line = **valid JSON object**  
   - All objects must match the **field structure** of the first line  
   - Empty values (`""`) allowed, but fields must exist  
   
3. Technical limits:   

   - Max **4,000 characters per line**  
   - No empty lines or comments  

#### Multimodal Dataset  
1. Folder structure:  
   ```
   dataset_folder/  
   ├── metadata.jsonl  # Primary data file  
   └── images/        # Associated images  
   ```  
2. JSONL example:  
   ```json  
   {  
       "images": [{"imageId": "sample.jpg"}],  
       "qa": []  
   }  
   ```  
3. Image requirements:

   - Must reside in the `/images` subfolder  
   - Filename must exactly match `imageId`  

---

## Dataset Lifecycle Management  
Each upload creates an independent dataset entity, supporting:    

- **Training**: Fine-tuning data source  
- **Evaluation**: Test question sets (supports automated grading with reference answers)  
- **Versioning**: Dataset rollback coming soon (Roadmap Q4)  

> **Best Practice**: Use the description field to document data sources, preprocessing steps, and key characteristics for future reuse.  

---  

*DeepExtension — Make your data structured, reusable, and ready for intelligent learning*


