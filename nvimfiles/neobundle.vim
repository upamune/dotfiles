set runtimepath+=~/.nvim/bundle/neobundle.vim

call neobundle#begin(expand('~/.nvim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'

runtime! nvimfiles/extras/*.vim

call neobundle#end()
NeoBundleCheck

" these syntax, color settings must be written after neobundle#end
syntax enable
set background=dark
colorscheme hybrid_material

filetype plugin indent on
