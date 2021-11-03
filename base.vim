set nocompatible              " be iMproved, required
filetype off                  " required

set hidden
set nobackup
set nowritebackup

set updatetime=300
set shortmess+=c

" set the runtime path to include Vundle and initialize
set rtp+=~/p_testplugins/
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin() " alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'itchyny/lightline.vim'
Plugin 'majutsushi/tagbar'
Plugin 'vim-scripts/AutoComplPop'
Plugin 'airblade/vim-rooter'
Plugin 'skywind3000/asyncrun.vim'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/fzf'
Plugin 'vimwiki/vimwiki.git'
Plugin 'matze/vim-meson'
Plugin 'rust-lang/rust.vim'
Plugin 'ziglang/zig.vim'
Plugin 'mattn/calendar-vim'
Plugin 'vim-scripts/utl.vim'
Plugin 'chrisbra/NrrwRgn'
Plugin 'inkarkat/vim-SyntaxRange'
Plugin 'aaronbieber/vim-quicktask'
Plugin 'tpope/vim-repeat'
Plugin 'neovim/nvim-lspconfig'
Plugin 'simrat39/rust-tools.nvim'
Plugin 'nvim-lua/popup.nvim'
Plugin 'nvim-lua/plenary.nvim'
Plugin 'nvim-telescope/telescope.nvim'
Plugin 'djoshea/vim-autoread'
Plugin 'mfussenegger/nvim-dap'
Plugin 'norcalli/nvim-colorizer.lua'
Plugin 'folke/which-key.nvim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
" All of your Plugins must be added before the following lin
call vundle#end()            " required

lua << EOF
  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF

filetype plugin indent on    " requiredset diffexpr=MyDiff()

" Enable snipMate compatibility feature.
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
"set guioptions-=r
set guioptions-=L

set shiftwidth=4
set tabstop=4
set expandtab

nmap <F8> :TagbarToggle<CR>
nmap <F5> :vim NOTES:: % <CR> :copen <CR>
if has('win32')
    nnoremap <leader>et :tabnew C:/notes/todo.md <CR>
endif

function!Tzig()
    execute "AsyncRun -mode=term -pos=bottom -rows=15 -cols=40 -focus=0 zig test %:p"
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
" may want to do the same in linux

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
set foldmethod=syntax

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

let s:fontsize = 12
function! AdjustFontSize(amount)
  let s:fontsize = s:fontsize+a:amount
  :execute "set guifont=Consolas:h" . s:fontsize
endfunction


" In normal mode, pressing numpad's+ increases the font
noremap <leader>= :call AdjustFontSize(1)<CR>
noremap <leader>+ :call AdjustFontSize(4)<CR>
noremap <leader>- :call AdjustFontSize(-1)<CR>
noremap <leader>_ :call AdjustFontSize(-4)<CR>

noremap <leader>ew :call jobstart(['neovide', expand('%:p') ]) <CR>
noremap <leader>er :source $MYVIMRC<CR>
noremap <leader>ei :PluginInstall<CR>
noremap <leader>el :e ~/my_vimrc/base.vim<CR>
noremap <leader>dp :w<CR>:sv<CR>:terminal python -m pdb %:p<CR>
map <leader>ee :set fdm=manual<CR> :AcpDisable<CR>

let g:UltiSnipsJumpForwardTrigger="<c-r>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

let neovide_remember_window_size = v:true
let g:neovide_fullscreen=v:true
let g:neovide_refresh_rate=140
let g:neovide_cursor_animation_length=0.07

map <C-n> :NERDTreeToggle<CR>
map <S-n> :NERDTreeFind<CR>


" trigger `autoread` when files changes on disk
set autoread
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" notification after file change
autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

