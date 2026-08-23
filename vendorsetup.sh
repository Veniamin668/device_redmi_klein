#!/bin/bash

#
#    This file is part of the OrangeFox Recovery Project
#    Copyright (C) 2026 The OrangeFox Recovery Project
#
#    OrangeFox is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    any later version.
#
#    OrangeFox is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    This software is released under GPL version 3 or any later version.
#    See <http://www.gnu.org/licenses/>.
#

DEVICE_PATH="device/xiaomi/missi"
FDEVICE="missi"
#set -o xtrace

echo "===================================================="
echo "    🔥 ULTIMATE UNISOC PATCHER FOR REDMI A3X 🔥      "
echo "===================================================="

# --- 1. Авто-применение системных патчей через git apply ---
echo "[*] Проверка и применение системных патчей..."

# Фикс компилятора C++
if [ -f "$DEVICE_PATH/patch/libcxx_verbose_abort.patch" ]; then
    git apply --check "$DEVICE_PATH/patch/libcxx_verbose_abort.patch" &>/dev/null && \
    git apply "$DEVICE_PATH/patch/libcxx_verbose_abort.patch" && echo "[+] Применен libcxx patch!"
fi

# Вырезаем ручное выделение памяти, которое ломает C++ линковщик в Redmi A3x
if [ -f "bootable/recovery/minui/graphics_drm.cpp" ]; then
    echo "[*] Авто-фикс структуры памяти draw_buf..."
    sed -i 's|draw_buf->data = (unsigned char \*)calloc|// draw_buf->data =|g' bootable/recovery/minui/graphics_drm.cpp
    sed -i 's|if (!draw_buf->data)|// if (!draw_buf->data)|g' bootable/recovery/minui/graphics_drm.cpp
fi

# --- 2. Инициализация переменных окружения OrangeFox ---
fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep -w $FDEVICE)
   if [ -n "$chkdev" ]; then
      FOX_BUILD_DEVICE="$FDEVICE"
   else
      chkdev=$(set | grep BASH_ARGV | grep -w $FDEVICE)
      [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
   fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
   fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
    export TW_DEFAULT_LANGUAGE="ru"
    export LC_ALL="C"
    export ALLOW_MISSING_DEPENDENCIES=true

    # Пути к блочникам для Unisoc (A/B architecture + vendor_boot)
    export FOX_RECOVERY_INSTALL_PARTITION="/dev/block/by-name/vendor_boot"
    export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
    export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"
    export FOX_RECOVERY_BOOT_PARTITION="/dev/block/by-name/boot"

    # Alternate Codenames (сородич klein)
    export TARGET_DEVICE_ALT="klein"

    # Fox Engine & Patching (Чистый AOSP / Android Go без MIUI мусора)
    export OF_USE_GREEN_LED=0
    export OF_HIDE_NOTCH=1
    export OF_USE_MAGISKBOOT=1
    export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1
    export OF_DONT_PATCH_ENCRYPTED_DEVICE=1
    export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
    export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
    
    # Utilities inside recovery
    export FOX_USE_BASH_SHELL=1
    export FOX_ASH_IS_BASH=1
    export FOX_USE_TAR_BINARY=1
    export FOX_USE_SED_BINARY=1
    export FOX_USE_XZ_UTILS=1
    export FOX_USE_NANO_EDITOR=1
    export FOX_USE_ZIP_BINARY=1
    
    # Backups & AVB
    export OF_QUICK_BACKUP_LIST="/boot;/recovery;/data;/vendor_boot;"
    export OF_PATCH_AVB20=1
    export FOX_DELETE_AROMAFM=0
    export FOX_BUGGED_AOSP_ARB_WORKAROUND="1546300800"
    export FOX_ENABLE_APP_MANAGER=1

    # Maintainer Info
    export FOX_MAINTAINER_PATCH_VERSION="1"
    export OF_MAINTAINER="ktoya? | Kirill Nekrasov Pro"

    # Stock AOSP OTA settings (без MIUI-костылей)
    export OF_KEEP_DM_VERITY=1
    export OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR=1

    # Screen Settings (Portrait HDPI под наш девайс)
    export OF_SCREEN_H=2400
    export OF_STATUS_H=80
    export OF_STATUS_INDENT_LEFT=48
    export OF_STATUS_INDENT_RIGHT=48
    export OF_CLOCK_POS=1
    export OF_ALLOW_DISABLE_NAVBAR=0

    # Dump build vars to log
    if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
        export | grep "FOX" >> $FOX_BUILD_LOG_FILE
        export | grep "OF_" >> $FOX_BUILD_LOG_FILE
        export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
        export | grep "TW_" >> $FOX_BUILD_LOG_FILE
    fi
fi

echo "===================================================="
