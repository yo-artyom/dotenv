#!/bin/bash

toggleToTheme="dark"

if [ ! -f ~/.currentColorScheme ]
then
  echo "dark" >> ~/.currentColorScheme
  toggleToTheme="light"
fi

if [ $(cat ~/.currentColorScheme) == "dark" ]
then
  echo "light" > ~/.currentColorScheme
  toggleToTheme="light"
else
  echo "dark" > ~/.currentColorScheme
fi

# macOS Global Theme
# Uses AppleScript to tell System Events to change the appearance
macos_toggle_theme() {
  if [ "$1" == "dark" ]
  then
    osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to true'
  else
    osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to false'
  fi
}

# NVIM + TMUX change opened terminal colos
# Send toggle dark mode for each (n)vim window in current tmux session
nvim_tmux_toggle_theme () {
  for wix in $(tmux list-windows -F '#{window_index}')
  do
    for pix in $(tmux list-panes -F '#{window_index}.#{pane_index}' -t $wix)
    do
      is_vim="ps -o state= -o comm= -t '#{pane_tty}'  | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?\$'"
      tmux if-shell -t "$pix" "$is_vim" "send-keys -t $pix escape ENTER"
      tmux if-shell -t "$pix" "$is_vim" "send-keys -t $pix ':call ToggleThemeTo(\"$1\")' ENTER"
    done
  done
}

# NVIM
# changes initial nvim theme
nvim_init_toggle_theme () {
  # sed does not like symlinks, get the absolute path
  config_path=$(realpath ~/.config/nvim/lua/config/theme.lua)
  sed -i "" -e "s#^vim.g.currentTheme = \".*\"#vim.g.currentTheme = \"$1\"#g" $config_path
}

# Alacritty
# switch theme, $1 is one of ['light', 'dark']
# theme toggle achieved by replacing a single word in color scheme alacritty config
alacritty_toggle_theme () {
  if [ ! -f ~/.config/alacritty/currentTheme.toml ]
  then
    echo 'File ~/.config/alacritty/currentTheme.toml does not exist'
    return
  fi
  # sed does not like symlinks, get the absolute path
  config_path=$(realpath ~/.config/alacritty/currentTheme.toml)
  echo -e "[general]\nimport = [\"~/.config/alacritty/$1Theme.toml\"]" > "$config_path"
}

# TMUX
# switch theme, $1 is one of ['light', 'dark']
# theme toggle achieved by replacing a single word in color scheme tmux config
tmux_toggle_theme() {
  if [ ! -f ~/.tmux/current_theme.conf ]
  then
    echo 'File ~/.tmux/current_theme.conf does not exist'
    return
  fi
  # sed does not like symlinks, get the absolute path
  config_path=$(realpath ~/.tmux/current_theme.conf)

  echo "source-file ~/.tmux/$1_theme.conf" > "$config_path"
  tmux source-file "$config_path"
}

opencode_toggle_theme() {
  local mode="$1"
  local theme
  local config="$HOME/.config/opencode/tui.json"

  case "$mode" in
    dark)  theme="kanagawa" ;;
    light) theme="rose-pine-dawn" ;;
    *)
      echo "Unknown OpenCode theme mode: $mode" >&2
      return 1
      ;;
  esac

  mkdir -p "$(dirname "$config")"

  if [ -f "$config" ]; then
    local temp
    temp="$(mktemp)"

    jq --arg theme "$theme" \
      '.theme = $theme' \
      "$config" > "$temp" &&
      mv "$temp" "$config"
  else
    jq -n \
      --arg theme "$theme" \
      '{
        "$schema": "https://opencode.ai/tui.json",
        "theme": $theme
      }' > "$config"
  fi
}

# Execute all toggles
macos_toggle_theme $toggleToTheme
alacritty_toggle_theme $toggleToTheme
nvim_tmux_toggle_theme $toggleToTheme
nvim_init_toggle_theme $toggleToTheme
opencode_toggle_theme "$toggleToTheme"
tmux_toggle_theme $toggleToTheme

echo "switched to $toggleToTheme."
