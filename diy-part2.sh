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
sed -i 's/192.168.1.1/192.168.1.250/g' package/base-files/files/bin/config_generate
# 修改默认主机名称
sed -i 's/OpenWrt/SamLede/g' package/base-files/files/bin/config_generate
# 修改ntp服务器
sed -i 's/0.openwrt.pool.ntp.org/ntp1.aliyun.com/g' package/base-files/files/bin/config_generate
sed -i 's/1.openwrt.pool.ntp.org/time1.cloud.tencent.com/g' package/base-files/files/bin/config_generate
sed -i 's/2.openwrt.pool.ntp.org/time.ustc.edu.cn/g' package/base-files/files/bin/config_generate
sed -i 's/3.openwrt.pool.ntp.org/cn.pool.ntp.org/g' package/base-files/files/bin/config_generate
# 禁用dns缓存
sed -i '/dnsmasq/a\option cachesize 0' package/network/services/dnsmasq/files/dhcp.conf
sed -i 's/\(option cachesize\)/\t\1/' package/network/services/dnsmasq/files/dhcp.conf
# 开启fullcone nat
sed -i '/fullcone/s/0/1/g' package/network/config/firewall/files/firewall.config
# 开启syn_flood
sed -i '/syn_flood/s/0/1/g' package/network/config/firewall/files/firewall.config
# 添加用户
sed -i '$a li:x:1000:100:li:/mnt/homes/li:/bin/false' package/base-files/files/etc/passwd
sed -i '$a sophie:x:1001:100:sophie:/mnt/homes/sophie:/bin/false' package/base-files/files/etc/passwd
sed -i '$a xzhhzx222:x:1002:100:xzhhzx222:/mnt/homes:/bin/false' package/base-files/files/etc/passwd
sed -i '$a huhan:x:1003:100:huhan:/mnt/homes/huhan:/bin/false' package/base-files/files/etc/passwd
# 配置samba4
svn co https://github.com/xzhhzx222/samlede/branches/samlede/etc package/base-files/files/etc
rm -rf package/feeds/packages/samba4/files/smb.conf.template
mv package/base-files/files/etc/samba/smb.conf.template package/feeds/packages/samba4/files
# sfe开启bbr
sed -i '/bbr/s/0/1/g' package/lean/luci-app-sfe/root/etc/config/sfe
# 修改默认root密码
sed -i 's#root::0#root:$1$yW9piKyc$OT6rrlpcoPRvf1Vk.Zm9N/:18415#g' package/base-files/files/etc/shadow
# 设置用户密码
sed -i '$a li:$1$Ow7vwy1O$lCGrGnn4g3YKBCFQ60/yJ.:18664:0:99999:7:::' package/base-files/files/etc/shadow
sed -i '$a sophie:$1$QSEsYP5O$HphTBwlP28deKNymcaKFf0:18664:0:99999:7:::' package/base-files/files/etc/shadow
sed -i '$a xzhhzx222:$1$3L7KoROG$MUcqm4H6jza4/83CBOsSH/:18664:0:99999:7:::' package/base-files/files/etc/shadow
sed -i '$a huhan:$1$VVM/wBRG$YhZt0UGd5ciSzNME7sV/c1:18665:0:99999:7:::' package/base-files/files/etc/shadow
# 允许外网访问
sed -i 's/rfc1918_filter 1/rfc1918_filter 0/g' package/network/services/uhttpd/files/uhttpd.config
# 配置vsftpd
rm -rf package/feeds/packages/vsftpd/files/vsftpd.conf
mv package/base-files/files/etc/vsftpd.conf package/feeds/packages/vsftpd/files

# 添加pdnsd-alt
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/pdnsd-alt package/pdnsd-alt

# 添加advanced
git clone https://github.com/sirpdboy/luci-app-advanced.git package/luci-app-advanced
# 添加argon-config
#git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
# 添加dnsfilter
git clone https://github.com/garypang13/luci-app-dnsfilter.git package/luci-app-dnsfilter
# 添加jd-dailybonus
git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git package/luci-app-jd-dailybonus
# 替换openappfilter
rm -rf package/diy/OpenAppFilter
git clone https://github.com/destan19/OpenAppFilter.git package/openappfilter

# 更改默认主题
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' package/feeds/luci/luci/Makefile

# 移动appfilter到服务下
sed -i 's/"network"/"services"/g' package/openappfilter/luci-app-oaf/luasrc/controller/appfilter.lua
sed -i 's/network/services/g' package/openappfilter/luci-app-oaf/luasrc/view/admin_network/user_status.htm
# 移动upnp到网络下
sed -i 's/"services"/"network"/g' package/feeds/luci/luci-app-upnp/luasrc/controller/upnp.lua
sed -i 's/services/network/g' package/feeds/luci/luci-app-upnp/luasrc/view/upnp_status.htm
