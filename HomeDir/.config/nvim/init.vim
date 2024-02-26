let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'navarasu/onedark.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Remember to do :TSInstall julia
"Plug 'romgrk/barbar.nvim'	" Get clickable tab line
"Plug 'nvim-tree/nvim-web-devicons'  " Get icons in tabline
Plug 'preservim/nerdtree'	" Get file explorer
call plug#end()

" Use onedark
colorscheme onedark

" Start NERDTree if nvim is called without file
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
