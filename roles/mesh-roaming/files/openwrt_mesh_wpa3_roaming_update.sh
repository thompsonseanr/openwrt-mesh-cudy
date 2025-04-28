#!/bin/sh
# OpenWrt 24.10.0 Mesh Setup for Cudy M3000
# - batman-adv over Wi-Fi backhaul (2.4GHz + 5GHz)
# - WPA3 encryption (SAE) on Mesh and AP
# - 802.11r/k/v roaming
# - Ethernet client access at any mesh node

# === Install required packages ===
opkg update
opkg install batctl kmod-batman-adv wpad-openssl

# === Configure static LAN IP (customize per node) ===
uci set network.lan.proto='static'
uci set network.lan.ipaddr='192.168.1.2'  # Change for each node
uci set network.lan.netmask='255.255.255.0'
uci set network.lan.gateway='192.168.1.1'
uci set network.lan.dns='192.168.1.1'
uci commit network

# === Setup batman-adv device ===
uci set network.bat0='interface'
uci set network.bat0.proto='batadv'
uci set network.bat0.mesh='bat0'
uci set network.bat0.auto='1'
uci commit network

# === Bridge LAN to batman-adv and Ethernet ===
uci set network.lan.ifname='eth0 bat0'
uci commit network

# === Configure radios ===
# 5GHz
uci set wireless.radio0.channel='36'
uci set wireless.radio0.hwmode='11a'
uci set wireless.radio0.htmode='VHT80'
uci set wireless.radio0.disabled='0'

# 2.4GHz
uci set wireless.radio1.channel='1'
uci set wireless.radio1.hwmode='11g'
uci set wireless.radio1.htmode='HT20'
uci set wireless.radio1.disabled='0'

# === Create mesh interfaces with WPA3 ===
# 5GHz mesh (radio0)
uci set wireless.mesh5='wifi-iface'
uci set wireless.mesh5.device='radio0'
uci set wireless.mesh5.mode='mesh'
uci set wireless.mesh5.mesh_id='mynetmesh'
uci set wireless.mesh5.encryption='sae'
uci set wireless.mesh5.key='meshpassword'
uci set wireless.mesh5.network='bat0'
uci set wireless.mesh5.mesh_fwding='1'

# 2.4GHz mesh (radio1)
uci set wireless.mesh2='wifi-iface'
uci set wireless.mesh2.device='radio1'
uci set wireless.mesh2.mode='mesh'
uci set wireless.mesh2.mesh_id='mynetmesh'
uci set wireless.mesh2.encryption='sae'
uci set wireless.mesh2.key='meshpassword'
uci set wireless.mesh2.network='bat0'
uci set wireless.mesh2.mesh_fwding='1'

# === Add dual-band access points with WPA3 + roaming ===
# 5GHz AP (radio0)
uci set wireless.ap5='wifi-iface'
uci set wireless.ap5.device='radio0'
uci set wireless.ap5.mode='ap'
uci set wireless.ap5.ssid='MyWiFi'
uci set wireless.ap5.encryption='sae'
uci set wireless.ap5.key='yourpassword'
uci set wireless.ap5.network='lan'
uci set wireless.ap5.ieee80211r='1'
uci set wireless.ap5.mobility_domain='4f57'
uci set wireless.ap5.ft_over_ds='1'
uci set wireless.ap5.ft_psk_generate_local='1'
uci set wireless.ap5.ieee80211k='1'
uci set wireless.ap5.ieee80211v='1'
uci set wireless.ap5.bss_transition='1'

# 2.4GHz AP (radio1)
uci set wireless.ap2='wifi-iface'
uci set wireless.ap2.device='radio1'
uci set wireless.ap2.mode='ap'
uci set wireless.ap2.ssid='MyWiFi'
uci set wireless.ap2.encryption='sae'
uci set wireless.ap2.key='yourpassword'
uci set wireless.ap2.network='lan'
uci set wireless.ap2.ieee80211r='1'
uci set wireless.ap2.mobility_domain='4f57'
uci set wireless.ap2.ft_over_ds='1'
uci set wireless.ap2.ft_psk_generate_local='1'
uci set wireless.ap2.ieee80211k='1'
uci set wireless.ap2.ieee80211v='1'
uci set wireless.ap2.bss_transition='1'

# === Save configuration ===
uci commit network
uci commit wireless

# === Apply changes ===
/etc/init.d/network restart
wifi reload
