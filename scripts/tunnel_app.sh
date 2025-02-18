#!/bin/bash

# openclash
openclash_api="https://api.github.com/repos/vernesong/OpenClash/releases"
openclash_file="luci-app-openclash"
openclash_file_down="$(curl -s ${openclash_api} | grep "browser_download_url" | grep -oE "https.*${openclash_file}.*.ipk" | head -n 1)"

# neko
neko_api="https://api.github.com/repos/nosignals/neko/releases"
neko_file="luci-app-neko"
neko_file_down="$(curl -s https://api.github.com/repos/nosignals/neko/releases/latest | jq -r '.assets[] | select(.name | endswith("_23_05.ipk")) | .browser_download_url')"

# nkki
nikki_api="https://api.github.com/repos/nikkinikki-org/OpenWrt-nikki/releases"
nikki_file="nikki_${ARCH_3}-openwrt-${CURVER}"
nikki_file_down=$(curl -s "${nikki_api}" | grep "browser_download_url" | grep -oE "https.*${nikki_file_down}.*.tar.gz" | head -n 1)

# passwall
passwall_api="https://api.github.com/repos/xiaorouji/openwrt-passwall/releases"
passwall_file="passwall_packages_ipk_$ARCH_3.zip"
passwall_file_down="$(curl -s ${passwall_api} | grep "browser_download_url" | grep -oE "https.*${passwall_file}" | head -n 1)"
passwall_ipk="https://github.com/xiaorouji/openwrt-passwall/releases/download/25.1.28-1/luci-23.05_luci-app-passwall_25.1.28_all.ipk"  

if [ "$1" == "openclash" ]; then
    echo "Downloading Openclash packages"
    wget ${openclash_file_down} -nv -P packages
elif [ "$1" == "neko" ]; then
    echo "Downloading Neko packages"
    wget "${neko_file_down}" -nv -P packages
elif [ "$1" == "passwall" ]; then
    echo "Downloading Passwall packages ipk"
    wget "$passwall_file_down" -nv -P packages
    wget "$passwall_ipk" -nv -P packages
    wget "${passwall_ipk_packages[@]}" -nv -P packages
    unzip -qq packages/"$passwall_file" -d packages && rm packages/"$passwall_file"
    rm files/usr/bin/patchoc.sh
elif [ "$1" == "neko-openclash" ]; then
    echo "Installing Neko and Openclash"
    echo "Downloading Neko packages"
    wget "${neko_file_down}" -nv -P packages
    echo "Downloading Openclash packages"
    wget ${openclash_file_down} -nv -P packages
elif [ "$1" == "openclash-passwall" ]; then
    echo "Installing Openclash and Passwall"
    echo "Downloading Openclash packages"
    wget ${openclash_file_down} -nv -P packages
    echo "Downloading Nikki packages"
    wget ${nikki_file_down} -nv -P packages
    echo "Downloading Passwall packages ipk"
    wget "$passwall_file_down" -nv -P packages
    wget "$passwall_ipk" -nv -P packages
    wget "${passwall_ipk_packages[@]}" -nv -P packages
    unzip -qq packages/"$passwall_file" -d packages && rm packages/"$passwall_file"
elif [ "$1" == "neko-passwall" ]; then
    echo "Installing Neko and Passwall"
    echo "Downloading Neko packages"
    wget "${neko_file_down}" -nv -P packages
    echo "Downloading Passwall packages ipk"
    wget "$passwall_file_down" -nv -P packages
    wget "$passwall_ipk" -nv -P packages
    wget "${passwall_ipk_packages[@]}" -nv -P packages
    unzip -qq packages/"$passwall_file" -d packages && rm packages/"$passwall_file"
elif [ "$1" == "openclash-passwall-neko" ]; then
    echo "Installing Openclash, Neko and Passwall"
    echo "Downloading Openclash packages"
    wget ${openclash_file_down} -nv -P packages
    echo "Downloading Neko packages"
    wget "${neko_file_down}" -nv -P packages
    echo "Downloading Passwall packages ipk"
    wget "$passwall_file_down" -nv -P packages
    wget "$passwall_ipk" -nv -P packages
    wget "${passwall_ipk_packages[@]}" -nv -P packages
    unzip -qq packages/"$passwall_file" -d packages && rm packages/"$passwall_file"
fi 
if [ "$?" -ne 0 ]; then
    echo "Error: Download or extraction failed."
    exit 1
else
    echo "Download complete."
fi
