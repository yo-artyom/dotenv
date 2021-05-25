" delete to t register
nnoremap d "td

nnoremap <leader>a :Ack<SPACE>
nnoremap <leader>p :NERDTreeToggle<CR>

" imap jj <Esc>
nnoremap <C-space> i
imap <C-space> <Esc>

nnoremap <C-j> i
imap <C-j> <Esc>


nnoremap <leader><Space> :CtrlP<CR>

" keys for buffer switch
map gn :bn<cr>
map gp :bp<cr>
map gd :bd<cr>

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

"" Splits Resize
nnoremap <Up> :resize +2<CR>
nnoremap <Down> :resize -2<CR>
nnoremap <Left> :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

" Debug shortcuts
autocmd FileType elixir nnoremap ,p Orequire IEx; IEx.pry<ESC>
autocmd FileType python nnoremap ,p Oimport code; code.interact(local=dict(globals(), **locals()))<ESC>
nnoremap ,p Obinding.pry<ESC>

" Copy to clipboard map
vmap <leader>o "*y

" Press Space to turn off highlighting and clear any message already displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

set langmap=№#,ЙQ,ЦW,УE,КR,ЕT,НY,ГU,ШI,ЩO,ЗP,Х{,Ъ},ФA,ЫS,ВD,АF,ПG,РH,ОJ,ЛK,ДL,Ж:,Э\",Ё\|,ЯZ,ЧX,СC,МV,ИB,ТN,ЬM,Б<,Ю>,йq,цw,уe,кr,еt,нy,гu,шi,щo,зp,х[,ъ],фa,ыs,вd,аf,пg,рh,оj,лk,дl,ж\\;,э',ё\\\\,яz,чx,сc,мv,иb,тn,ьm,ю.,б\\,
" let g:user_emmet_leader_key=','
