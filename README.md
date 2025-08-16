---

```markdown
# Proxmox No-Subscription Patch Script

This script removes the "No valid subscription" warning dialog from the Proxmox web interface by patching `proxmoxlib.js` directly on the host system.

> ⚠️ This patch is intended for **educational and personal use only**. It modifies core Proxmox files and may be overwritten by updates. Use at your own discretion.

---

## 📦 Features

- Creates a backup of the original `proxmoxlib.js` file
- Detects whether the patch has already been applied
- Removes the subscription warning block safely
- Designed for direct use on a Proxmox host

---

## 🧭 Installation & Usage

### 1. SSH into your Proxmox host

```bash
ssh root@your-proxmox-host
```

### 2. Create a scripts directory (optional but recommended)

```bash
mkdir -p /root/scripts
cd /root/scripts
```

### 3. Create the script file

```bash
nano patch_proxmox_nosub.sh
```

Paste the following content:

```bash
#!/bin/bash

TARGET="/usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js"
BACKUP="${TARGET}.bak"

# Ensure script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root."
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
```

### 4. Make the script executable

```bash
chmod +x patch_proxmox_nosub.sh
```

### 5. Run the script

```bash
./patch_proxmox_nosub.sh
```

---

## 🔁 Optional Enhancements

- **Versioned backups**:
  ```bash
  cp "$TARGET" "${TARGET}.bak.$(date +%F-%T)"
  ```
- **Symlink for global access**:
  ```bash
  ln -s /root/scripts/patch_proxmox_nosub.sh /usr/local/bin/patch_proxmox_nosub
  ```

---

## 🛠 Notes

- This patch may be overwritten by future Proxmox updates. Consider reapplying after upgrades.
- Tested on Proxmox VE 7.x and 8.x.
- Script assumes default file path for `proxmoxlib.js`. Adjust if your installation differs.

---

## 📜 License

MIT License — feel free to fork, adapt, and improve.

```

