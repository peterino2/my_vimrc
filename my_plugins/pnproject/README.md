
# Projects support for neovim

This is a plugin which defines search directories, commands and custom
bindings for each directory

1. Upon entering a directory, recursively walk up the directory path until a
   .pnprojectfile is found
2. the pnproject file is a neovim file which can configure build steps in lua
3. if no current_pnproject_dir is set, then source the .pnprojectfile   
   4. source the .pnprojectfile 
