" NeoBundle {{{
set runtimepath+=~/.vim/bundle/neobundle.vim/
" Required:
call neobundle#begin(expand('~/.vim/bundle/'))
" キャッシュを利用して高速化
if neobundle#load_cache()
  NeoBundleFetch 'Shougo/neobundle.vim'
  call neobundle#load_toml('~/.vim/neobundle.toml')
  call neobundle#load_toml('~/.vim/neobundlelazy.toml', {'lazy' :1} )
  NeoBundleSaveCache
endif

call neobundle#end()
NeoBundleCheck

" Basic Settings {{{

" タブ文字の代わりに半角スペースを使用する
set expandtab
" タブ幅を半角スペース2つ分にする
set shiftwidth=2
set smartindent
set smarttab

" バックスペースでなんでも消せるようにする
set backspace=indent,eol,start

"行番号を表示する
set number

" 現在現在行をハイライトする
set cursorline

" ゴミが生まれないようにする
set nowritebackup
set nobackup
set noswapfile
set noundofile

" UTF-8
set encoding=UTF-8
set fileencoding=UTF-8
set termencoding=UTF-8

" 補完するときに大文字小文字を区別しない
set infercase

" カッコを対応させる
set showmatch
set matchtime=1

" コマンドラインでの補完をべんりにする
set wildmenu

" }}}

" KeyMap {{{

" jj or kkでESCする
imap jj <Esc>
imap kk <Esc>

" コマンド検索、検索履歴を無効化する
nnoremap q: <Nop>
nnoremap q/ <Nop>
nnoremap q? <Nop>

" ノーマルモード時だけ ; と : を入れ替える (US用)
nnoremap ; :

" Yを行末までのヤンクにする
nnoremap Y y$

" ノーマルモード時矢印キーでバッファのリサイズ
nmap <UP> <C-w>-
nmap <Right> <C-w><
nmap <Down> <C-w>+
nmap <Left> <C-w>>

" インサートモード時の矢印キー
inoremap <Up> <ESC>:<C-u>GundoToggle<CR>
inoremap <Right> <Esc>:QuickRun<CR>
inoremap <Down> <Esc>:w<CR>i
inoremap <Left> <ESC>:VimFiler<CR>

" 3倍のスピードでヘルプを参照できるッ!!
nnoremap <C-h>  :<C-u>help<Space>

" 画面分割＆タブ関係
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>

call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')

" 選択時の<C-a>, <C-x>をべんりにする
vnoremap <C-a> <C-a>gv
vnoremap <C-x> <C-x>gv

" neocomplete (自動補完)
let g:neocomplete#max_list = 10
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1

" ヘルプ日本語化
set helplang=ja,en

" Unite.vim
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200

" uniteでスペースが表示されるので、設定でOFFにします。
let g:extra_whitespace_ignored_filetypes = ['unite']

" マッチしたものすべてをインクリメンタルにハイライトする
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
" 検索後カーソル移動したらハイライトすべて消す
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map   n <Plug>(incsearch-nohl-n)
map   N <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
" 検索時にヒット件数を出す
nmap  n <Plug>(incsearch-nohl)<Plug>(anzu-n-with-echo)
nmap  N <Plug>(incsearch-nohl)<Plug>(anzu-N-with-echo)

" 検索したあとに移動しない
nnoremap * *N
nnoremap # #N
map * <Plug>(visualstar-*)N
map # <Plug>(visualstar-#)N

" QuickRunしたら右に分割して結果を表示
let g:quickrun_config = {   "cpp/g++" : {       "cmdopt" : "-std=c++0x",       "hook/time/enable" : 1   },   "_" : {       "outputter/buffer/close_on_empty" : 1,       "runner" : "vimproc",       "runner/vimproc/updatetime" : 60,       "outputter/buffer/split" : ":botright 8sp",   },}
set splitright

