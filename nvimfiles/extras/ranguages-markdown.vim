NeoBundle 'kannokanno/previm', { 'depends': 'tyru/open-browser.vim', 'autoload': {'filetypes': ['markdown']}}

augroup PrevimSettings
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END
