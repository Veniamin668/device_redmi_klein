set +e
mod_dir="/vendor_dlkm/lib/modules"
modules=(
  vibrator_drv.ko
  lct_tp.ko
  nt36528_spi.ko
  icnl9916_spi.ko
)

mount /vendor_dlkm
# load modules
for module in "${modules[@]}"; do
  insmod $mod_dir/$module
done
umount /vendor_dlkm