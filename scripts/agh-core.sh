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

# Validasi arsitektur
if [[ -z "$ARCH_1" ]]; then
  echo "Error: Unsupported architecture: $ARCH_RAW"
  exit 1
fi

# Ambil JSON rilisan terbaru dari GitHub API
agh_api="https://api.github.com/repos/AdguardTeam/AdGuardHome/releases/latest"
release_json=$(curl -sSL "$agh_api")

# Ekstrak versi dan URL download
latest_version=$(echo "$release_json" | grep -oP '"tag_name":\s*"\K(v[0-9]+\.[0-9]+\.[0-9]+)')
agh_file="AdGuardHome_linux_${ARCH_1}"
agh_file_url=$(echo "$release_json" | grep -oP '"browser_download_url":\s*"\K(https.*'"$agh_file"'.*?\.tar\.gz)')

echo "Detected architecture: $ARCH_RAW → $ARCH_1"
echo "Resolved download URL: $agh_file_url"
echo "AdGuardHome version: $latest_version"

# Cek dan unduh file jika URL tersedia
if [[ -n "$agh_file_url" ]]; then
  mkdir -p files/opt
  if wget -nv "$agh_file_url" -P files/opt; then
    echo "Extracting AdGuardHome..."
    if tar -zxvf "files/opt/${agh_file}.tar.gz" -C files/opt; then
      rm "files/opt/${agh_file}.tar.gz"
      echo "✅ Done! Installed AdGuardHome version $latest_version for architecture $ARCH_1"
    else
      echo "❌ Error: Failed to extract AdGuardHome."
      exit 1
    fi
  else
    echo "❌ Error: Failed to download AdGuardHome."
    exit 1
  fi
else
  echo "❌ Error: Could not resolve AdGuardHome download URL."
  exit 1
fi
