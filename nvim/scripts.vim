" toggle to switches theme between 'dark' and 'light' options
function! ToggleThemeTo(toggleTo)
  if (a:toggleTo ==? "dark")
    set background=dark
    colorscheme kanagawa
  else
    set background=light
    colorscheme humanoid
  endif
endfunction
