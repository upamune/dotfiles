""""""""""""""""""""""""""""""""""""""""""""""""""
"     __   _(_)_ __ ___  _ __ ___  | |__  _   _  "
"     \ \ / / | '_ ` _ \| '__/ __| | '_ \| | | | "
"  _   \ V /| | | | | | | | | (__  | |_) | |_| | "
" (_)   \_/ |_|_| |_| |_|_|  \___| |_.__/ \__, | "
"                                         |___/  "
"    _        _ _                                "
"   (_) __ _ (_) | _____  __ _  ___  ___         "
"   | |/ _` || | |/ / _ \/ _` |/ _ \/ __|        "
"   | | (_| || |   <  __/ (_| | (_) \__ \        "
"  _/ |\__,_|/ |_|\_\___|\__, |\___/|___/        "
" |__/     |__/             |_|                  "
""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""
" ____            _      "
"| __ )  __ _ ___(_) ___ "
"|  _ \ / _` / __| |/ __|"
"| |_) | (_| \__ \ | (__ "
"|____/ \__,_|___/_|\___|"
"                        "
""""""""""""""""""""""""""

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


""""""""""""""""""""""""""""""""""""""
" _  __          ____  _           _ "
"| |/ /___ _   _| __ )(_)_ __   __| |"
"| ' // _ \ | | |  _ \| | '_ \ / _` |"
"| . \  __/ |_| | |_) | | | | | (_| |"
"|_|\_\___|\__, |____/|_|_| |_|\__,_|"
"          |___/                     "
""""""""""""""""""""""""""""""""""""""
" jj or kkでESCする
imap jj <Esc>
imap kk <Esc>

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

" ノーマルモード時だけ ; と : を入れ替える (US用)
nnoremap ; :

" Yを行末までのヤンクにする
nnoremap Y y$

" カッコを対応させる
set showmatch
set matchtime=1


""""""""""""""""""""""""""""""""""""""""""""""""""""
" _   _            ____                  _ _       "
"| \ | | ___  ___ | __ ) _   _ _ __   __| | | ___  "
"|  \| |/ _ \/ _ \|  _ \| | | | '_ \ / _` | |/ _ \ "
"| |\  |  __/ (_) | |_) | |_| | | | | (_| | |  __/ "
"|_| \_|\___|\___/|____/ \__,_|_| |_|\__,_|_|\___| "
""""""""""""""""""""""""""""""""""""""""""""""""""""
" bundleで管理するディレクトリを指定
set runtimepath+=~/.vim/bundle/neobundle.vim/
 
" Required:
call neobundle#begin(expand('~/.vim/bundle/'))
 
" neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'

" neocomplete (自動補完)
NeoBundle 'Shougo/neocomplete.vim'
let g:neocomplete#max_list = 10
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
  endif
  let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'


" ヘルプ日本語化
NeoBundle 'vim-jp/vimdoc-ja'
set helplang=ja,en

" Unite.vim
NeoBundle 'Shougo/unite.vim'
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200

" VimFiler (ファイルビューアー)
NeoBundle 'Shougo/vimfiler'

" indentLine (かしこいインデント)
NeoBundle 'Yggdroot/indentLine'
 
" quickrun (コード実行)
NeoBundle 'thinca/vim-quickrun'
" QuickRunしたら右に分割して結果を表示
let g:quickrun_config = {
      \   "cpp/g++" : {
      \       "cmdopt" : "-std=c++0x",
      \       "hook/time/enable" : 1
      \   },
      \   "_" : {
      \       "outputter/buffer/close_on_empty" : 1,
      \       "runner" : "vimproc",
      \       "runner/vimproc/updatetime" : 60
      \   },
      \}
set splitright

" C-cでQuickRunを終了させる "
nnoremap <expr><silent> <C-c> quickrun#is_running() ?  quickrun#sweep_sessions() : "\<C-c>"

" vim-scouter
function! Scouter(file, ...)
  let pat = '^\s*$\|^\s*"'
  let lines = readfile(a:file)
  if !a:0 || !a:1
    let lines = split(substitute(join(lines, "\n"), '\n\s*\\', '', 'g'), "\n")
  endif
  return len(filter(lines,'v:val !~ pat'))
endfunction
command! -bar -bang -nargs=? -complete=file Scouter
\        echo Scouter(empty(<q-args>) ? $MYVIMRC : expand(<q-args>), <bang>0)


" grep.vim (つよいgrep)
NeoBundle 'grep.vim'
 
" Markdown Preview
NeoBundle 'kannokanno/previm'

" OpenBrowser
NeoBundle 'tyru/open-browser.vim'


