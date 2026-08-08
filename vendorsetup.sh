#!/bin/bash

DEVICE_PATH="device/xiaomi/missi"

echo "===================================================="
echo "   🔥 ULTIMATE UNISOC PATCHER FOR REDMI A3X 🔥     "
echo "===================================================="

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

# Вырезаем ручное выделение памяти, которое ломает C++ линковщик в Redmi A3x
if [ -f "bootable/recovery/minui/graphics_drm.cpp" ]; then
    echo "[*] Авто-фикс структуры памяти draw_buf..."
    sed -i 's|draw_buf->data = (unsigned char \*)calloc|// draw_buf->data =|g' bootable/recovery/minui/graphics_drm.cpp
    sed -i 's|if (!draw_buf->data)|// if (!draw_buf->data)|g' bootable/recovery/minui/graphics_drm.cpp
fi

echo "===================================================="
