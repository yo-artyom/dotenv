local augroup = vim.api.nvim_create_augroup("dotenv_conf", { clear = true })

vim.api.nvim_create_autocmd("StdinReadPre", {
  group = augroup,
  callback = function()
    vim.g.std_in = 1
  end,
})

-- vim-go alternate file commands
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "go",
  callback = function()
    vim.cmd([[
      command! -buffer -bang A call go#alternate#Switch(<bang>0, 'edit')
      command! -buffer -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
      command! -buffer -bang AS call go#alternate#Switch(<bang>0, 'split')
      command! -buffer -bang AT call go#alternate#Switch(<bang>0, 'tabe')
    ]])
  end,
})

-- Set title for terminal tab
vim.opt.title = true
vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup,
  callback = function()
    vim.o.titlestring = " " .. vim.fn.expand("%:t")
  end,
})
