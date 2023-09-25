" delete to t register
nnoremap d "td

nnoremap <leader>a :Ack<SPACE>
nnoremap <leader>p :NERDTreeToggle<CR>

" imap jj <Esc>
nnoremap <C-space> i
imap <C-space> <Esc>

nnoremap <C-j> i
imap <C-j> <Esc>


" FZF mappings
" function FZFOpen helps to open files in the current window
" if current window is NERDTree, it will move cursor to the next window and
" open file there
function! FZFOpen(command_str)
  if (expand('%') =~# 'NERD_tree' && winnr('$') > 1)
    exe "normal! \<c-w>\<c-w>"
  endif
  exe 'normal! ' . a:command_str . "\<cr>"
endfunction
nnoremap <silent> <C-t> :call FZFOpen(':Buffers')<CR>
nnoremap <silent> <C-p> :call FZFOpen(':GFiles')<CR>
nnoremap <silent> <C-g> :call FZFOpen(':Commands')<CR>

" keys for buffer switch
map gn :bn<cr>
map gp :bp<cr>
map gd :bd<cr>
nnoremap <silent> gb :BufferLinePick<CR>
nnoremap <silent> gbp :BufferLineTogglePin<CR>

" Mappings to access buffers
" Example command: nnoremap <Leader>1 :1b<CR>
for i in range(1,20)
  let key_comb = 'nnoremap <Leader>' . i
  let command = ":" . i . "b<CR>"
  execute key_comb . " " . command
endfor


" quickfix list
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>q :cclose<CR>

" Splits
nnoremap ,v <C-w>v
nnoremap ,h <C-w>s

noremap <silent> <C-S-Right> :vertical resize +5<CR>
noremap <silent> <C-S-Down> :resize +5<CR>

noremap <silent> <C-S-Left> :vertical resize -5<CR>
noremap <silent> <C-S-Up> :resize -5<CR>

" Copy to clipboard map
vmap <leader>o "*y

" Press Space to turn off highlighting and clear any message already displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

:nnoremap <expr> <F8> ':%s/\<'.expand('<cword>').'\>/<&>/g<CR>'

" Elixir
autocmd FileType elixir nnoremap ,p Orequire IEx; IEx.pry<ESC>
autocmd FileType elixir nnoremap ,o IO.IO.puts ""<ESC>hi

" Python
autocmd FileType python nnoremap ,p Oimport code; code.interact(local=dict(globals(), **locals()))<ESC>
autocmd FileType python nnoremap ,o Oprint("")<ESC>hi

" Ruby
autocmd FileType ruby nnoremap ,p Obinding.pry<ESC>
autocmd FileType ruby nnoremap ,o Oputs ""<ESC>hi

" JavaScript
autocmd FileType javascript,typescript nnoremap ,p Odebugger;<ESC>
autocmd FileType javascript,typescript nnoremap ,o Oconsole.log('');<ESC>hi

" Go
autocmd FileType go nnoremap ,o Ofmt.Println("")<ESC>hi
