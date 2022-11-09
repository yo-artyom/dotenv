" Initially set it to "dark" or "light" according to your default
let s:mybg = "dark"
function! DarkModeToggle()
    if (s:mybg ==? "light")
       set background=dark
       colorscheme OceanicNext
       let s:mybg = "dark"
    else
       set background=light
       colorscheme humanoid
       let s:mybg = "light"
    endif
    " set background=light
    " colorscheme OceanicNext
endfunction

nnoremap <silent> <leader>td :call DarkModeToggle()<cr>
