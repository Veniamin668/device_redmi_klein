# 🌲 Device Tree for Redmi A3x (`klein`)

Custom device tree workspace for building recoveries and custom ROMs for the **Redmi A3x**.

---

## 📱 Device Specifications

| Feature | Specification |
| :--- | :--- |
| **Device** | Redmi A3x |
| **Codename** | `klein` |
| **Platform** | Unisoc |
| **Maintainer** | [Veniamin688](https://github.com/Veniamin688) |
| **Network** | KSN (leave fork network) |

---

## ⚙️ Quick Setup

To use this device tree, clone it into your local source tree structure:

```bash
git clone [https://github.com/Veniamin688/device_redmi_klein](https://github.com/Veniamin688/device_redmi_klein) device/xiaomi/klein
```

📂 Tree Structure

    [!NOTE]
    Main configuration files included in this device tree:

    BoardConfig.mk — Hardware architecture, partition sizes, and board-specific flags.

    device.mk — Packages, overlay configurations, and system properties.

    extract-files.sh — Script for extracting proprietary blobs from stock firmware.

    [!WARNING]
    Use this device tree at your own risk. The author is not responsible for any bricked devices or data loss.
