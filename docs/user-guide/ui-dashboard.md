# Dashbord

## 1. Page Overview

The navigation page serves as the central data overview interface of the system, providing users with comprehensive monitoring of training and evaluation activities. This page utilizes multi-dimensional data visualization components to display key performance indicators (KPIs) and system usage patterns in real-time.

## 2. Core Metrics Dashboard

### 2.1 Basic Statistical Indicators
- **Total Fine-tuning Sessions**: Cumulative number of model fine-tuning tasks executed
- **Model Evaluation Count**: Total number of completed model performance evaluation and testing tasks
- **Internal Dataset Count**: Total number of proprietary dataset resources managed by the system
- **Knowledge Base Count**: Number of constructed knowledge graph and document library instances
- **Base Model Count**: Total number of available base pre-trained models
- **Customized Model Count**: Number of personalized models that have undergone fine-tuning
- **Complete Model Count**: Number of mature models that have completed the full training pipeline
- **Live Model Count**: Number of models already deployed to the production environment

## 3. Data Visualization Components

### 3.1 Training Activity Trend Chart

**Component Type**: Time Series Bar Chart  

**Data Dimension**: Past 7 days  

**Metric Description**:

- X-axis: Date timestamps (accurate to the day)

- Y-axis: Number of fine-tuning training sessions executed per day

- Data Points: Daily training task counts

### 3.2 Base Model Usage Distribution

**Component Type**: Donut Chart  

**Statistical Dimension**: Selection frequency of each base model in fine-tuning tasks  

**Data Source**: Fine-tuning task configuration logs

### 3.3 Evaluation Mode Distribution Chart

**Component Type**: Proportional Tag Treemap  

**Visual Form**: Multiple colored rectangular blocks tiled in arrangement  

**Data Encoding**:

- Rectangle Area: Represents the usage frequency or proportion of the corresponding evaluation mode

- Rectangle Color: Distinguishes between different types of evaluation modes (e.g., Judge Mode, Evaluation Mode, Single Model Mode, etc.)

- Inline Text: Labels the evaluation type name along with its specific percentage value

**Business Value**: Intuitively displays the proportion of each evaluation mode, enabling quick identification of the currently predominant evaluation strategies.

### 3.4 Third-party Model Vendor Analysis

**Component Type**: Sunburst Chart (Multi-layer Pie Chart)

**Hierarchical Structure**:

- Inner Layer: Distribution of model vendors (e.g., Ollama, Silicon Flow, Black Forest Labs, etc.)

- Outer Layer: Usage details of specific models under each vendor

**Color Coding**: Different vendors use contrasting color schemes, while models under the same vendor use gradient shades.

---
