#!/bin/bash

# Пути к нашему патчу и к целевой папке в исходниках
PATCH_SOURCE="device/xiaomi/missi/patch/graphics_drm.cpp"
PATCH_TARGET="bootable/recovery/minui/graphics_drm.cpp"

echo "===================================================="
echo "  Unisoc DRM Graphics Fix for Xiaomi Missi (TWRP)  "
echo "===================================================="

if [ -f "$PATCH_SOURCE" ]; then
    echo "[*] Найдено исправление графики DRM. Копирование..."
    cp -f "$PATCH_SOURCE" "$PATCH_TARGET"
    echo "[+] Файл успешно заменен!"
else
    echo "[-] ОШИБКА: Файл патча не найден по пути $PATCH_SOURCE"
    echo "    Проверьте структуру папок вашего дерева устройства."
fi

echo "===================================================="
