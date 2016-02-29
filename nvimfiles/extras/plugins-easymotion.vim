Plug 'easymotion/vim-easymotion'

let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1
let g:EasyMotion_startofline = 0
nmap <Space> <Plug>(easymotion-s2)
xmap <Space> <Plug>(easymotion-s2)
omap <Space> <Plug>(easymotion-s2)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
