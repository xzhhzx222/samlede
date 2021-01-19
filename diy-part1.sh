#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package.git' feeds.conf.default
#sed -i '$a src-git vernesong https://github.com/vernesong/OpenClash.git;master' feeds.conf.default
sed -i '$a src-git xiaorouji https://github.com/xiaorouji/openwrt-passwall.git' feeds.conf.default
sed -i '$a src-git lisaac https://github.com/lisaac/luci-app-dockerman.git' feeds.conf.default
# 添加adguardhome
#git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/luci-app-adguardhome
svn co https://github.com/Lienol/openwrt-packages/trunk/net/adguardhome feeds/AdGuardhome/adguarhome
svn co https://github.com/Lienol/openwrt-packages/trunk/devel/packr feeds/AdGuardhome/packr
svn co https://github.com/Lienol/openwrt/trunk/package/diy/luci-app-adguardhome package/luci-app-adguarhome
