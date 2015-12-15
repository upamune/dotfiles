NeoBundleLazy 'hynek/vim-python-pep8-indent', {'autoload': {'filetypes': ['python']}}
NeoBundleLazy 'tell-k/vim-autopep8', {'autoload': {'filetypes': ['python']}}
NeoBundleLazy 'jmcantrell/vim-virtualenv', {'autoload': {'filetypes': ['python']}}
NeoBundleLazy 'davidhalter/jedi-vim', {'autoload': {'filetypes': ['python']}}

augroup Python
  autocmd!
  autocmd FileType python setlocal omnifunc=jedi#completions
  autocmd FileType python setlocal completeopt-=preview
augroup END

let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:autopep8_disable_show_diff=1
