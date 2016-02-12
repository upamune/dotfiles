set backspace=indent,start,eol
set number

set shiftwidth=2
set smartindent

set expandtab
set smarttab

set cursorline

" No ゴミ
set nowritebackup
set nobackup
set noswapfile

" UTF-8
set encoding=UTF-8
set fileencoding=UTF-8
set termencoding=UTF-8

" 大文字小文字を区別しない
set infercase
set ignorecase
set smartcase

" カッコを対応させる
set showmatch
set matchtime=1

" inc search
set hlsearch
set incsearch

" Shift-K :help
set keywordprg=:help

" クリップボードを有効にする
set clipboard+=unnamedplus

" C-f で最後の1行だけにならない
noremap <expr> <C-b> max([winheight(0) - 2, 1]) . "\<C-u>" . (line('.') < 1         + winheight(0) ? 'H' : 'L')
noremap <expr> <C-f> max([winheight(0) - 2, 1]) . "\<C-d>" . (line('.') > line('$') - winheight(0) ? 'L' : 'H')
noremap <expr> <C-y> (line('w0') <= 1         ? 'k' : "\<C-y>")
noremap <expr> <C-e> (line('w$') >= line('$') ? 'j' : "\<C-e>")
