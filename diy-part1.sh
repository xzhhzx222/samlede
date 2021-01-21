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
sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
# 添加dockerman
sed -i '$a src-git lisaac https://github.com/lisaac/luci-app-dockerman.git' feeds.conf.default
# 添加openclash
#sed -i '$a src-git vernesong https://github.com/vernesong/OpenClash.git;master' feeds.conf.default
# 添加passwall
sed -i '$a src-git xiaorouji https://github.com/xiaorouji/openwrt-passwall.git' feeds.conf.default
