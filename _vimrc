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

" カッコを対応させる
set showmatch
set matchtime=1


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

" 選択時の<C-a>, <C-x>をべんりにする
vnoremap <C-a> <C-a>gv
vnoremap <C-x> <C-x>gv

""""""""""""""""""""""""""""""""""""""""""""""""""""
" _   _            ____                  _ _       "
"| \ | | ___  ___ | __ ) _   _ _ __   __| | | ___  "
"|  \| |/ _ \/ _ \|  _ \| | | | '_ \ / _` | |/ _ \ "
"| |\  |  __/ (_) | |_) | |_| | | | | (_| | |  __/ "
"|_| \_|\___|\___/|____/ \__,_|_| |_|\__,_|_|\___| "
""""""""""""""""""""""""""""""""""""""""""""""""""""
set runtimepath+=~/.vim/bundle/neobundle.vim/
" Required:
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

""""""""""""""""""""""""""""""""
"  ___                       _ "
" / __|___ _ _  ___ _ _ __ _| |"
"| (_ / -_) ' \/ -_) '_/ _` | |"
" \___\___|_||_\___|_| \__,_|_|"
""""""""""""""""""""""""""""""""

" neocomplete (自動補完)
NeoBundle 'Shougo/neocomplete.vim'
let g:neocomplete#max_list = 10
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1

" ヘルプ日本語化
NeoBundle 'vim-jp/vimdoc-ja'
set helplang=ja,en

" Unite.vim
NeoBundle 'Shougo/unite.vim'
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200

NeoBundle 'Shougo/unite-outline'

" VimFiler (ファイルビューアー)
NeoBundle 'Shougo/vimfiler'

" いい感じにタグジャンプできるようになる
NeoBundle 'majutsushi/tagbar'

" 行の余計なスペースを可視化する
NeoBundle 'bronson/vim-trailing-whitespace'
if neobundle#tap('vim-trailing-whitespace')
    " uniteでスペースが表示されるので、設定でOFFにします。
    let g:extra_whitespace_ignored_filetypes = ['unite']
endif

" マッチしたものすべてをインクリメンタルにハイライトする
NeoBundle 'haya14busa/incsearch.vim',{ 'depends' : 'osyo-manga/vim-anzu' }
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

" indentLine ( インデントを表示する)
NeoBundle 'Yggdroot/indentLine'

" quickrun (コード実行)
NeoBundle 'thinca/vim-quickrun'

" QuickRunしたら右に分割して結果を表示
let g:quickrun_config = {   "cpp/g++" : {       "cmdopt" : "-std=c++0x",       "hook/time/enable" : 1   },   "_" : {       "outputter/buffer/close_on_empty" : 1,       "runner" : "vimproc",       "runner/vimproc/updatetime" : 60,       "outputter/buffer/split" : ":botright 8sp",   },}
set splitright

" syntastic(シンタックスチェック)
NeoBundle 'scrooloose/syntastic'
let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_mode_map = { "mode" : "active"}
"ファイルオープン時にはチェックをしない
let g:syntastic_check_on_open = 0
"ファイル保存時にはチェックを実施
let g:syntastic_check_on_save = 1

" Color Schemes
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'google/vim-colorscheme-primary'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'upamune/tomorrow-theme'

" VimShell (Vimでシェルを使う)
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'Shougo/vimproc.vim', { 'build' : {     'windows' : 'tools\\update-dll-mingw',     'cygwin' : 'make -f make_cygwin.mak',     'mac' : 'make -f make_mac.mak',     'linux' : 'make',     'unix' : 'gmake',    }, }

" neosnippet
NeoBundle 'Shougo/neosnippet'
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/dotfiles/vim-snippet'

" コメントをトグルする(\c)でできる
NeoBundle "tyru/caw.vim.git"
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

" Gundo
NeoBundle "sjl/gundo.vim"
" 移動と同時にプレビューしない
let g:gundo_auto_preview = 0
" Uでgundo開く
nmap U :<C-u>GundoToggle<CR>

" 移動系プラグイン {{{
"   " ぬるぬるスクロール
NeoBundleLazy 'yonchu/accelerated-smooth-scroll'
NeoBundleLazy 'rhysd/clever-f.vim'
" }}}

" s-<<<<とかを使えるように
NeoBundle 'kana/vim-submode'

" ag コマンドをVimで使えるようにする
NeoBundle 'rking/ag.vim'

