Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }
Plug 'tell-k/vim-autopep8', { 'for': 'python' }
Plug 'jmcantrell/vim-virtualenv', { 'for': 'python' }
Plug 'davidhalter/jedi-vim', { 'for': 'python' }

augroup Python
  autocmd!
  autocmd FileType python setlocal omnifunc=jedi#completions
  autocmd FileType python setlocal completeopt-=preview
augroup END

let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:autopep8_disable_show_diff=1
