Plug 'tyru/open-browser.vim' | Plug 'kannokanno/previm', { 'for': 'markdown'}

augroup PrevimSettings
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END
