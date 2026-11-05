local opt = vim.opt

vim.cmd("language en_US")

opt.signcolumn = "yes"
opt.relativenumber = true

if vim.fn.has("termguicolors") == 1 then
  opt.termguicolors = true
end

vim.o.guifont = "DroidSansMono Nerd Font:h11"

-- Indent
opt.shiftwidth = 2
opt.tabstop = 2
opt.expandtab = true

opt.showcmd = true
opt.showmatch = true
opt.incsearch = true
opt.ignorecase = true

opt.backspace = { "indent", "eol", "start" }

-- Folding
opt.foldmethod = "syntax"
opt.foldlevelstart = 20

opt.wildmenu = true
opt.colorcolumn = "80"
opt.linebreak = true
opt.swapfile = false

-- Wildignore (see former nvim/wildignore.vim)
opt.wildignore:append({
  ".git",
  ".idea",
  "*.png",
  "*.jpg",
  "*.gif",
  "*/vendor/bundle/*",
  "*/vendor/bundler/*",
  "*/deps/*",
  "*/node_modules/*",
  "*/tmp/*",
  "*/log/*",
  "*/public/system/*",
})

-- Macros for blocks
vim.cmd("runtime macros/matchit.vim")

-- NERDTree
vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeShowLineNumbers = 1
vim.g.NERDTreeWinPos = "right"

-- NOTE: NERDCommenter, VimWiki and Coc settings live next to their plugin
-- specs in lua/plugins/*.lua.
