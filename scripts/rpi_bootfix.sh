#!/bin/bash
set -e

echo "📦 Copying Raspberry Pi bootloader files..."

BOOT_DIR="boot"
TARGET_BOOT_DIR="bin/targets/$TARGET_SYSTEM"

mkdir -p "$BOOT_DIR"
mkdir -p "$TARGET_BOOT_DIR"

cp files/rpi-boot/* "$BOOT_DIR/"
cp files/rpi-boot/* "$TARGET_BOOT_DIR/"

echo "✅ Bootloader files added to: $BOOT_DIR and $TARGET_BOOT_DIR"
