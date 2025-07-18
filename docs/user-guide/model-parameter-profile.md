# Model Parameter Profile

## Overview
The **Model Parameter Profile** module is a customizable training parameter management tool provided by DeepExtension, enabling flexible creation and management of training configuration profiles.

---

## Creating a New Parameter File
Steps to create a new configuration profile:

   1. Navigate to the 「Training Configuration File」 page  
   2. Click the **Create new parameter file** button  
   3. Enter a name for the parameter file  
   4. Click **Create** to finalize

---

## Configuring Parameters
Process to add parameters to a configuration file:

   1. Locate the target file on the 「Training Configuration File」 page  
   2. Click the **View** button for the corresponding file  
   3. In the details page, click **Add Parameter**  
   4. Complete the following fields in the pop-up window:
      - `Parameter Label` (Display name)
      - `Parameter Name` (Program identifier)
      - `Parameter Type` (Data type)
      - `Parameter Value` (Value)
   5. Click **Add** to save the parameter configuration  
   > 📘 Refer to [Use Model Parameter Profile](../developer/how-to-use-parameter-profile.md) for detailed parameter specifications

---

## Using Parameter Files
Steps to apply configuration files in training tasks:

   1. Access the training task creation page  
   2. In the `Profile` selector  
   3. Select the desired parameter file  
   4. Launch the training task

> **Notes**

   > 1. Parameters in configuration files default to **optional parameters** - system-required parameters must be configured separately
   > 2. Training tasks executed via **Copy the Train** will automatically load the latest parameter configurations
   > 3. Historical parameter versions can be reviewed through 「Training Jobs」-「Logs」