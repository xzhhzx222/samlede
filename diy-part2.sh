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

# 移动samba4到nas下
#sed -i 's/"services"/"nas"/g' package/lean/luci-app-samba4/luasrc/controller/samba4.lua
# 修改默认IP
sed -i 's/192.168.1.1/192.168.1.253/g' package/base-files/files/bin/config_generate
# 修改默认主机名称
sed -i 's/OpenWrt/SamLede/g' package/base-files/files/bin/config_generate
# 修改默认root密码
sed -i 's#root::0:0:99999:7:::#root:$1$yW9piKyc$OT6rrlpcoPRvf1Vk.Zm9N/:18415:0:99999:7:::#g' package/base-files/files/etc/shadow
# 更改默认主题
#git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
sed -i 's/luci-theme-bootstrap/luci-theme-argon-dark/g' feeds/luci/collections/luci/Makefile
