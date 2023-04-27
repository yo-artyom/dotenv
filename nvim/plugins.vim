call plug#begin('~/.vim/bundle')

Plug 'VundleVim/Vundle.vim'

Plug 'tpope/vim-fugitive'

Plug 'scrooloose/nerdtree'

Plug 'scrooloose/nerdcommenter'

Plug 'mileszs/ack.vim'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-surround'

Plug 'mattn/emmet-vim'

Plug 'mhinz/vim-startify'

Plug 'Lokaltog/vim-easymotion'

Plug 'ntpeters/vim-better-whitespace'

" Themes
Plug 'nvim-lualine/lualine.nvim'
Plug 'akinsho/bufferline.nvim'

Plug 'humanoid-colors/vim-humanoid-colorscheme'
Plug 'rebelot/kanagawa.nvim'

" Icons
Plug 'ryanoasis/vim-devicons'

" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Mics
Plug 'vimwiki/vimwiki'
call plug#end()
