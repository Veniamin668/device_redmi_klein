<div align="center">

# 🌲 Device Tree for Redmi A3x (`klein`)

[![Maintainer](https://img.shields.io/badge/Maintainer-Veniamin688-blue?style=for-the-badge&logo=github)](https://github.com/Veniamin688)
[![Platform](https://img.shields.io/badge/Platform-Unisoc-orange?style=for-the-badge&logo=android)](https://github.com/Veniamin688)
[![Network](https://img.shields.io/badge/Network-leave%20fork%20network-purple?style=for-the-badge)](https://github.com/Veniamin688)

<p align="center">
  <i>The ultimate custom device tree workspace for building top-tier recovery & custom ROMs.</i>
</p>

---

### 🌐 Jump to Language / Навигация по языкам
[**🇺🇸 English**](#-english) &nbsp;&bull;&nbsp; [**🇷🇺 Русский**](#-русский)

</div>

---

## 🇺🇸 English

### 📱 Device Overview

> [!NOTE]
> This repository contains a custom device tree for building software, recoveries, and custom ROMs for the **Redmi A3x** (codename: `klein`).

<br>

| Feature | Specification |
| :--- | :--- |
| 🏷️ **Model** | Redmi A3x |
| 🔤 **Codename** | `klein` |
| 🧠 **Platform** | Unisoc |
| 👤 **Author / Fork** | `Veniamin688` / KSN (leave fork network) |

---

### ⚙️ Quick Setup

Clone this repository into your source tree structure (e.g., into `device/xiaomi/klein`):

```bash
git clone [https://github.com/Veniamin688/device_redmi_klein](https://github.com/Veniamin688/device_redmi_klein) device/xiaomi/klein
BoardConfig.mk — Base hardware configurations, partition sizes, and architecture flags.device.mk — Specific packages, proprietary properties (system.prop), and overlay configurations.extract-files.sh — Script to extract vendor blobs from stock firmware.[!WARNING]Use at your own risk. The author is not responsible for bricked devices.🇷🇺 Русский📱 Обзор устройства[!NOTE]Этот репозиторий содержит кастомное дерево устройства (Device Tree) для сборки софта, рекавери и прошивок на Redmi A3x (кодовое имя: klein).ХарактеристикаПараметр🏷️ МодельRedmi A3x🔤 Кодовое имяklein🧠 ПлатформаUnisoc👤 Автор / ФоркVeniamin688 / KSN (leave fork network)⚙️ Быстрая установкаКлонируйте репозиторий в структуру ваших исходников (например, в директорию device/xiaomi/klein):Bashgit clone [https://github.com/Veniamin688/device_redmi_klein](https://github.com/Veniamin688/device_redmi_klein) device/xiaomi/klein
BoardConfig.mk — базовые конфигурации железа, разделов и архитектуры.device.mk — специфичные пакеты, прошивки, свойства (system.prop) и настройки overlay.extract-files.sh — скрипт для вытаскивания вендорских блобов из стоковой прошивки.[!WARNING]Используйте на свой страх и риск. Автор не несет ответственности за превращение вашего девайса в «кирпич».
