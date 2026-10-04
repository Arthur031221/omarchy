echo "Add Surface keyboard modules to the boot image on existing AMD installations"

omarchy-hw-surface || exit 0
omarchy-cmd-present limine-mkinitcpio || exit 0
pinctrl_module=$(lsmod | grep pinctrl_ || true)
[[ -z $pinctrl_module ]] || exit 0

rebuild_marker="/var/lib/omarchy/migrations/1791074563"
[[ ! -e $rebuild_marker ]] || exit 0

if [[ ! -e /etc/mkinitcpio.conf.d/surface_device_modules.conf ]]; then
  sudo bash -e "$OMARCHY_PATH/install/hardware/fix-surface-keyboard.sh"
fi

sudo limine-mkinitcpio
sudo install -Dm644 /dev/null "$rebuild_marker"
