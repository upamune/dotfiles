NeoBundle "junegunn/fzf"

command! FZFMru call fzf#run({
\  'source':  v:oldfiles,
\  'sink':    'e',
\  'options': '-m -x +s',
\  'down':    '40%'})

nnoremap <C-f> :FZF<CR>
nnoremap <C-m> :FZFMru<CR>
