# Training Parameter File Usage Guide

## Parameter Creation
Parameters can be created through the frontend interface following the [Training Parameter Profile](../user-guide/model-parameter-profile.md) specifications.

---

## Parameter Usage in Training Code

### Basic Parameter Handling
The Python template file `custom-template.py` pre-defines all optional/required parameters for training tasks. To use custom parameters from your configuration file, extend the existing argument parser while maintaining original parameter reception.

**Example Configuration**: 
 
| Parameter Label   | Parameter Name     | Value | Type | Required |
|-------------------|--------------------|-------|------|----------|
| Num Train Epochs  | `num_train_epoch`  | 1     | int  | Yes      |

**Implementation**:
```python
# Argument parsing
parser = argparse.ArgumentParser()
parser.add_argument('--num_train_epoch', type=int, required=True)

# Parse arguments
known_args, unknown_args = parser.parse_known_args()
args = known_args

# Parameter assignment
NumTrainEpoch = args.num_train_epoch
```

**Critical Notes**:
1. Type consistency between frontend definition and Python code is mandatory
2. Required parameters must have matching `required=True` declarations
3. Debug using argument inspection:
   ```python
   print("Known args:", known_args)    # Successfully parsed parameters
   print("Unknown args:", unknown_args) # Unrecognized parameters
   ```

---

### Optional Parameter Handling
For optional parameters, use conditional dictionary unpacking pattern:

```python
trainer = SFTTrainer(
    args=TrainingArguments(
        # Optional parameter injection
        **({"num_train_epochs": NumTrainEpoch} if NumTrainEpoch is not None else {}),
        **({"max_steps": MAX_STEPS} if MAX_STEPS is not None else {}),
        # Other fixed parameters
        per_device_train_batch_size=4,
        gradient_accumulation_steps=4,
        ...
    ),
    ...
)
```

**Best Practices**:  
1. Always provide fallback empty dict `{}` for conditional parameters  
2. Maintain parameter naming consistency between configuration and code  
3. Document optional parameters in both frontend labels and code comments  
