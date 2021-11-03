set nocompatible              " be iMproved, required
filetype off                  " required

set hidden
set nobackup
set nowritebackup

set termguicolors
set updatetime=300
set shortmess+=c

" set the runtime path to include Vundle and initialize
set rtp+=~/p_testplugins/
set rtp+=~/my_vimrc/plugins/
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
Plugin 'jlanzarotta/bufexplorer'
Plugin 'numirias/semshi'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/fzf'

Plugin 'vimwiki/vimwiki.git'
Plugin 'inkarkat/vim-SyntaxRange'
Plugin 'aaronbieber/vim-quicktask'
Plugin 'tpope/vim-repeat'
Plugin 'neovim/nvim-lspconfig'
Plugin 'vim-scripts/utl.vim'
Plugin 'mhinz/vim-startify'

Plugin 'nvim-telescope/telescope.nvim'
Plugin 'norcalli/nvim-colorizer.lua'
Plugin 'folke/which-key.nvim'
" If you want to have icons in your status-line choose one of these
Plugin 'kyazdani42/nvim-web-devicons'

Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" meson build system support
Plugin 'matze/vim-meson'

" rust specific tools
Plugin 'simrat39/rust-tools.nvim'
Plugin 'rust-lang/rust.vim'

" zig language support
Plugin 'ziglang/zig.vim'
" All of your Plugins must be added before the following lin
call vundle#end()            " required

lua << EOF
  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF

filetype plugin indent on

" Enable SnipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

set timeoutlen=300
let mapleader=" "

set number
set relativenumber
syntax on
set mouse=a
set noswapfile
set noundofile
set nobackup
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
set guitablabel=%t

set guioptions-=m
set guioptions-=T
set guioptions-=L

set shiftwidth=4
set tabstop=4
set expandtab

nmap <F8> :TagbarToggle<CR>
nmap <F5> :vim NOTES:: % <CR> :copen <CR>

if has('win32')
    let g:my_shell = "cmd"
endif


function!Tzig()
    :call jobstart( g:my_shell . " zig test %:p")
endfunction

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
" may want to do the same in Linux linux

nmap <F12> :call Tzig()<CR>

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

set autochdir

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

au BufRead,BufNewFile *.html.twig set filetype=html
au BufRead,BufNewFile *.peg set filetype=asm
au BufRead,BufNewFile *.rdl set filetype=verilog


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

set belloff=all
packloadall
silent! helptags all

let g:fontsize = 12 " you can override this default in init.vim
function! AdjustFontSize(amount)
  let g:fontsize = g:fontsize+a:amount
  :execute "set guifont=Consolas:h" . g:fontsize
endfunction

function! AdjustFontSize_Interactive()
  let g:fontsize = input('enter new font size: ')
  :execute "set guifont=Consolas:h" . g:fontsize
endfunction

noremap <leader>= :call AdjustFontSize(1)<CR>
noremap <leader>+ :call AdjustFontSize(4)<CR>
noremap <leader>- :call AdjustFontSize(-1)<CR>
noremap <leader>_ :call AdjustFontSize(-4)<CR>
noremap <leader>/ :call AdjustFontSize_Interactive()<CR>

noremap <leader>1r :source $MYVIMRC<CR>
noremap <leader>1i :PluginInstall<CR>
noremap <leader>1l :e ~/my_vimrc/base.vim<CR>
noremap <leader>1L :e $MYVIMRC<CR>

if has('win32')
    noremap <leader>ew :call jobstart(['neovide','--multigrid', expand('%:p') ]) <CR>
endif
noremap <leader>eb :BufExplorer<CR>
" open a terminal 

let g:peter_terminal = 'alacritty'
noremap <leader>e` :call jobstart(['cmd', '@%'])<CR> 

noremap <leader>n :NERDTreeToggle<CR>
noremap <leader>m :NERDTreeFind<CR>

noremap <leader>ff :Rg 
noremap <leader>fs :Rg expand(<cword>)<CR>
noremap <leader>ft :tabnew<CR> :Rg 
noremap <leader>fw :call jobstart(['neovide'. '--multigrid', expand('%:p'), '+:Rg' ]) <CR> 

map <leader>ep :set fdm=syntax<CR> :AcpEnable<CR>
map <leader>ee :set fdm=manual<CR> :AcpEnable<CR>
map <leader>eE :set fdm=manual<CR> :AcpDisable<CR>

if has('win32')
    nnoremap <leader>et :tabnew C:/notes/todo.md <CR>
endif

let g:UltiSnipsJumpForwardTrigger="<c-r>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

let neovide_remember_window_size = v:true
let g:neovide_fullscreen=v:false
let g:neovide_refresh_rate=144
let g:neovide_cursor_animation_length=0.02


" trigger `autoread` when files changes on disk
set autoread
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" notification after file change
autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

lua require('colorizer').setup()

setlocal spell spelllang=en_us
autocmd BufEnter * lcd %:p:h
