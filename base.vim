set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin() " alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'scrooloose/nerdtree'
Plugin 'itchyny/lightline.vim'
Plugin 'majutsushi/tagbar'
Plugin 'vim-scripts/AutoComplPop'
Plugin 'airblade/vim-rooter'
Plugin 'wincent/ferret'
Plugin 'skywind3000/asyncrun.vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'matze/vim-meson'
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " requiredset diffexpr=MyDiff()

set number
set relativenumber
syntax on
set mouse=a
set guifont=Lucida\ Console:h12:cANSI
set noswapfile
set noundofile
set nobackup
map <C-n> :NERDTreeToggle<CR>
map <C-m> :NERDTreeFind<CR>
map <C-e> :set fdm=manual<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
set guitablabel=%t

set guioptions-=m
set guioptions-=T
"set guioptions-=r
set guioptions-=L

set shiftwidth=4
set tabstop=4
set expandtab

nmap <F8> :TagbarToggle<CR>
nmap <F5> :vim NOTES:: % <CR> :copen <CR>

function!QuickPutRange()
    call inputsave()
    let p = input("n_lines:")
    call inputrestore()
    execute "put =range(0,".p.")"
endfunction
command Nput call QuickPutRange()

if has('win32')
    " may want to add npp to your path
    nmap <F10> :!start npp.exe %<CR> :echo "NORMIE MODE ENGAGED"<CR>
    nmap <F11> :!start %:p:h<CR>
endif
" may want to do the same in linux

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set guioptions+=k
set clipboard^=unnamed,unnamedplus
set switchbuf=usetab

nnoremap <F3> :tabn<CR>
nnoremap <F2> :tabp<CR>
nnoremap <C-T> :tabnew %<CR>
nnoremap <C-Q> :bro sav<CR>
nnoremap <C-X> :q <CR>
nnoremap <C-S> :wa <CR>

autocmd BufEnter * lcd %:p:h
"let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']
" Enable Dlang support with
" This uses d language patch with exuberant-ctags Uhh I dont think I have this
" working yet.
"
nnoremap <C-p> :Files<Cr>

let g:ag_working_path_mode='r'
let g:rooter_patterns = ['Rakefile', '.git/']
let g:rooter_silent_chdir = 1

" Look into it a bit more and see if it can be done
let g:tagbar_type_d = {
    \ 'ctagstype' : 'd',
    \ 'kinds'     : [
        \ 'c:classes:0:1',
        \ 'f:functions',
        \ 'g:enums',
        \ 'u:unions',
        \ 's:structs',
        \ 'm:members'
    \ ],
    \'sro': '.',
    \ 'kind2scope' : {
        \ 'c' : 'class',
        \ 'g' : 'enum',
        \ 's' : 'struct',
        \ 'u' : 'union'
    \},
    \ 'scope2kind' : {
        \ 'enum'      : 'g',
        \ 'class'     : 'c',
        \ 'struct'    : 's',
        \ 'union'     : 'u'
    \ }
\ }

set laststatus=2
set foldmethod=syntax

au BufRead,BufNewFile *.html.twig set filetype=html
au BufRead,BufNewFile *.peg set filetype=asm
au BufRead,BufNewFile *.rdl set filetype=verilog

imap <F11> <Esc><F11>

set backspace=indent,eol,start
set undofile
set undodir=~/.vim/undo

set cursorline
set complete-=i
set complete=.,t
set hlsearch

autocmd InsertEnter * set cul
autocmd InsertLeave * set cul!

colorscheme hc_burn
