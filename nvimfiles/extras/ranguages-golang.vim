NeoBundle 'dgryski/vim-godef'
NeoBundle 'fatih/vim-go'

augroup Golang
  autocmd!
  autocmd FileType go setlocal completeopt-=preview
augroup END

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

au BufNewFile,BufRead *.go set sw=4 noexpandtab ts=4 completeopt=menu,preview
au FileType go compiler go
