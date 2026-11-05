local map = vim.keymap.set

-- delete to t register
map("n", "d", '"td')

map("n", "<leader>a", ':Ack! "\\b<C-R><C-W>\\b"<CR>')
map("n", "<leader>ack", ":Ack<SPACE>")
map("n", "<leader>p", ":NERDTreeToggle<CR>")

map("n", "<C-space>", "i")
map("i", "<C-space>", "<Esc>")

map("n", "<C-j>", "i")
map("i", "<C-j>", "<Esc>")

-- FZF mappings
-- helps to open files in the current window; if current window is NERDTree,
-- move cursor to the next window and open file there
vim.cmd([[
  function! FZFOpen(command_str)
    if (expand('%') =~# 'NERD_tree' && winnr('$') > 1)
      exe "normal! \<c-w>\<c-w>"
    endif
    exe 'normal! ' . a:command_str . "\<cr>"
  endfunction
]])

map("n", "<C-t>", ':call FZFOpen(":Buffers")<CR>', { silent = true })
map("n", "<C-p>", ':call FZFOpen(":GFiles")<CR>', { silent = true })
map("n", "<C-g>", ':call FZFOpen(":Commands")<CR>', { silent = true })

-- keys for buffer switch
map("n", "gn", ":bn<cr>")
map("n", "gp", ":bp<cr>")
map("n", "gd", ":bd<cr>")
map("n", "gb", ":BufferLinePick<CR>", { silent = true })
map("n", "gbp", ":BufferLineTogglePin<CR>", { silent = true })

-- Mappings to access buffers: <Leader>1 .. <Leader>20
for i = 1, 20 do
  map("n", "<Leader>" .. i, ":" .. i .. "b<CR>")
end

-- quickfix list
map("n", "<C-n>", ":cnext<CR>")
map("n", "<C-m>", ":cprevious<CR>")
map("n", "<leader>q", ":cclose<CR>")

-- Splits
map("n", ",v", "<C-w>v")
map("n", ",h", "<C-w>s")

map("n", "<C-S-Right>", ":vertical resize +5<CR>", { silent = true })
map("n", "<C-S-Down>", ":resize +5<CR>", { silent = true })
map("n", "<C-S-Left>", ":vertical resize -5<CR>", { silent = true })
map("n", "<C-S-Up>", ":resize -5<CR>", { silent = true })

-- Copy to clipboard
map("v", "<leader>o", '"*y')

-- Press Space to turn off highlighting and clear any message already displayed.
map("n", "<Space>", ":nohlsearch<Bar>:echo<CR>", { silent = true })

map("n", "<F8>", function()
  return ":%s/\\<" .. vim.fn.expand("<cword>") .. "\\>/<&>/g<CR>"
end, { expr = true, silent = true })

local augroup = vim.api.nvim_create_augroup("dotenv_keymaps", { clear = true })

-- Elixir
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "elixir",
  callback = function(args)
    map("n", ",p", "Orequire IEx; IEx.pry<ESC>", { buffer = args.buf })
    map("n", ",o", "IO.IO.puts \"\"<ESC>hi", { buffer = args.buf })
  end,
})

-- Python
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "python",
  callback = function(args)
    map(
      "n",
      ",p",
      "Oimport code; code.interact(local=dict(globals(), **locals()))<ESC>",
      { buffer = args.buf }
    )
    map("n", ",o", 'Oprint("")<ESC>hi', { buffer = args.buf })
  end,
})

-- Ruby
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "ruby",
  callback = function(args)
    map("n", ",p", "Obinding.pry<ESC>", { buffer = args.buf })
    map("n", ",o", 'Oputs ""<ESC>hi', { buffer = args.buf })
  end,
})

-- JavaScript / TypeScript
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "javascript", "typescript" },
  callback = function(args)
    map("n", ",p", "Odebugger;<ESC>", { buffer = args.buf })
    map("n", ",o", "Oconsole.log('');<ESC>hi", { buffer = args.buf })
  end,
})

-- Go
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "go",
  callback = function(args)
    map("n", ",o", 'Ofmt.Println("")<ESC>hi', { buffer = args.buf })
  end,
})

-- Markdown
map("n", "<leader>mr", ":RenderMarkdown toggle<CR>", { silent = true })
