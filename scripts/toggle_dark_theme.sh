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

# NVIM
# Send toggle dark mode for each (n)vim window in current tmux session
for wix in $(tmux list-windows -F '#{window_index}')
do
  for pix in $(tmux list-panes -F '#{window_index}.#{pane_index}' -t $wix)
  do
    is_vim="ps -o state= -o comm= -t '#{pane_tty}'  | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?\$'"
    tmux if-shell -t "$pix" "$is_vim" "send-keys -t $pix escape ENTER"
    tmux if-shell -t "$pix" "$is_vim" "send-keys -t $pix ':call ToggleThemeTo(\"$toggleToTheme\")' ENTER"
  done
done

# Alacritty
# switch theme, $1 is one of ['light', 'dark']
alacritty_toggle_theme () {
  if [ ! -f ~/.alacritty/colorSchemes.yml ]
  then
    echo 'File ~/.alacritty/colorSchemes.yml does not exist'
    return
  fi
  # sed does not like symlinks, get the absolute path
  config_path=$(realpath ~/.alacritty/colorSchemes.yml)

  sed -i "" -e "s#^colors: \*.*#colors: *$1#g" $config_path

  echo "switched to $1."
}

alacritty_toggle_theme $toggleToTheme
