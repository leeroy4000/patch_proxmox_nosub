Absolutely! Here's the complete `README.md` file with all the steps included:

```markdown
# Patch Proxmox No-Subscription Warning

This script removes the **"No valid subscription"** warning in Proxmox VE's web interface.

## Description

Proxmox VE displays a subscription warning when no valid enterprise subscription is detected. While this does not affect functionality, it can be intrusive. This script patches `proxmoxlib.js` to remove the warning.

## Usage

### 1. Backup the original file
The script automatically creates a backup of the file before making modifications:

```bash
/usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js.bak
```

### 2. Run the script
To apply the patch, execute the following command:

```bash
sudo bash patch_proxmox_nosub.txt
```

### 3. Verify the patch
If the warning still appears:
- The Proxmox UI may have cached the old version. Try **clearing your browser cache**.
- Restart Proxmox services for the changes to take effect:

```bash
systemctl restart pveproxy
```

### 4. Reapply the patch after updates
If a Proxmox update replaces `proxmoxlib.js`, you may need to **rerun the script**.

## Notes
- The script only modifies the file if the subscription warning exists.
- Always ensure you have a valid backup (`proxmoxlib.js.bak`) before making changes.

## Disclaimer
Use this script **at your own risk**. Modifying system files may impact stability or future updates.
```

You can save this as `README.md` and include it in your repository. Let me know if you'd like any further refinements!
