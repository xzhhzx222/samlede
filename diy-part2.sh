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
sed -i 's/luci-theme-bootstrap/luci-theme-argon-light-mod/g' feeds/luci/collections/luci/Makefile

# 添加redsock2
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/redsocks2 package/lean/redsocks2
# 替换libcap
#rm -rf packages/feeds/packages/libcap
#svn co https://github.com/openwrt/packages/trunk/libs/libcap packages/feeds/packages/libcap

# 添加advanced
git clone https://github.com/sirpdboy/luci-app-advanced.git package/luci-app-advanced
# 添加bypass
#git clone https://github.com/garypang13/luci-app-bypass.git package/bypass/luci-app-bypass
# 添加dnsfilter
#git clone https://github.com/garypang13/luci-app-dnsfilter.git package/luci-app-dnsfilter
# 添加eqos
#git clone https://github.com/garypang13/luci-app-eqos.git package/luci-app-eqos
# 添加helloworld
git clone https://github.com/jerrykuku/lua-maxminddb.git package/vssr/lua-maxminddb
git clone https://github.com/jerrykuku/luci-app-vssr.git package/vssr/luci-app-vssr
# 添加jd-dailybonus
git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git package/vssr/luci-app-jd-dailybonus

# sfe开启bbr
sed -i "s/option bbr '0'"/"option bbr '1'/g" package/lean/luci-app-sfe/root/etc/config/sfe
# 修改ntp服务器
sed -i 's/0.openwrt.pool.ntp.org/ntp1.aliyun.com/g' package/base-files/files/bin/config_generate
sed -i 's/1.openwrt.pool.ntp.org/time1.cloud.tencent.com/g' package/base-files/files/bin/config_generate
sed -i 's/2.openwrt.pool.ntp.org/time.ustc.edu.cn/g' package/base-files/files/bin/config_generate
sed -i 's/3.openwrt.pool.ntp.org/cn.pool.ntp.org/g' package/base-files/files/bin/config_generate

# 移动appfilter到管控下
sed -i 's/"network"/"control"/g' package/diy/OpenAppFilter/luci-app-oaf/luasrc/controller/appfilter.lua
sed -i 's/network/control/g' package/diy/OpenAppFilter/luci-app-oaf/luasrc/view/admin_network/user_status.htm
# 移动aria2到Nas下
sed -i 's/"services"/"nas"/g' package/feeds/luci/luci-app-aria2/luasrc/controller/aria2.lua
sed -i 's/services/nas/g' package/feeds/luci/luci-app-aria2/luasrc/view/aria2/overview_status.htm
# 移动docker到Docker下
#sed -i 's/"services"/"docker"/g' package/lean/luci-app-docker/luasrc/controller/docker.lua
#sed -i 's/services/docker/g' package/lean/luci-app-docker/luasrc/view/docker/docker_status.htm
# 移动upnp到网络下
sed -i 's/"services"/"network"/g' package/feeds/luci/luci-app-upnp/luasrc/controller/upnp.lua
sed -i 's/services/network/g' package/feeds/luci/luci-app-upnp/luasrc/view/upnp_status.htm
# 移动samba到Nas下
#sed -i 's/"services"/"nas"/g' package/feeds/luci/luci-app-samba/luasrc/controller/samba.lua
# 移动samba4到Nas下
sed -i 's/"services"/"nas"/g' package/feeds/luci/luci-app-samba4/luasrc/controller/samba4.lua
# 移动transmission到nas下
sed -i 's/"services"/"nas"/g' package/feeds/luci/luci-app-transmission/luasrc/controller/transmission.lua
