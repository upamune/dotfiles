NeoBundleLazy 'pangloss/vim-javascript', {'autoload': {'filetypes': ['javascript']}}
NeoBundleLazy 'othree/yajs.vim', {'autoload': {'filetypes': ['javascript']}}
NeoBundleLazy 'othree/javascript-libraries-syntax.vim', {'autoload': {'filetypes': ['javascript']}}
NeoBundleLazy 'mattn/jscomplete-vim', {'autoload': {'filetypes': ['javascript']}}

augroup JavaScript
  autocmd!
  autocmd FileType javascript setlocal omnifunc=jscomplete#CompleteJS
  autocmd FileType javascript setlocal completeopt-=preview
augroup END

" let g:used_javascript_libs = 'jquery,underscore,backbone'
let g:javascript_enable_domhtmlcss = 1