" syntastic(シンタックスチェック)
let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_mode_map = { "mode" : "active"}
"ファイルオープン時にはチェックをしない
let g:syntastic_check_on_open = 0
"ファイル保存時にはチェックを実施
let g:syntastic_check_on_save = 1

" neosnippet
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/dotfiles/vim-snippet'

" コメントをトグルする(\c)でできる
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

" Gundo
" 移動と同時にプレビューしない
let g:gundo_auto_preview = 0
" Uでgundo開く
nmap U :<C-u>GundoToggle<CR>

" lightline.vim (ステータスラインをかっこよく)
set laststatus=2
" syntasticがエラーの時赤色にする(:call lightline#update)
let g:lightline = { 'colorscheme': 'wombat', 'mode_map': {'c': 'NORMAL'}, 'active': {   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ] }, 'component_function': {   'modified': 'MyModified',   'readonly': 'MyReadonly',   'fugitive': 'MyFugitive',   'filename': 'MyFilename',   'fileformat': 'MyFileformat',   'filetype': 'MyFiletype',   'fileencoding': 'MyFileencoding',   'mode': 'MyMode' } }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') . (&ft == 'vimfiler' ? vimfiler#get_status_string() :  &ft == 'unite' ? unite#get_status_string() :  &ft == 'vimshell' ? vimshell#get_status_string() : '' != expand('%:t') ? expand('%:t') : '[No Name]') . ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
let g:syntastic_mode_map = { 'mode': 'passive' }
augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

" VimからGistに投稿できるようにする
let g:gista#github_user = 'upamune'

" Vim motions on speed! http://haya14busa.com/mastering-vim-easymotion/
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1
let g:EasyMotion_startofline = 0
" EASY MOTION !!!
nmap <Space> <Plug>(easymotion-s2)
xmap <Space> <Plug>(easymotion-s2)
omap <Space> <Plug>(easymotion-s2)
" 行移動をべんりにする
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" Ruby{{{
" Rsense Ruby用補完
let g:rsenseHome = '/usr/local/lib/rsense-0.3'
let g:rsenseUseOmniFunc = 1
" Neocomplete
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'
" Rubocop シンタックスチェック
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']
" }}}

" Golang{{{
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['go'] }
let g:syntastic_go_checkers = ['go', 'golint']
set path+=$GOPATH/src/**
let g:gofmt_command = 'goimports'
au BufWritePre *.go Fmt
au BufNewFile,BufRead *.go set sw=4 noexpandtab ts=4 completeopt=menu,preview
au FileType go compiler go
let g:tagbar_type_go = { 'ctagstype' : 'go', 'kinds'     : [ 'p:package', 'i:imports:1', 'c:constants', 'v:variables', 't:types', 'n:interfaces', 'w:fields', 'e:embedded', 'm:methods', 'r:constructor', 'f:functions' ], 'sro' : '.', 'kind2scope' : { 't' : 'ctype', 'n' : 'ntype' }, 'scope2kind' : { 'ctype' : 't', 'ntype' : 'n' }, 'ctagsbin'  : 'gotags', 'ctagsargs' : '-sort -silent' }
" }}}

" C++{{{
if executable("clang++")
  let g:syntastic_cpp_compiler = 'clang++'
  let g:syntastic_cpp_compiler_options = '--std=c++11'
  let g:quickrun_config['cpp/clang++11'] = { 'cmdopt': '--std=c++11 --stdlib=libc++', 'type': 'cpp/clang++' }
  let g:quickrun_config['cpp'] = {'type': 'cpp/clang++11'}
endif
let g:clang_format#code_style = "llvm"
let g:clang_format#auto_format = 1

" FileType {{{

augroup MyGroup
  autocmd!
  autocmd BufNewFile,BufRead *.toml set filetype=toml
  autocmd BufNewFile,BufRead *.scala set filetype=scala
augroup END
" }}}

" Color {{{
colorscheme desert
syntax on
set t_Co=256
filetype plugin indent on
" }}}

