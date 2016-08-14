Plug 'osyo-manga/vim-monster', { 'do': 'gem install rcodetools fastri && type rbenv >/dev/null 2>&1 && rbenv rehash', 'for': 'ruby' }
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'ngmy/vim-rubocop', { 'do': 'gem install rubocop && type rbenv >/dev/null 2>&1 && rbenv rehash', 'for': 'ruby' }
Plug 'thinca/vim-ref', { 'for': 'ruby' } | Plug 'yuku-t/vim-ref-ri', { 'for': 'ruby' }
Plug 'tpope/vim-endwise', { 'for': 'ruby' }
let g:monster#completion#rcodetools#backend = "async_rct_complete"
let g:deoplete#sources#omni#input_patterns = {
\   "ruby" : '[^. *\t]\.\w*\|\h\w*::',
\}