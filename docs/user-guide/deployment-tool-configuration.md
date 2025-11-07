# Deployment Tool Configuration

The **Deployment Tool Configuration** module in DeepExtension allows administrators to set up and manage the environment required to deploy **Complete Models**. This configuration is essential for enabling seamless integration with local deployment tools such as **Ollama**, with more tools like **LM Studio** planned for future support.

---

## Overview

This configuration ensures that DeepExtension can communicate properly with the deployment service (e.g., Ollama) to initiate and manage model deployment tasks.

---

## Add a Deployment Environment

To configure a deployment environment:

1. Click **"Add Deployment Environment"**
2. Enter the following details:
   - **Environment Name**: A recognizable name for the environment
   - **Address**: The IP or hostname where the deployment tool is running
   - **Port Number**: The port used by the deployment service

Once saved, DeepExtension will use this configuration when deploying models.

> Currently, **only one deployment environment** is supported at a time. If you add multiple environments, **only the last one entered will be used**.

---

## Important Notes

- This module is critical for ensuring the correct integration with local deployment services such as Ollama.
- If you attempt to deploy a model without setting this configuration, the system will prompt you to complete it first.

---

*DeepExtension is committed to expanding support for more deployment tools and environments to enhance flexibility and compatibility.*
