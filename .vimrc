set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'

Plugin 'L9'

Plugin 'pangloss/vim-javascript'

Plugin 'elixir-lang/vim-elixir'

Plugin 'vim-ruby/vim-ruby'

Plugin 'elzr/vim-json'

Plugin 'mxw/vim-jsx'

Plugin 'scrooloose/nerdtree'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'mileszs/ack.vim'

Plugin 'scrooloose/nerdcommenter'

Plugin 'kien/ctrlp.vim'

Plugin 'tpope/vim-surround'

Plugin 'mattn/emmet-vim'

Plugin 'posva/vim-vue'

Plugin 'slim-template/vim-slim'

Plugin 'fatih/vim-nginx'

Plugin 'morhetz/gruvbox'

call vundle#end()            " required
filetype plugin indent on    " required

autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let g:solarized_termcolors=256
set t_Co=256
"colorscheme solarized
" colorscheme elrodeo
let g:gruvbox_invert_tabline=1
let g:gruvbox_invert_selection=0
colorscheme gruvbox


syntax on
set background=dark
highlight Comment ctermfg=darkblue

set relativenumber

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1
let g:airline_theme =  'base16_railscasts'
let NERDTreeShowHidden=1

set laststatus=2

set shiftwidth=2
set expandtab
set tabstop=2

let g:ruby_path = system('echo $HOME/.rbenv/shims')

set showcmd 

set showmatch 
set incsearch
set ignorecase

set backspace=indent,eol,start

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

nnoremap \a :Ack<SPACE>

imap jj <Esc>

nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>

let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1

" folding
setlocal foldmethod=syntax
set foldlevelstart=20

set wildmenu

set wildignore+=.git,.idea
set wildignore+=*.png,*.jpg,*.gif

" ignore bundles
set wildignore+=*/vendor/bundle/*
set wildignore+=*/vendor/bundler/*

" ignore node modules
set wildignore+=*/node_modules/*

set wildignore+=*/tmp/*
set wildignore+=*/log/*
set wildignore+=*/public/system/*

set linebreak

set langmap=№#,ЙQ,ЦW,УE,КR,ЕT,НY,ГU,ШI,ЩO,ЗP,Х{,Ъ},ФA,ЫS,ВD,АF,ПG,РH,ОJ,ЛK,ДL,Ж:,Э\",Ё\|,ЯZ,ЧX,СC,МV,ИB,ТN,ЬM,Б<,Ю>,йq,цw,уe,кr,еt,нy,гu,шi,щo,зp,х[,ъ],фa,ыs,вd,аf,пg,рh,оj,лk,дl,ж\\;,э',ё\\\\,яz,чx,сc,мv,иb,тn,ьm,ю.,б\\,

set noswapfile
