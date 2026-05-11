#!/bin/bash

set -euo pipefail

system_alacritty="/usr/bin/alacritty"
script_dir="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
runtime_root="${XDG_DATA_HOME:-$HOME/.local/share}/alacritty-x11-runtime"
runtime_lib_dir="$runtime_root/usr/lib/x86_64-linux-gnu"
runtime_installer="$script_dir/install_alacritty_x11_runtime.sh"

if [[ ! -x "$system_alacritty" ]]; then
    echo "Alacritty is not installed at $system_alacritty" >&2
    exit 1
fi

case "${1:-}" in
    --version|-V|--help|-h)
        exec "$system_alacritty" "$@"
        ;;
esac

run_x11_backend() {
    if [[ -f "$runtime_lib_dir/libxkbcommon-x11.so.0" ]]; then
        exec env -u WAYLAND_DISPLAY LD_LIBRARY_PATH="$runtime_lib_dir${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}" WINIT_UNIX_BACKEND=x11 "$system_alacritty" "$@"
    fi

    exec env -u WAYLAND_DISPLAY WINIT_UNIX_BACKEND=x11 "$system_alacritty" "$@"
}

if [[ -n "${WAYLAND_DISPLAY:-}" ]] && [[ -n "${DISPLAY:-}" ]]; then
    if ldconfig -p 2>/dev/null | grep -q 'libxkbcommon-x11\.so'; then
        run_x11_backend "$@"
    fi

    if [[ -x "$runtime_installer" ]]; then
        if "$runtime_installer" > /dev/null 2>&1; then
            run_x11_backend "$@"
        fi
    fi

    echo "Alacritty is installed, but the Ubuntu package crashes on Wayland in this session." >&2
    echo "Install the missing X11 runtime first: sudo apt-get install -y libxkbcommon-x11-0" >&2
    exit 1
fi

exec "$system_alacritty" "$@"
