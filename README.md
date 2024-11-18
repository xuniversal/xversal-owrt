# OpenWrt and ImmortalWrt

![GitHub Downloads (all assets, all releases)](https://img.shields.io/github/downloads/xuniversal/xversal-owrt/total.svg?style=for-the-badge&logo=Openwrt)

### What's this?
This is a openwrt toolchain called Image Builder to build a pre-compiled image to ready one firmware. You can customize your own packages and custom files that suitable for you. 

Using [Builder](https://github.com/Revincx/MyWrtBuilder) from Revincx as a source base script, adopted it then enhanced it by adding the ability to select Source and Branch versions, automatically expanding the rootfs partition size to the remaining disk, flexible target device selection, logic code improvements and more.

### Features of this project
* Using ImageBuilder to build firmware saves time and effort. It only takes less than half an hour to build once.
* It has built-in Luci software packages that I use daily, and can be used almost out of the box.
* The latest version of Clash kernel is built-in using auto download latest core script, no need to download it yourself.
* Built-in Docker and AdGuard Home components, no complex configuration required.
* Simply modify make-build.sh to build your own firmware for easy customization.

### How To
Select for using Official OpenWrt or ImmortalWrt as a source base and branch version with just one click!

You can also edit the package you want by simply edit "make-build.sh" file!

Want to use custom .ipk packages or custom files?
Put the url link on "external-package-urls.txt" or upload it to "packages" folder, then write down the ipk package name on "make-buil.sh".
Custom files or configuration on "files" folder.
Please read instruction given.

### Firmware details
Login info
* 192.168.9.1 | user: root | password: root
* SSID: OpenWRT or Openwrt_5GHz | password: openwrt2024
