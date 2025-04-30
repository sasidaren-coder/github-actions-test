#!/bin/bash

CONFIG_FILE="$1"

# Example validation: Check partition count is less than 100
if grep -q 'partition:' "$CONFIG_FILE"; then
  PART_COUNT=$(grep 'partition:' "$CONFIG_FILE" | awk '{print $2}')
  if [[ $PART_COUNT -gt 100 ]]; then
    echo "Error: Partition count exceeds limit"
    exit 1
  fi
fi

# Add more checks (naming conventions, retention policies etc.) here

exit 0