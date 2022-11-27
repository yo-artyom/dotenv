" toggle to switches theme between 'dark' and 'light' options
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
