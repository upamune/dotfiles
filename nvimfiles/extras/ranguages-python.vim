NeoBundle 'hynek/vim-python-pep8-indent'
NeoBundle 'jmcantrell/vim-virtualenv'
NeoBundle 'davidhalter/jedi-vim'

augroup Python
  autocmd!
  autocmd FileType python setlocal omnifunc=jedi#completions
  autocmd FileType python setlocal completeopt-=preview
augroup END

let g:jedi#popup_select_first = 0
let g:jedi#popup_on_dot = 0
let g:jedi#auto_vim_configuration = 0
