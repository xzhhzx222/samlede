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
#sed -i 's/OpenWrt/SamLede/g' package/base-files/files/bin/config_generate
# 修改ntp服务器
sed -i 's/0.openwrt.pool.ntp.org/ntp1.aliyun.com/g' package/base-files/files/bin/config_generate
sed -i 's/1.openwrt.pool.ntp.org/time1.cloud.tencent.com/g' package/base-files/files/bin/config_generate
sed -i 's/2.openwrt.pool.ntp.org/time.ustc.edu.cn/g' package/base-files/files/bin/config_generate
sed -i 's/3.openwrt.pool.ntp.org/cn.pool.ntp.org/g' package/base-files/files/bin/config_generate
# 禁用dns缓存
sed -i '/dnsmasq/a\option cachesize 0' package/network/services/dnsmasq/files/dhcp.conf
sed -i 's/\(option cachesize\)/\t\1/' package/network/services/dnsmasq/files/dhcp.conf
# 顺序分配ip
sed -i '/dnsmasq/a\option sequential_ip 1' package/network/services/dnsmasq/files/dhcp.conf
sed -i 's/\(option sequential_ip\)/\t\1/' package/network/services/dnsmasq/files/dhcp.conf
# 调整ip范围
sed -i '/start/s/100/20/' package/network/services/dnsmasq/files/dhcp.conf
sed -i '/limit/s/150/50/' package/network/services/dnsmasq/files/dhcp.conf
# 支持iptv
sed -i '$a dhcp-option-force=125,00:00:00:00:1a:02:06:48:47:57:2d:43:54:03:04:5a:58:48:4e:0a:02:20:00:0b:02:00:55:0d:02:00:2e' package/network/services/dnsmasq/files/dnsmasq.conf
sed -i '$a dhcp-option=15' package/network/services/dnsmasq/files/dnsmasq.conf
sed -i '$a dhcp-option=28' package/network/services/dnsmasq/files/dnsmasq.conf
sed -i '$a dhcp-option=60,00:00:01:06:68:75:61:71:69:6E:02:0A:48:47:55:34:32:31:4E:20:76:33:03:0A:48:47:55:34:32:31:4E:20:76:33:04:10:32:30:30:2E:55:59:59:2E:30:2E:41:2E:30:2E:53:48:05:04:00:01:00:50' package/network/services/dnsmasq/files/dnsmasq.conf
# 开启fullcone nat
sed -i '/fullcone/s/0/1/g' package/network/config/firewall/files/firewall.config
# 开启syn_flood
sed -i '/syn_flood/s/0/1/g' package/network/config/firewall/files/firewall.config
# sfe开启bbr
sed -i '/bbr/s/0/1/g' package/lean/luci-app-sfe/root/etc/config/sfe
# 修改默认root密码
sed -i 's#root::0#root:$1$yW9piKyc$OT6rrlpcoPRvf1Vk.Zm9N/:18415#g' package/base-files/files/etc/shadow
# 允许外网访问
sed -i 's/rfc1918_filter 1/rfc1918_filter 0/g' package/network/services/uhttpd/files/uhttpd.config
# 开启upnp
sed -i '/enabled/s/0/1/g' package/feeds/packages/miniupnpd/files/upnpd.config

# 添加pdnsd-alt
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/pdnsd-alt package/pdnsd-alt
# 添加redsock2
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/redsocks2 package/ssrplus/redsocks2

# 添加advanced
git clone https://github.com/sirpdboy/luci-app-advanced.git package/luci-app-advanced
# 添加argon-config
#git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
# 添加bypass
#git clone https://github.com/garypang13/luci-app-bypass.git package/luci-app-bypass
# 添加dnsfilter
#git clone https://github.com/garypang13/luci-app-dnsfilter.git package/luci-app-dnsfilter
# 添加helloworld
#git clone https://github.com/jerrykuku/lua-maxminddb.git package/vssr/lua-maxminddb
#git clone https://github.com/jerrykuku/luci-app-vssr.git package/vssr/luci-app-vssr
# 添加jd-dailybonus
git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git package/luci-app-jd-dailybonus
# 替换openappfilter
#rm -rf package/diy/OpenAppFilter
#git clone https://github.com/destan19/OpenAppFilter.git package/openappfilter

# 更改默认主题
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' package/feeds/luci/luci/Makefile

# 移动appfilter到服务下
#sed -i 's/"network"/"services"/g' package/openappfilter/luci-app-oaf/luasrc/controller/appfilter.lua
#sed -i 's/network/services/g' package/openappfilter/luci-app-oaf/luasrc/view/admin_network/user_status.htm
# 移动upnp到网络下
sed -i 's/"services"/"network"/g' package/feeds/luci/luci-app-upnp/luasrc/controller/upnp.lua
sed -i 's/services/network/g' package/feeds/luci/luci-app-upnp/luasrc/view/upnp_status.htm
