call plug#begin()

" User interface
Plug 'itchyny/lightline.vim'
Plug 'junegunn/goyo.vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'haishanh/night-owl.vim'
Plug 'ap/vim-buftabline'
Plug 'arcticicestudio/nord-vim'
Plug 'trevordmiller/nova-vim'

" Project navigation
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'ervandew/supertab'

" File navigation
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'easymotion/vim-easymotion'

" Editing
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'editorconfig/editorconfig-vim'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-commentary'
Plug 'prettier/vim-prettier', { 'do': 'yarn install', 'branch': 'release/1.x' }
Plug 'alvan/vim-closetag'
Plug 'jiangmiao/auto-pairs'

" Task Running
Plug 'w0rp/ale'
Plug 'janko/vim-test'
Plug 'benmills/vimux'

" Git
Plug 'tpope/vim-fugitive'


Plug 'christoomey/vim-tmux-navigator'
call plug#end()
