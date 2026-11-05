-- Coc.nvim configuration (former nvim/lsp.vim)
local keyset = vim.keymap.set

vim.cmd([[
  function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
      call CocActionAsync('doHover')
    else
      call feedkeys('K', 'in')
    endif
  endfunction
]])

-- Use tab for trigger completion with characters ahead and navigate.
keyset("i", "<TAB>", [[coc#pum#visible() ? coc#pum#next(1) : CheckBackspace() ? "\<Tab>" : coc#refresh()]], {
  silent = true,
  expr = true,
})
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], { expr = true })

-- Make <CR> to accept selected completion item or notify coc.nvim to format
keyset(
  "i",
  "<CR>",
  [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]],
  { silent = true, expr = true }
)

-- Use <c-space> to trigger completion.
keyset("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })

keyset("n", "gdd", "<Plug>(coc-definition)", { silent = true })
keyset("n", "gyy", "<Plug>(coc-type-definition)", { silent = true })
keyset("n", "gii", "<Plug>(coc-implementation)", { silent = true })
keyset("n", "grr", "<Plug>(coc-references)", { silent = true })

-- Use K to show documentation in preview window.
keyset("n", "K", ":call ShowDocumentation()<CR>", { silent = true })

-- Formatting selected code.
keyset({ "x", "n" }, "<leader>f", "<Plug>(coc-format-selected)")

local augroup = vim.api.nvim_create_augroup("dotenv_coc", { clear = true })

-- Highlight the symbol and its references when holding the cursor.
vim.api.nvim_create_autocmd("CursorHold", {
  group = augroup,
  callback = function()
    vim.fn.CocActionAsync("highlight")
  end,
})

-- golang autoimport on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  pattern = "*.go",
  callback = function()
    vim.fn.CocAction("runCommand", "editor.action.organizeImport")
  end,
})
