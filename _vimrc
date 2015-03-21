" インデントをスペースだけにする "

set autoindent
set expandtab
set shiftwidth=2
set smarttab

" バックスペースでなんでも消せるようにする
set backspace=indent,eol,start

"行番号を表示する
set number

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
nnoremap sn gt
nnoremap sp gT
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

" ノーマルモード時だけ ; と : を入れ替える
nnoremap ; :

" Yを行末までのヤンクにする
nnoremap Y y$

" カッコを対応させる
set showmatch
set matchtime=1

" Uでgundo開く
nmap U :<C-u>GundoToggle<CR>

" ~/.pyenv/shimsを$PATHに追加
let $PATH = "~/.pyenv/shims:".$PATH

"---------------------------
" Start Neobundle Settings.
"---------------------------
" bundleで管理するディレクトリを指定
set runtimepath+=~/.vim/bundle/neobundle.vim/
 
" Required:
call neobundle#begin(expand('~/.vim/bundle/'))
 
" neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'

" neocomplete (自動補完)
NeoBundle 'Shougo/neocomplete.vim'
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#max_list = 10

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
 
" autoclose (自動閉じ括弧挿入)
NeoBundle 'Townk/vim-autoclose'
 
" quickrun (コード実行)
NeoBundle 'thinca/vim-quickrun'
" QuickRunしたら下に分割して結果を表示
let g:quickrun_config = {
      \   "_" : {
      \       "outputter/buffer/split" : ":botright",
      \       "outputter/buffer/close_on_empty" : 1
      \   },
      \} 
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

NeoBundle 'mattn/webapi-vim'
NeoBundle 'moznion/hateblo.vim'
let g:hateblo_vim = {
    \ 'user':         'jajkeqos',
    \ 'api_key':      'p2qlp1j4xy',
    \ 'api_endpoint': 'https://blog.hatena.ne.jp/jajkeqos/jajkeqos.hatenablog.com/atom',
    \ 'WYSIWYG_mode': 0,
    \ 'always_yes':   0,
    \ 'edit_command': 'edit'
    \ }

" <ESC>押下後のIM切替開始までの反応が遅い場合はttimeoutlenを短く設定
set timeout timeoutlen=1000 ttimeoutlen=100


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

" Gundo.vimアンドゥーツリーを作成
NeoBundle "sjl/gundo.vim"
"let g:gundo_auto_preview = 0

" コメントをトグルする(\c)でできる
NeoBundle "tyru/caw.vim.git"
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

" Molokaiカラースキーム
NeoBundle 'tomasr/molokai'
" Hybiridカラースキーム
NeoBundle 'w0ng/vim-hybrid'


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
