imap jj <Esc>

" コマンド検索, 検索履歴を無効にする
nnoremap q: <Nop>
nnoremap q/ <Nop>
nnoremap q? <Nop>

" 行移動を便利にする
nnoremap j gj
nnoremap k gk

" US用に; を : にする
nnoremap ; :

" Yの挙動を正しくする
nnoremap Y y$

" コマンドライン上でC-aで先頭に飛べるようにする
cnoremap <C-A> <Home>

" 画面分割関係
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
nnoremap sO <C-w>=
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
