#!/bin/bash

toggle_to_theme="dark"
state_file="$HOME/.currentColorScheme"

if [[ ! -f "$state_file" ]]; then
  printf 'dark\n' > "$state_file"
  toggle_to_theme="light"
fi

if [[ "$(<"$state_file")" == "dark" ]]; then
  printf 'light\n' > "$state_file"
  toggle_to_theme="light"
else
  printf 'dark\n' > "$state_file"
fi

# NVIM + TMUX change opened terminal colos
# Send toggle dark mode for each (n)vim window in current tmux session
nvim_tmux_toggle_theme () {
  if ! tmux list-windows > /dev/null 2>&1; then
    return
  fi

  for wix in $(tmux list-windows -F '#{window_index}')
  do
    for pix in $(tmux list-panes -F '#{window_index}.#{pane_index}' -t "$wix")
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
  local config_path="$HOME/.config/nvim/color.vim"
  local temp_file

  if [[ ! -f "$config_path" ]]; then
    echo "File $config_path does not exist"
    return
  fi

  temp_file="$(mktemp)"
  sed "s#^let currentTheme=\".*\"#let currentTheme=\"$1\"#g" "$config_path" > "$temp_file"
  mv "$temp_file" "$config_path"
}

# Alacritty
# switch theme, $1 is one of ['light', 'dark']
# theme toggle achieved by replacing a single word in color scheme alacritty config
alacritty_toggle_theme () {
  local config_path="$HOME/.config/alacritty/currentTheme.toml"

  if [[ ! -f "$config_path" ]]; then
    echo 'File ~/.config/alacritty/currentTheme.toml does not exist'
    return
  fi

  printf 'import = ["~/.config/alacritty/%sTheme.toml"]\n' "$1" > "$config_path"
}

# TMUX
# switch theme, $1 is one of ['light', 'dark']
# theme toggle achieved by replacing a single word in color scheme tmux config
tmux_toggle_theme() {
  local config_path="$HOME/.tmux/current_theme.conf"

  if [[ ! -f "$config_path" ]]; then
    echo 'File ~/.tmux/current_theme.conf does not exist'
    return
  fi

  printf 'source-file ~/.tmux/%s_theme.conf\n' "$1" > "$config_path"

  if tmux list-windows > /dev/null 2>&1; then
    tmux source-file "$config_path"
  fi
}

alacritty_toggle_theme "$toggle_to_theme"
nvim_tmux_toggle_theme "$toggle_to_theme"
nvim_init_toggle_theme "$toggle_to_theme"
tmux_toggle_theme "$toggle_to_theme"

echo "switched to $toggle_to_theme."
