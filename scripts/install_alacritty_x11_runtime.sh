#!/bin/bash

set -euo pipefail

runtime_root="${XDG_DATA_HOME:-$HOME/.local/share}/alacritty-x11-runtime"
temp_dir="$(mktemp -d)"
packages=(
    libxcb-xkb1
    libxkbcommon-x11-0
)

cleanup() {
    rm -rf "$temp_dir"
}

trap cleanup EXIT

mkdir -p "$runtime_root"

for package_name in "${packages[@]}"; do
    (
        cd "$temp_dir"
        apt-get download "$package_name" > /dev/null
    )
done

for package_file in "$temp_dir"/*.deb; do
    dpkg-deb -x "$package_file" "$runtime_root"
done
