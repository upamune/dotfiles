Plug 'kballard/vim-swift'

if has('mac')
  Plug 'landaire/deoplete-swift', { 'for' : 'swift' }
else
  Plug 'tokorom/swift-dict.vim', { 'for' : 'swift' }
  set complete+=k
endif

let errorformat =
      \ '%E%f:%l:%c: error: %m,' .
      \ '%W%f:%l:%c: warning: %m,' .
      \ '%Z%\s%#^~%#,' .
      \ '%-G%.%#'

let g:neomake_swift_swiftc_maker = {
      \ 'exe': 'swiftc',
      \ 'args': ['-parse'],
      \ 'errorformat': errorformat,
      \ }

let g:neomake_swift_enabled_makers = ['swiftc']
