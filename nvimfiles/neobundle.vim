set runtimepath+=~/.nvim/bundle/neobundle.vim

call neobundle#begin(expand('~/.nvim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'

runtime! nvimfiles/extras/*.vim

call neobundle#end()
NeoBundleCheck

filetype plugin indent on
