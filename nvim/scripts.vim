source $HOME/.config/nvim/color.vim

" toggle to switches theme between 'dark' and 'light' options
function! ToggleThemeTo(toggleTo)
  if (a:toggleTo ==? "dark")
    set background=dark
    execute 'colorscheme ' . g:darkTheme
  else
    set background=light
    execute 'colorscheme ' . g:lightTheme
  endif
endfunction
