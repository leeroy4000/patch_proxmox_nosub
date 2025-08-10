#!/bin/bash

TARGET="/usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js"
BACKUP="${TARGET}.bak"

# Check if backup exists
if [ ! -f "$BACKUP" ]; then
    cp "$TARGET" "$BACKUP"
fi

# Patch the file only if the block still exists
if grep -q "No valid subscription" "$TARGET"; then
    sed -i '/Ext.Msg.show({/,/});/d' "$TARGET"
    echo "Subscription warning removed."
else
    echo "No subscription warning block found. File may already be patched."
fi
