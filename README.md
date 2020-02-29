# Peterinos vimrc

Because I keep having to install the damn thing because i literally can't stick to the same system for more than a few weeks

# installation: 

manually:
1. install vim
2. add `source <path to this repo>/base.vim ` to your vimrc
3. install vundle (google how to do that) 
4. open vim and run PluginInstall 
5. `sudo apt install fzf ripgrep ctags`
6. `export FZF_DEFAULT_COMMAND=rg --files --no-ignore-vcs --hidden`

automagically:
1. python install.py 

## Install fonts
* `:set guifont *` 
    * opens a selector wheel for fonts
    * The font selected will be temporary to save it add `:set guifont=<>` to your vimrc 
    * you can get the current guifont by calling `:set guifont`

# What do i get? 

the stuff i like to use on vim. and all of it works even over the internet.

## key features i use a lot: 

* ctrl + x to close current buffer
* default yank buffer to "+ (aka the system clipboard, so y and p directly copy and paste)
* ctrl + p to fuzzy search the current folder for files (lightning fast even on windows via ripgrep and fzf) 
    * This is upgraded to a search inside the git repo if you are anywhere inside a git repo
* F2/F3 to switch forward and backwards across tabs
* ctrl + t to open current file in new tabs
* ctrl + n for nerdtree file browse
    * ctrl + m to open nerdtree with current tree
* F11 to open containing folder for current file
* ctrl + hjkl to snap between buffers (vs ctrl+w, ctrl+hjkl)
* ctrl + s to save all open buffers (in current tab) 
* ctrl + e to set foldmethod to NONE
    * For massive files > 3k lines this massively improves performance for autocompleting
* :Rg to search entire repo/working folder for strings extremely quickly (eg global search)

* I wish i had a way to do search and replace sanely and interactively 

## Other commands 
* for even bigger files you may want to disable autocompleting alltogether 
    * `:AcpDisable`

### gvim features
* `:bro sav` opens file that functions as a 'save as ..'
* `:bro open` opens file that functions as a 'open ..'


