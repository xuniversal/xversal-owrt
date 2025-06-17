echo "Start AdGuardHome Core Download !"
echo "Current Path: $PWD"

# Deteksi arsitektur sistem
machine_arch=$(uname -m)
case "$machine_arch" in
    x86_64)
        ARCH_1="amd64"
        ;;
    i386 | i686)
        ARCH_1="386"
        ;;
    armv7l)
        ARCH_1="armv7"
        ;;
    armv6l)
        ARCH_1="armv6"
        ;;
    aarch64)
        ARCH_1="arm64"
        ;;
    *)
        echo "Error: Unsupported architecture: $machine_arch"
        exit 1
        ;;
esac

# API dan pencarian file release
agh_api="https://api.github.com/repos/AdguardTeam/AdGuardHome/releases"
agh_file="AdGuardHome_linux_${ARCH_1}"
agh_file_down=$(curl -s "${agh_api}/latest" | grep "browser_download_url" | grep -oE "https.*${agh_file}.*\.tar\.gz" | head -n 1)
latest_version=$(curl -sSL "$agh_api/latest" | grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+' | head -n 1)

# Debug output
echo "Detected arch: $ARCH_1"
echo "Download URL: $agh_file_down"
echo "AdGuardHome Version: $latest_version"

# Download & extract
if [[ -n "$agh_file_down" ]]; then
  if wget -nv "$agh_file_down" -P files/opt; then
    echo "Extracting AdGuardHome..."
    if tar -zxvf "files/opt/${agh_file}.tar.gz" -C files/opt; then
      rm "files/opt/${agh_file}.tar.gz"
      echo "Done! Installed AdGuardHome version $latest_version for arch $ARCH_1"
    else
      echo "Error: Failed to extract AdGuardHome."
    fi
  else
    echo "Error: Failed to download AdGuardHome."
  fi
else
  echo "Error: Could not resolve AdGuardHome download URL."
fi
