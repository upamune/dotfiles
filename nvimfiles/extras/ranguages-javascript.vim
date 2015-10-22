NeoBundle 'pangloss/vim-javascript'
NeoBundle 'othree/yajs.vim'
NeoBundle 'othree/javascript-libraries-syntax.vim'
NeoBundle 'mattn/jscomplete-vim'

augroup JavaScript
  autocmd!
  autocmd FileType javascript setlocal omnifunc=jscomplete#CompleteJS
  autocmd FileType javascript setlocal completeopt-=preview
augroup END

" let g:used_javascript_libs = 'jquery,underscore,backbone'
let g:javascript_enable_domhtmlcss = 1


