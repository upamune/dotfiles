NeoBundle 'benekastah/neomake'

augroup AutoNeomake
  autocmd!
  autocmd BufWritePost * Neomake
augroup END

" g:neomake_{ language }_{ makername }_maker
" g:neomake_{ language }_enabled_makers = ['', '']

" Python
let g:neomake_python_enabled_markers = ['pep8', 'flake8']

" Golang
let g:neomake_go_enabled_markers = ['go', 'golint']

" Scala
let g:neomake_scala_enabled_markers = ['scalac', 'scalastyle']

" JavaScript
let g:neomake_javascript_enabled_markers = ['eslint']

" sh
let g:neomake_sh_enabled_markers = ['shellcheck']

" Zsh
let g:neomake_zsh_enabled_markers = ['shellcheck']

