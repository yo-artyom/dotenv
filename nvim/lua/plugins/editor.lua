return {
  { "tpope/vim-fugitive", cmd = "Git" },

  {
    "scrooloose/nerdtree",
    cmd = "NERDTreeToggle",
    keys = { { "<leader>p", ":NERDTreeToggle<CR>", desc = "Toggle NERDTree" } },
  },

  { "mileszs/ack.vim", cmd = "Ack" },

  { "tpope/vim-surround" },

  { "mattn/emmet-vim" },

  { "mhinz/vim-startify" },

  { "easymotion/vim-easymotion" },

  { "ntpeters/vim-better-whitespace" },

  {
    "scrooloose/nerdcommenter",
    init = function()
      vim.g.NERDSpaceDelims = 1
      vim.g.NERDCompactSexyComs = 1
    end,
  },

  { "ryanoasis/vim-devicons" },
}
