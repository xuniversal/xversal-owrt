#!/bin/bash

echo "Start AdGuardHome Core Download!"
echo "Current Path: $PWD"

# Pemetaan arsitektur uname ke format AdGuardHome
declare -A arch_map=( 
  ["x86_64"]="amd64" 
  ["aarch64"]="arm64" 
  ["i386"]="386" 
  ["i686"]="386" 
  ["armv7l"]="armv7" 
  ["armv6l"]="armv6"
)

ARCH_RAW=$(uname -m)
ARCH_1=${arch_map[$ARCH_RAW]}

# Validasi dukungan
if [[ -z "$ARCH_1" ]]; then
  echo "Error: Unsupported architecture: $ARCH_RAW"
  exit 1
fi

# Ambil versi terbaru dan URL file dari GitHub API
agh_api="https://api.github.com/repos/AdguardTeam/AdGuardHome/releases"
agh_file="AdGuardHome_linux_${ARCH_1}"
agh_file_down=$(curl -s "${agh_api}/latest" | grep "browser_download_url" | grep -oE "https.*${agh_file}.*\.tar\.gz" | head -n 1)
latest_version=$(curl -sSL "$agh_api/latest" | grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+' | head -n 1)

echo "Detected architecture: $ARCH_RAW → $ARCH_1"
echo "Resolved download URL: $agh_file_down"
echo "AdGuardHome version: $latest_version"

# Proses download dan ekstrak
if [[ -n "$agh_file_down" ]]; then
  mkdir -p files/opt
  if wget -nv "$agh_file_down" -P files/opt; then
    echo "Extracting AdGuardHome..."
    if tar -zxvf "files/opt/${agh_file}.tar.gz" -C files/opt; then
      rm "files/opt/${agh_file}.tar.gz"
      echo "Done! Installed AdGuardHome version $latest_version for architecture $ARCH_1"
    else
      echo "Error: Failed to extract AdGuardHome."
      exit 1
    fi
  else
    echo "Error: Failed to download AdGuardHome."
    exit 1
  fi
else
  echo "Error: Could not resolve AdGuardHome download URL."
  exit 1
fi
