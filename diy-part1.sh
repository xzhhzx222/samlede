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
sed -i '$a src-git helloworld https://github.com/fw876/helloworld' feeds.conf.default
sed -i '$a src-git openclash https://github.com/vernesong/OpenClash.git;master' feeds.conf.default
sed -i '$a src-git jerrykuku https://github.com/jerrykuku/luci-app-vssr.git' feeds.conf.defult

# 替换19.07 luci
#sed -i 's/17.01/19.07/g' feeds.conf.default

# 添加ssr软件包
#git clone https://github.com/coolsnowwolf/lede.git package/lean1
#mv -f package/lean1/package/lean/microsocks package/lean
#mv -f package/lean1/package/lean/redsocks2 package/lean
#rm -rf package/lean1
