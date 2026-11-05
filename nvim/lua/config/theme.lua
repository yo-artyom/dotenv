-- Theme handling (former nvim/color.vim + nvim/scripts.vim)
--
-- vim.g.currentTheme is toggled externally by scripts/toggle_dark_theme.sh
-- via a sed replacement, so keep the "let"-style assignment easy to match:
vim.g.currentTheme = "light"
vim.g.darkTheme = "kanagawa"
vim.g.lightTheme = "rose-pine-dawn"

local function apply_theme(theme)
  if theme == "dark" then
    vim.o.background = "dark"
    vim.cmd.colorscheme(vim.g.darkTheme)
  else
    vim.o.background = "light"
    vim.cmd.colorscheme(vim.g.lightTheme)
  end
end

-- Exposed as a global Vim function so it can still be triggered from
-- scripts/toggle_dark_theme.sh via `:call ToggleThemeTo("dark")`.
_G.ToggleThemeTo = function(toggle_to)
  apply_theme(toggle_to)
end

vim.cmd([[
  function! ToggleThemeTo(toggleTo)
    call v:lua.ToggleThemeTo(a:toggleTo)
  endfunction
]])

apply_theme(vim.g.currentTheme)
