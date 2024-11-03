# OpenWrt and ImmortalWrt

![GitHub Downloads (all assets, all releases)](https://img.shields.io/github/downloads/edisigabut/action-owrt/total.svg?style=for-the-badge&logo=Openwrt)

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

- Modemmanager protocol for connecting 4g/5g modems (tested using Dell DW5821e Snapdragon X20 LTE),
- Modemmanager with auto-reconnect,
- Automatically expand root partition and filesystem to available free space! (Please be patient because the initial boot process takes a little longer to extend the disk and it also requires two reboot attempts),
- AdGuard Home installed (enable using "adguardhome enable" command on terminal, and "adguardhome disable" to disable),
- Openclash with latest beta release and latest MetaCubeX Mihomo core,
- Passwall as alternate tunneling app,
- DOCKER installed, ready to run container,
- Aria2 download server,
- SAMBA4 server for sharing storage,
- TinyFm file manager,
- Internet Detector and Lite Watchdog,
- vnstat2 and Nlbwmon for Bandwith Monitoring,
- Argon, RTA and Alpha Theme with some cool custom login image,
- 3ginfo lite and Modeminfo, sms-tool, and other modem support app,
- OLED Display support (only Raspberrry Pi 4B tested),
- etc~