" lightline.vim (ステータスラインをかっこよく)
NeoBundle 'itchyny/lightline.vim'
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
NeoBundle 'lambdalisue/vim-gista'
let g:gista#github_user = 'upamune'


" Vim motions on speed! http://haya14busa.com/mastering-vim-easymotion/
NeoBundle 'Lokaltog/vim-easymotion'
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


""""""""""""""""""""""
" ___      _         "
"| _ \_  _| |__ _  _ "
"|   / || | '_ \ || |"
"|_|_\\_,_|_.__/\_, |"
"               |__/ "
""""""""""""""""""""""
" Rsense Ruby用補完
NeoBundle 'marcus/rsense'
NeoBundle 'supermomonga/neocomplete-rsense.vim'
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

" ドキュメント参照
NeoBundle 'thinca/vim-ref'
NeoBundle 'yuku-t/vim-ref-ri'

" Endを自動で挿入する
NeoBundle 'tpope/vim-endwise'

""""""""""""
"  ___     "
" / __|___ "
"| (_ / _ \"
" \___\___/"
"          "
""""""""""""
NeoBundle 'dgryski/vim-godef'
NeoBundle 'vim-jp/vim-go-extra'
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['go'] }
let g:syntastic_go_checkers = ['go', 'golint']
set path+=$GOPATH/src/**
let g:gofmt_command = 'goimports'
au BufWritePre *.go Fmt
au BufNewFile,BufRead *.go set sw=4 noexpandtab ts=4 completeopt=menu,preview
au FileType go compiler go

let g:tagbar_type_go = { 'ctagstype' : 'go', 'kinds'     : [ 'p:package', 'i:imports:1', 'c:constants', 'v:variables', 't:types', 'n:interfaces', 'w:fields', 'e:embedded', 'm:methods', 'r:constructor', 'f:functions' ], 'sro' : '.', 'kind2scope' : { 't' : 'ctype', 'n' : 'ntype' }, 'scope2kind' : { 'ctype' : 't', 'ntype' : 'n' }, 'ctagsbin'  : 'gotags', 'ctagsargs' : '-sort -silent' }


"""""""""""""""""""
"  ___  _     _   "
" / __|| |_ _| |_ "
"| (_|_   _|_   _|"
" \___||_|   |_|  "
"                 "
"""""""""""""""""""

if executable("clang++")
  let g:syntastic_cpp_compiler = 'g++'
  let g:syntastic_cpp_compiler_options = '--std=c++11'
  let g:quickrun_config['cpp/clang++11'] = { 'cmdopt': '--std=c++11 --stdlib=libc++', 'type': 'cpp/clang++' }
  let g:quickrun_config['cpp'] = {'type': 'cpp/clang++11'}
endif

NeoBundle 'rhysd/vim-clang-format',{ 'depends' : 'kana/vim-operator-user' }
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11"}
" 保存時に自動でフォーマットする
" let g:clang_format#auto_format = 1

""""""""""""""
"  ___ _ _   "
" / __(_) |_ "
"| (_ | |  _|"
" \___|_|\__|"
"            "
""""""""""""""
" gitを扱う
NeoBundle 'gregsexton/gitv'
NeoBundle 'tpope/vim-fugitive'


""""""""""""""""""""""""""""
"_   _ _____ __  __ _      "
"| | | |_   _|  \/  | |    "
"| |_| | | | | |\/| | |    "
"|  _  | | | | |  | | |___ "
"|_| |_| |_| |_|  |_|_____|"
""""""""""""""""""""""""""""
NeoBundle 'amirh/HTML-AutoCloseTag'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'gorodinskiy/vim-coloresque'
NeoBundle 'tpope/vim-haml'
NeoBundle 'mattn/emmet-vim'


" syntax and filetype plugins {{{
" JavaScript {{{
NeoBundleLazy 'jelera/vim-javascript-syntax'
NeoBundleLazy 'marijnh/tern_for_vim'
" }}}


call neobundle#end()
NeoBundleCheck


call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')

""""""""""""""""""""""""
"  _   _   _   _   _   "
" / \ / \ / \ / \ / \  "
"( c | o | l | o | r ) "
" \_/ \_/ \_/ \_/ \_/  "
"                      "
""""""""""""""""""""""""
colorscheme desert
syntax on
set t_Co=256

filetype plugin indent on

