#!/vendor/bin/sh
# Load recovery kernel modules from a plain modules.load-style file.

if [ $# -ge 1 ]; then
	cfg_file="$1"
else
	cfg_file=/lib/modules/modules.load.recovery
fi

case "$cfg_file" in
	/*/modules.load*) module_dir="${cfg_file%/*}" ;;
	*) module_dir=/lib/modules ;;
esac

load_module()
{
	module="$1"

	[ -n "$module" ] || return
	case "$module" in
		\#*) return ;;
	esac

	modprobe -s -a -d "$module_dir" "$module" 2>/dev/null || \
		insmod "$module_dir/$module" 2>/dev/null || \
		insmod "/vendor/lib/modules/$module" 2>/dev/null || \
		insmod "/lib/modules/$module" 2>/dev/null
}

if [ -f "$cfg_file" ]; then
	while IFS= read -r module
	do
		load_module "$module"
	done < "$cfg_file"
fi

setprop vendor.recovery.modules.ready 1
setprop vendor.all.modules.ready 1
