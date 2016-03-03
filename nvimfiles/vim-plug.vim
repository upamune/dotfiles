if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
  Plug 'junegunn/vim-plug',
        \ {'dir': '~/.config/nvim/plugged/vim-plug/autoload'}

  runtime! nvimfiles/extras/*.vim

call plug#end()

colorscheme seoul256

