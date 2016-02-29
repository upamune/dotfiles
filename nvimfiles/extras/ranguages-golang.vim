NeoBundleLazy 'dgryski/vim-godef', {'autoload': {'filetypes': ['go']}}
NeoBundleLazy 'fatih/vim-go', {'autoload': {'filetypes': ['go']}}
NeoBundleLazy 'vim-jp/vim-go-extra', {'autoload': {'filetypes': ['go']}}
NeoBundleLazy 'zchee/deoplete-go', {'autoload' : {'filetypes' : ['go']}, 'build': {'unix': 'make'}}

augroup golang
  autocmd!
  autocmd FileType go setlocal completeopt-=preview
  autocmd FileType go :highlight goErr cterm=bold ctermfg=214
  autocmd FileType go :match goErr /\<err\>/
augroup END

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"

au BufNewFile,BufRead *.go set sw=4 noexpandtab ts=4 completeopt=menu,preview
au FileType go compiler go
