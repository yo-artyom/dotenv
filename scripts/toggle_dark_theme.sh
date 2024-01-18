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
  config_path=$(realpath ~/.config/nvim/color.vim)
  sed -i "" -e "s#^let currentTheme=\".*\"#let currentTheme=\"$1\"#g" $config_path
}

# Alacritty
# switch theme, $1 is one of ['light', 'dark']
# theme toggle achieved by replacing a single word in color scheme alacritty config
alacritty_toggle_theme () {
  if [ ! -f ~/.alacritty/currentTheme.toml ]
  then
    echo 'File ~/.alacritty/currentTheme.toml does not exist'
    return
  fi
  # sed does not like symlinks, get the absolute path
  config_path=$(realpath ~/.alacritty/currentTheme.toml)
  echo "import = [\"~/.alacritty/$1Theme.toml\" ]" > $config_path
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

  echo "source-file ~/.tmux/$1_theme.conf" > $config_path
  tmux source-file $config_path
}

alacritty_toggle_theme $toggleToTheme
nvim_tmux_toggle_theme $toggleToTheme
nvim_init_toggle_theme $toggleToTheme
tmux_toggle_theme $toggleToTheme

echo "switched to $toggleToTheme."
