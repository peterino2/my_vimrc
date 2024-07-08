local fn = vim.fn

local install_path = fn.stdpath "data" .. "/site/pack/packer/start/pack.nvim"

if(fn.empty(fn.glob(install_path))) > 0 then
    PACKER_BOOTSTRAP = fn.system{
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }

    print "installing packer close and reopen neovim"
    vim.cmd [[
        packadd packer.nvim
    ]]
end

vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

local status_ok, packer = pcall(require, "packer")

if not status_ok then
    error("packer not loaded")
    return
end

-- new packer window
packer.init {
    display = {
        open_fn = function ()
            return require("packer.util").float {border = "rounded"}
        end
    }
}

return packer.startup(function(use)
    use "wbthomason/packer.nvim"

    use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

    use "L3MON4D3/LuaSnip" --snippet engine
    use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

    use "liuchengxu/vim-which-key"
    use "scrooloose/nerdtree" -- Useful lua functions used ny lots of plugins
    
    use "neovim/nvim-lspconfig"
    use "williamboman/mason.nvim"

    use "junegunn/fzf"
    use "junegunn/fzf.vim"

    -- cmp package
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/nvim-cmp"

    -- languages 
    use "ziglang/zig.vim"
    use "pboettch/vim-cmake-syntax"

    use 'sheerun/vim-polyglot'
    use "nathom/filetype.nvim"

    use 'github/copilot.vim'
    use 'NLKNguyen/papercolor-theme'
    use 'agude/vim-eldar'
    -- use 'sjl/badwolf/'

    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
