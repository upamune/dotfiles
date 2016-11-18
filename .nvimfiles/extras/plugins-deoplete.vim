Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

set completeopt+=noinsert
set completeopt+=noselect

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif

let g:deoplete#omni#input_patterns.python = '\h\w*\|[^. \t]\.\w*'
