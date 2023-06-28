call plug#begin('~/.vim/bundle')

Plug 'VundleVim/Vundle.vim'

Plug 'tpope/vim-fugitive', { 'on': 'Git' }

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Search files
Plug 'nvim-lua/plenary.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'scrooloose/nerdcommenter'

Plug 'mileszs/ack.vim', { 'on': 'Ack' }

Plug 'tpope/vim-surround'

Plug 'mattn/emmet-vim', { 'for': ['html', 'vue', 'erb'] }

Plug 'mhinz/vim-startify'

Plug 'Lokaltog/vim-easymotion'

Plug 'ntpeters/vim-better-whitespace'

" UI
Plug 'nvim-lualine/lualine.nvim'
Plug 'akinsho/bufferline.nvim'

Plug 'rose-pine/neovim'
Plug 'rebelot/kanagawa.nvim'

" Icons
Plug 'ryanoasis/vim-devicons'

" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Mics
Plug 'vimwiki/vimwiki'

call plug#end()
