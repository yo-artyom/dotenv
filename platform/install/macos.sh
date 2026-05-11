#!/bin/bash

ensure_brew_in_path() {
    if command -v brew > /dev/null 2>&1; then
        return 0
    fi

    if [[ -x /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -x /usr/local/bin/brew ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
}

install_platform_packages() {
    if ! command -v brew > /dev/null 2>&1; then
        echo -e "\n\t[Brew install]\n"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        ensure_brew_in_path
    else
        ensure_brew_in_path
        echo "Homebrew already installed. Skipping..."
    fi

    if [[ -f "$DOTFILES_DIR/Brewfile" ]]; then
        echo -e "\n\t[Brew deps]\n"
        brew bundle --file "$DOTFILES_DIR/Brewfile"
    fi
}
