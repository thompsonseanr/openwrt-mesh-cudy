## OpenWrt Playbook for Cudy M3000 v1 routers

**WIP** Use at your own risk; it may break your stuff.

Work based upon this great tutorial:  [OpenWRT Batman Mesh Tutorial](https://github.com/benkay86/openwrt-batman-tutorial)

Future work will leverage information learned from the awesome FREEMESH project: [FREEMESH Firmware](https://gitlab.com/slthomason/freemesh)

*Unfortunately, this is still a work in progress and I have not been successful with the mesh nodes yet.*

This was done using the latest OpenWrt firmware using the [OpenWrt firmware selector tool](https://firmware-selector.openwrt.org/)

The opkg packages used are found in the `install-pkgs` role.

This playbook is really a great starting place for learning how to configure OpenWrt with the uci cli.

A super helpful `uci` command to use during configuration of the wireless and network is:

```
> uci show wireless
> uci show network
```
All primary configuration files are in `/etc/config/`

[The UCI system](https://openwrt.org/docs/guide-user/base-system/uci)

**Note:**

- In order to flash OpenWrt to the Cudy M3000 v1, follow these instructions: [OpenWrt Software Download](https://www.cudy.com/blogs/faq/openwrt-software-download). in the blog post, there is a link to the [Cudy Intermediary  OpenWRT Firmware](https://drive.google.com/drive/folders/1BKVarlwlNxf7uJUtRhuMGUqeCa5KpMnj).

- **UPDATE** The easiest way I found to flash every mesh node is to do it individually, following the steps one would take for flashing a recovery image [How to Recovery the Cudy Router From OpenWRT Firmware to Cudy Official Firmware? ](https://www.cudy.com/blogs/faq/how-to-recovery-the-cudy-router-from-openwrt-firmware-to-cudy-official-firmware). I simply pulled the image from the cudy clear signature google drive share (listed by device name), renamed the image to `recovery.bin` (make it executable), and change the IP on the computer to **192.168.1.88**. making sure to hold down the **reset** button before starting up the router and hardwire into the router's ethernet port. I ran tcpdump to make sure the image was completely copied over and watched the led turn solid white. When it came back up, I logged into the default `192.168.1.1` LuCI interface and then flashed the new latest, custom OpenWRT firmware with included packages: `kmod-batman-adv batctl-default iw wpad-mbedtls luci-proto-batman-adv`.

- If you need to restore your router back to the [Cudy official firmware](https://www.cudy.com/pages/download-center/m3000-2-0), download the latest firmware for your router, set up a tftp server and follow these instructions (make note to set your computer's/server's IP to, otherwise the router will not instantiate the call to the tftp server: **192.168.1.88**): [How to Recovery the Cudy Router From OpenWRT Firmware to Cudy Official Firmware? ](https://www.cudy.com/blogs/faq/how-to-recovery-the-cudy-router-from-openwrt-firmware-to-cudy-official-firmware)