" syntastic(シンタックスチェック)
NeoBundle 'scrooloose/syntastic'
let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_javascript_checker = 'jshint'
let g:syntastic_mode_map = {
      \ "mode" : "active",
      \ "active_filetypes" : ["javascript", "json","vim"],
      \ "passive_filetypes" : ["python"]
      \}
if executable("clang++")
  let g:syntastic_cpp_compiler = 'g++'
  let g:syntastic_cpp_compiler_options = '--std=c++11'
  let g:quickrun_config = {}
  let g:quickrun_config['cpp/clang++11'] = {
      \ 'cmdopt': '--std=c++11 --stdlib=libc++',
      \ 'type': 'cpp/clang++'
    \ }
  let g:quickrun_config['cpp'] = {'type': 'cpp/clang++11'}
endif
let g:syntastic_check_on_open = 0 "ファイルオープン時にはチェックをしない
let g:syntastic_check_on_save = 1 "ファイル保存時にはチェックを実施


" Gips.vim (Gips.vim (矢印キーを使うとお叱りを受ける) 
NeoBundle 'modsound/gips-vim.git'

" VimShell (Vimでシェルを使う)
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'Shougo/vimproc.vim', {
      \ 'build' : {
      \     'windows' : 'tools\\update-dll-mingw',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'linux' : 'make',
      \     'unix' : 'gmake',
      \    },
      \ }
" neosnippet
NeoBundle 'Shougo/neosnippet'
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1
" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/dotfiles/vim-snippet'

" lightline.vim (ステータスラインをかっこよく)
NeoBundle 'itchyny/lightline.vim'
set laststatus=2
" syntasticがエラーの時赤色にする(:call lightline#update)
      let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'MyModified',
        \   'readonly': 'MyReadonly',
        \   'fugitive': 'MyFugitive',
        \   'filename': 'MyFilename',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
        \   'fileencoding': 'MyFileencoding',
        \   'mode': 'MyMode'
        \ }
        \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
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

" vim-fugitive (git)
NeoBundle 'tpope/vim-fugitive'

" gitを扱う
NeoBundle 'gregsexton/gitv'

" s-<<<<とかを使えるように
NeoBundle 'kana/vim-submode'
"####### For Ruby #######
" コード補完
NeoBundle 'marcus/rsense'
let g:rsenseHome = '/usr/local/bin/rsense'
let g:rsenseUseOmniFunc = 1
NeoBundle 'supermomonga/neocomplete-rsense.vim'
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_smart_case = 1

if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'

" 静的解析
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']

" ドキュメント参照
NeoBundle 'thinca/vim-ref'
NeoBundle 'yuku-t/vim-ref-ri'

" メソッド定義元へのジャンプ
NeoBundle 'szw/vim-tags'
"####### For Ruby #######

" Gundo.vimアンドゥーツリーを作成
NeoBundle "sjl/gundo.vim"
"let g:gundo_auto_preview = 0
" Uでgundo開く
nmap U :<C-u>GundoToggle<CR>

" コメントをトグルする(\c)でできる
NeoBundle "tyru/caw.vim.git"
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

NeoBundle 'moznion/hateblo.vim', {
          \ 'depends': ['mattn/webapi-vim', 'Shougo/unite.vim']
  \ }
let g:hateblo_vim = {
    \ 'user':         $HATENA_USER_NAME,
    \ 'api_key':      $HATENA_API_KEY,
    \ 'api_endpoint': $HATENA_API_ENDPOINT,
    \ 'WYSIWYG_mode': 0,
    \ 'always_yes':   0,
    \ 'edit_command': 'edit'
    \ }

" Molokaiカラースキーム
NeoBundle 'tomasr/molokai'
" Hybiridカラースキーム
NeoBundle 'w0ng/vim-hybrid'

"Ruby用設定
"コード補完
NeoBundle 'marcus/rsense'
NeoBundle 'supermomonga/neocomplete-rsense.vim'
let g:rsenseHome = '/usr/local/bin/rsense'
let g:rsenseUseOmniFunc = 1
"静的解析
NeoBundle 'scrooloose/syntastic'
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby'] }
"let g:syntastic_ruby_checkers = ['rubocop'] }
"ドキュメント
NeoBundle 'thinca/vim-ref'
NeoBundle 'yuku-t/vim-ref-ri'
"メソッド定義元へジャンプ
NeoBundle 'szw/vim-tags'
" 自動で閉じる
NeoBundle 'tpope/vim-endwise'


call neobundle#end()
 
" Required:
filetype plugin indent on
 
" 未インストールのプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定
NeoBundleCheck
 
"-------------------------
" End Neobundle Settings.
"-------------------------
colorscheme hybrid

syntax on
call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')



