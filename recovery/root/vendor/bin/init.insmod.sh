#!/vendor/bin/sh
# SPDX-FileCopyrightText: 2016-2023 Unisoc (Shanghai) Technologies Co., Ltd
# SPDX-License-Identifier: LicenseRef-Unisoc-General-1.0

module_dir=/vendor/lib/modules

if [ $# -eq 1 ]; then
	cfg_file=$1
elif [ $# -eq 2 ]; then
	cfg_file=$1
	if [[ $2 == "cali" || $2 == "charger" ]]; then
		bootmode=".$2"
	else
		bootmode=
	fi
else
	# Set property even if there is no insmod config
	# to unblock early-boot trigger
	setprop vendor.all.modules.ready 1
	exit 1
fi

load_module()
{
	module="$1"

	[ -n "$module" ] || return
	case "$module" in
		\#*) return ;;
	esac

	modprobe -s -a -d "$module_dir" "$module" 2>/dev/null || \
		insmod "$module_dir/$module" 2>/dev/null || \
		insmod "/lib/modules/$module" 2>/dev/null
}

if [ -f "$cfg_file" ]; then
	while IFS="|" read -r action arg
	do
		args="$(echo "$arg" | sed 's/|/ /g')"
		case "$action" in
			"" | \#*) ;;
			*.ko) load_module "$action" ;;
			"insmod") insmod $args ;;
			"setprop") setprop "$arg" 1 ;;
			"enable") echo 1 > "$arg" ;;
			"modprobe")
				case "$arg" in
					"-b "* | "-b")
						arg="-b $(cat "$module_dir/modules.load$bootmode")" ;;
					"*"|"")
						arg="$(cat "$module_dir/modules.load$bootmode")" ;;
				esac
				modprobe -s -a -d "$module_dir" $arg ;;
			"modprobe_gki_modules")
				case "$arg" in
					"*"|"")
						arg="$(cat /system/lib/modules/modules.load)" ;;
				esac
				modprobe -s -a -d /system/lib/modules $arg ;;
		esac
	done < "$cfg_file"
fi

setprop vendor.all.modules.ready 1
