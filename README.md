## OpenWrt Playbook for Cudy M3000 v1 routers.

Use at your own risk. It may break your stuff.

Work based upon this great tutorial:  [OpenWRT Batman Mesh Tutorial](https://github.com/benkay86/openwrt-batman-tutorial)

*Unfortunately, this is still a work in progress and I have not been successful with the mesh nodes yet.*

This was done using the latest OpenWrt firmware using the [OpenWrt firmware selector tool](https://firmware-selector.openwrt.org/)

The opkg packages used are found in the `install-pks` role


Note:

- In order to flash OpenWrt to the Cudy M3000 v1, follow these instructions: [OpenWrt Software Download](https://www.cudy.com/blogs/faq/openwrt-software-download)

- If you need to restore your router back to the Cudy official firmware, you will need to set up an tftp server and follow these instructions: [How to Recovery the Cudy Router From OpenWRT Firmware to Cudy Official Firmware? ](https://www.cudy.com/blogs/faq/how-to-recovery-the-cudy-router-from-openwrt-firmware-to-cudy-official-firmware)

Further thoughts and may play with later:

Upon looking at how Cudy firmware handles mesh wifi backhaul (only 5g), this leads me to suspect that there may be an issue with the setup performed in this playbook, which creates both 2g and 5g mesh backhauls.


