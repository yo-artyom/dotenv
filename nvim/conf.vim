language en_US

set encoding=utf8

set signcolumn=yes

autocmd StdinReadPre * let s:std_in=1

autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

set relativenumber

" let $NVIM_TUI_ENABLE_TRUE_COLOR=1
if (has("termguicolors"))
 set termguicolors
endif

" Theme
" dark theme
if currentTheme == "dark"
  set background=dark
  colorscheme kanagawa
else
  set background=light
  colorscheme humanoid
endif

set guifont=DroidSansMono\ Nerd\ Font:h11

lua << END

require('lualine').setup({
  extensions = {'fugitive', 'nerdtree', 'quickfix'},
})

require("bufferline").setup{
  options = {
    numbers = "buffer_id",
    diagnostics = "coc"
   }
 }
END

" NerdTree settings
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1
let g:NERDTreeWinPos="right"
let NERDTreeMinimalUI=1

" Indent
set shiftwidth=2
set tabstop=2
set expandtab

set showcmd

set showmatch
set incsearch
set ignorecase

set backspace=indent,eol,start

" Macros for blocks
runtime macros/matchit.vim

let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1

" folding
set foldmethod=syntax
set foldlevelstart=20

set wildmenu

set colorcolumn=80

set linebreak

let g:ctrlp_prompt_mappings = {
  \ 'ToggleRegex()':        ['<F5>'],
  \ 'PrtClearCache()':      ['<c-r>'],
  \ }

set noswapfile

" Set title for terminal tab
autocmd BufEnter * let &titlestring = ' ' . expand("%:t")
set title

" VimWiki
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
