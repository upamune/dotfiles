" インデントをスペースだけにする "
set tabstop=2
set autoindent
set expandtab
set shiftwidth=2
 
" Ctrl-jでESCでできるようにする
imap <c-j> <esc>


"---------------------------
" Start Neobundle Settings.
"---------------------------
" bundleで管理するディレクトリを指定
set runtimepath+=~/.vim/bundle/neobundle.vim/
 
" Required:
call neobundle#begin(expand('~/.vim/bundle/'))
 
" neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'

" neocomplete ( 自動補完)
NeoBundle 'Shougo/neocomplete.vim'
let g:neocomplete#enable_at_startup = 1
" Unite.vim
NeoBundle 'Shougo/unite.vim'
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200

" NERDTreeを設定 (ファイルビューアー)
NeoBundle 'scrooloose/nerdtree'
 
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

" grep.vim (つよいgrep)
NeoBundle 'grep.vim'
 
" syntastic(シンタックスチェック)
NeoBundle 'scrooloose/syntastic'

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

" lightline.vim (ステータスラインをかっこよく)
NeoBundle 'itchyny/lightline.vim'
set laststatus=2
" syntasticがエラーの時赤色にする(:call lightline#update)
let g:lightline = {
      \ 'active': {
      \   'right': [ [ 'syntastic', 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ }
      \ }
let g:syntastic_mode_map = { 'mode': 'passive' }
augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

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


