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
       AirlineTheme oceanicnextlight
    endif

  try
    execute "AirlineRefresh"
  catch
  endtry
endfunction

function! ToggleThemeTo(toggleTo)
    if (a:toggleTo ==? "dark")
       set background=dark
       colorscheme OceanicNext
    else
       set background=light
       colorscheme humanoid
       AirlineTheme oceanicnextlight
    endif

  try
    execute "AirlineRefresh"
  catch
  endtry
endfunction

nnoremap <silent> <leader>td :call DarkModeToggle()<cr>
