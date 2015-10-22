NeoBundleLazy 'hail2u/vim-css3-syntax', {'autoload': {'filetypes': ['css']}}

augroup css
  autocmd!
  autocmd FileType css setlocal iskeyword+=-
augroup END
