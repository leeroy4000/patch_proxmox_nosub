#!/bin/bash

# Define target file and backup
TARGET="/usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js"
BACKUP="${TARGET}.bak"

# Ensure script is run with sudo
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root (use sudo)."
    exit 1
fi

# Check if target file exists
if [ ! -f "$TARGET" ]; then
    echo "Target file not found: $TARGET"
    exit 1
fi

# Create backup if it doesn't exist
if [ ! -f "$BACKUP" ]; then
    cp "$TARGET" "$BACKUP"
    echo "Backup created at $BACKUP"
else
    echo "Backup already exists at $BACKUP"
fi

# Patch the file only if the warning block exists
if grep -q "No valid subscription" "$TARGET"; then
    sed -i '/Ext.Msg.show({/,/});/d' "$TARGET"
    echo "Subscription warning removed from $TARGET"
else
    echo "No subscription warning block found. File may already be patched."
fi
