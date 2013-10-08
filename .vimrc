" vim:fdm=marker:ts=4:sw=4:et:
"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|
"
"
" ---------  Josué  ---------
"

" {{{ Vundle
call pathogen#infect()

set nocompatible    " be iMproved
filetype off        " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()


" original repos on github
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'majutsushi/tagbar'
Bundle 'vim-scripts/TaskList.vim'
Bundle 'bronson/vim-trailing-whitespace'
Bundle 'airblade/vim-gitgutter'
Bundle 'mbbill/undotree'
Bundle 'fsouza/go.vim'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'honza/vim-snippets'
Bundle 'garbas/vim-snipmate'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'gregsexton/MatchTag'
Bundle 'Shougo/unite.vim'
Bundle 'ap/vim-css-color'
Bundle 'Valloric/YouCompleteMe'
Bundle 'moll/vim-bbye'
Bundle 'matze/vim-move'
Bundle 'kien/ctrlp.vim'
Bundle 'bling/vim-airline'

" vim-scripts repos
Bundle 'tir_black'
Bundle 'jade.vim'
Bundle 'dwm.vim'
Bundle 'rubycomplete.vim'

" non github repos


filetype plugin indent on     " required!

" }}}


" {{{ Basics
syntax on
set ai
set nowrap
set ts=4
set sw=4 et
set et
set ruler
set smartindent
set expandtab
set incsearch
set ignorecase
set encoding=utf-8
set fileencoding=utf-8
set backupdir=/tmp
set noswapfile

" automatically reload vimrc when it's saved
au BufWritePost .vimrc so ~/.vimrc

" Spell
set spell spelllang=pt " show options 'z='
set nospell

" }}}


" {{{ Appearance
set background=dark
set laststatus=2

if has("gui_running")
    colorscheme tir_black
    set nu
    set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 10
    let g:airline_powerline_fonts = 1
    set cursorline!
    set guioptions-=m  "remove menu bar
    set guioptions-=T  "remove toolbar
    set guioptions-=L  "remove left-hand scroll bar
    set guioptions-=r  "remove right-hand scroll bar
else
    if $TERM != "linux"  " if we are not in TTY
        set t_Co=256
    endif

    hi IndentGuidesOdd  ctermbg=black
    hi IndentGuidesEven ctermbg=darkgrey
endif

highlight clear SignColumn

"improve autocomplete menu color
highlight Pmenu ctermbg=238 gui=bold

"switch to fat and thin cursor on Konsole
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" }}}


" {{{ Languages and functions

" Verilog
autocmd FileType verilog set tabstop=2
autocmd FileType verilog map <F5> :w<CR> :!clear<CR> :!iverilog "%:p" -o "%:p:r.vvp"<CR>
autocmd FileType verilog map <F6> :!vvp "%:p:r.vvp"<CR>
autocmd FileType verilog map <F7> :!gtkwave "%:p:r.vcd"<CR>

" Haskell
autocmd FileType haskell map <F5> :w<CR> :!clear<CR> :!ghc "%:p:r.hs"<CR>
autocmd FileType haskell map <F6> :!"%:p:r"<CR>

" Python
autocmd FileType python map <F6> :w<CR> :!clear<CR> :!python2 "%"<CR>

" Ruby
autocmd FileType ruby map <F6> :w<CR> :!clear<CR> :ruby "%"<CR>
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

" Java
autocmd FileType java map <F5> :w<CR> :!clear<CR> :!javac "%:p:r.java"<CR>
autocmd FileType java map <F6> :!java "%:p:r"<CR>

" C/C++
autocmd FileType c map <F5> :w<CR> :!clear<CR> :!gcc -o "%:p:r" "%:p"<CR>
autocmd FileType c map <F6> :!"%:p:r"<CR>
autocmd FileType cpp map <F5> :w<CR> :!clear<CR> :!g++ -o "%:p:r" "%:p"<CR>
autocmd FileType cpp map <F6> :!"%:p:r"<CR>

" CSS
autocmd FileType css set textwidth=79
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS

" HTML
autocmd FileType html set textwidth=0
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags

" JavaScript
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType javascript set textwidth=79
autocmd FileType javascript map <F5> :node ":p"<CR>

" }}}


" {{{ Plugins definitions

" ctrlp.vim
set runtimepath^=~/.vim/bundle/ctrlp.vim

" auto close buffer omnicomplete
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" YCM
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'

" airline
let g:airline#extensions#tabline#enabled = 1

" }}}


" {{{ Keys definitions

" Unbind the cursor keys in insert, normal and visual modes.
if has("gui_running")
else
    for prefix in ['i', 'n', 'v']
        for key in ['<Up>', '<Down>', '<Left>', '<Right>']
            exe prefix . "noremap " . key . " <Nop>"
        endfor
    endfor
endif

" Disable F1 key
map <F1> <Esc>
imap <F1> <Esc>

" Shortcuts
nnoremap <leader>us :set hls!<cr> " unhighlight selection
nnoremap <leader>ss :set hls<cr>  " highlight on

" Tamanho da tabulação
nnoremap <leader>2 <esc>:set expandtab tabstop=2 softtabstop=2 shiftwidth=2<cr>
nnoremap <leader>4 <esc>:set expandtab tabstop=4 softtabstop=4 shiftwidth=4<cr>
nnoremap <leader>8 <esc>:set expandtab tabstop=8 softtabstop=8 shiftwidth=8<cr>

" Toggle nerdtree
nnoremap <leader>n :NERDTreeToggle<cr>

" Tagbar
nnoremap <leader>tb :TagbarToggle<cr>

" UndotreeToggle
nnoremap <leader>ut :UndotreeToggle<cr>

" vim-multiple-cursors
let g:multi_cursor_next_key='<C-m>'

" minibufrexpl
map <Leader>bd :MBEbd<cr>
map <Leader>nn :MBEbn<cr>
map <Leader>bb :MBEbb<cr>

" Unite
nnoremap f :Unite file

" SnipMate working with YCM
imap <C-J> <Plug>snipMateNextOrTrigger
smap <C-J> <Plug>snipMateNextOrTrigge

" Bbye (Buffer Bye) for Vim
nnoremap <Leader>q :Bdelete<CR>

" Easier increment/decrement
nnoremap + <C-a>
nnoremap - <C-x>

" }}}
