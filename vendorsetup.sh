#!/bin/bash

DEVICE_PATH="device/xiaomi/missi"

echo "===================================================="
echo "   🔥 ULTIMATE UNISOC PATCHER FOR REDMI A3X 🔥     "
echo "===================================================="

--- 1. Наш графический фикс (прямая DRM) ---
if [ -f "$DEVICE_PATH/patch/graphics_drm.cpp.sprd_legacy_kms_fixed" ]; then
    echo "[*] Применение C++ DRM фикса графики..."
    cp -f "$DEVICE_PATH/patch/fix_drm.cpp" bootable/recovery/minui/graphics_drm.cpp
fi

# --- 2. Авто-применение системных патчей через git apply ---
echo "[*] Проверка и применение системных патчей..."

# Фикс компилятора C++
if [ -f "$DEVICE_PATH/patch/libcxx_verbose_abort.patch" ]; then
    git apply --check "$DEVICE_PATH/patch/libcxx_verbose_abort.patch" &>/dev/null && \
    git apply "$DEVICE_PATH/patch/libcxx_verbose_abort.patch" && echo "[+] Применен libcxx patch!"
fi

# Фикс тем рекавери
if [ -f "$DEVICE_PATH/patch/pbrp_theme_xml.patch" ]; then
    git apply --check "$DEVICE_PATH/patch/pbrp_theme_xml.patch" &>/dev/null && \
    git apply "$DEVICE_PATH/patch/pbrp_theme_xml.patch" && echo "[+] Применен theme patch!"
fi

# Фиксы шифрования даты (vold)
if [ -f "$DEVICE_PATH/patch/vold_android15_keyblob.patch" ]; then
    git apply --check "$DEVICE_PATH/patch/vold_android15_keyblob.patch" &>/dev/null && \
    git apply "$DEVICE_PATH/patch/vold_android15_keyblob.patch" && echo "[+] Применен vold keyblob patch!"
fi

if [ -f "$DEVICE_PATH/patch/vold_recovery_fscrypt_keyring.patch" ]; then
    git apply --check "$DEVICE_PATH/patch/vold_recovery_fscrypt_keyring.patch" &>/dev/null && \
    git apply "$DEVICE_PATH/patch/vold_recovery_fscrypt_keyring.patch" && echo "[+] Применен vold fscrypt patch!"
fi

echo "===================================================="
