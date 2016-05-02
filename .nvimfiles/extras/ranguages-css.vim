Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }

augroup css
  autocmd!
  autocmd FileType css setlocal iskeyword+=-
augroup END
