#!/bin/bash

DOTFILES_DIR="${DOTFILES_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"

detect_platform() {
    case "$(uname -s)" in
        Darwin)
            printf 'macos\n'
            ;;
        Linux)
            if [[ -f /etc/os-release ]]; then
                local platform_id
                platform_id="$(. /etc/os-release && printf '%s' "${ID:-linux}")"
                case "$platform_id" in
                    ubuntu)
                        printf 'ubuntu\n'
                        ;;
                    *)
                        printf '%s\n' "$platform_id"
                        ;;
                esac
            else
                printf 'linux\n'
            fi
            ;;
        *)
            printf 'unsupported\n'
            ;;
    esac
}

require_supported_platform() {
    local platform
    platform="$(detect_platform)"

    case "$platform" in
        macos|ubuntu)
            printf '%s\n' "$platform"
            ;;
        *)
            echo "Unsupported platform: $platform. Supported platforms are macOS and Ubuntu." >&2
            return 1
            ;;
    esac
}

source_platform_script() {
    local stage="$1"
    local platform="$2"
    local script_path="$DOTFILES_DIR/platform/$stage/$platform.sh"

    if [[ ! -f "$script_path" ]]; then
        echo "Missing platform script: $script_path" >&2
        return 1
    fi

    # shellcheck disable=SC1090
    source "$script_path"
}

copy_fonts_to_dir() {
    local font_dir="$1"
    local font
    local font_name

    mkdir -p "$font_dir"

    for font in "$DOTFILES_DIR"/fonts/*; do
        [[ -e "$font" ]] || continue

        case "$font" in
            *.otf|*.ttf)
                font_name="$(basename "$font")"
                if [[ ! -f "$font_dir/$font_name" ]]; then
                    echo "  -> Installing $font_name"
                    cp "$font" "$font_dir/"
                else
                    echo "  -> $font_name already installed. Skipping..."
                fi
                ;;
        esac
    done
}
