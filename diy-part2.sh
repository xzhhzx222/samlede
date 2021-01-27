#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# 修改默认IP
sed -i 's/192.168.1.1/192.168.1.253/g' package/base-files/files/bin/config_generate
# 修改默认主机名称
sed -i 's/OpenWrt/SamLede/g' package/base-files/files/bin/config_generate
# 修改默认root密码
sed -i 's#root::0:0:99999:7:::#root:$1$yW9piKyc$OT6rrlpcoPRvf1Vk.Zm9N/:18415:0:99999:7:::#g' package/base-files/files/etc/shadow
# 更改默认主题
rm -rf package/lean/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
# 取消53端口监听
sed -i 's/iptables/#&/' package/lean/default-settings/files/zzz-default-settings
# 开启upnp
sed -i '0,/0/s//1/' package/feeds/packages/miniupnpd/files/upnpd.config
# sfe开启bbr
sed -i "s/option bbr '0'"/"option bbr '1'/g" package/lean/luci-app-sfe/root/etc/config/sfe
# dnsmasq支持iptv
sed -i '$a dhcp-option-force=125,00:00:00:00:1a:02:06:48:47:57:2d:43:54:03:04:5a:58:48:4e:0a:02:20:00:0b:02:00:55:0d:02:00:2e' package/network/services/dnsmasq/files/dnsmasq.conf
sed -i '$a dhcp-option=15' package/network/services/dnsmasq/files/dnsmasq.conf
sed -i '$a dhcp-option=28' package/network/services/dnsmasq/files/dnsmasq.conf
sed -i '$a dhcp-option=60,00:00:01:06:68:75:61:71:69:6E:02:0A:48:47:55:34:32:31:4E:20:76:33:03:0A:48:47:55:34:32:31:4E:20:76:33:04:10:32:30:30:2E:55:59:59:2E:30:2E:41:2E:30:2E:53:48:05:04:00:01:00:50' package/network/services/dnsmasq/files/dnsmasq.conf
# 允许外网访问
sed -i 's/option rfc1918_filter 1/option rfc1918_filter 0/g' package/network/services/uhttpd/files/uhttpd.config
# 顺序分配ip
sed -i '/dnsmasq/a\option sequential_ip 1' package/network/services/dnsmasq/files/dhcp.conf
sed -i 's/\(option sequential_ip\)/\t\1/' package/network/services/dnsmasq/files/dhcp.conf
# 禁用dns缓存
sed -i '/dnsmasq/a\option cachesize 0' package/network/services/dnsmasq/files/dhcp.conf
sed -i 's/\(option cachesize\)/\t\1/' package/network/services/dnsmasq/files/dhcp.conf
# 开启noresolv
sed -i '/dnsmasq/a\option noresolv 0' package/network/services/dnsmasq/files/dhcp.conf
sed -i 's/\(option noresolv\)/\t\1/' package/network/services/dnsmasq/files/dhcp.conf
# 绑定53端口
sed -i '/dnsmasq/a\option port 53' package/network/services/dnsmasq/files/dhcp.conf
sed -i 's/\(option port\)/\t\1/' package/network/services/dnsmasq/files/dhcp.conf

# 添加adguardhome
git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/luci-app-adguardhome
# 添加advanced
git clone https://github.com/sirpdboy/luci-app-advanced.git package/luci-app-advanced
# 添加argon-config
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
# 添加bypass
#git clone https://github.com/garypang13/luci-app-bypass.git package/luci-app-bypass
# 添加dnsfilter
#git clone https://github.com/garypang13/luci-app-dnsfilter.git package/luci-app-dnsfilter
# 添加eqos
#git clone https://github.com/garypang13/luci-app-eqos.git package/luci-app-eqos
# 添加smartdns
git clone -b lede https://github.com/pymumu/luci-app-smartdns.git package/luci-app-smartdns
# 添加hellowworld
#git clone https://github.com/jerrykuku/lua-maxminddb.git package/vssr/lua-maxminddb
#git clone https://github.com/jerrykuku/luci-app-vssr.git package/vssr/luci-app-vssr
# 添加openappfilter
git clone https://github.com/destan19/OpenAppFilter.git package/openappfilter
# 添加ttnode ###DEBUG###
#git clone https://github.com/jerrykuku/luci-app-ttnode.git package/luci-app-ttnode

# 移动accesscontrol到网络下
sed -i 's/"services"/"network"/g' package/lean/luci-app-accesscontrol/luasrc/controller/mia.lua
sed -i 's/services/network/g' package/lean/luci-app-accesscontrol/luasrc/view/mia/mia_status.htm
# 移动docker到Docker下
sed -i 's/"services"/"docker"/g' package/lean/luci-app-docker/luasrc/controller/docker.lua
sed -i 's/services/docker/g' package/lean/luci-app-docker/luasrc/view/docker/docker_status.htm
# 移动upnp到网络下
sed -i 's/"services"/"network"/g' package/feeds/luci/luci-app-upnp/luasrc/controller/upnp.lua
sed -i 's/services/network/g' package/feeds/luci/luci-app-upnp/luasrc/view/upnp_status.htm
# 移动samba到Nas下
sed -i 's/"services"/"nas"/g' package/feeds/luci/luci-app-samba/luasrc/controller/samba.lua
# 移动samba4到Nas下
#sed -i 's/"services"/"nas"/g' package/lean/luci-app-samba4/luasrc/controller/samba4.lua
