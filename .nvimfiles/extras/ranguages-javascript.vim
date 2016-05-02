Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'othree/yajs.vim', { 'for': 'javascript' }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }
Plug 'mattn/jscomplete-vim', { 'for': 'javascript' }
Plug 'moll/vim-node', { 'for': 'javascript' }

augroup JavaScript
  autocmd!
  autocmd FileType javascript setlocal omnifunc=jscomplete#CompleteJS
  autocmd FileType javascript setlocal completeopt-=preview
augroup END

" let g:used_javascript_libs = 'jquery,underscore,backbone'
let g:javascript_enable_domhtmlcss = 1


