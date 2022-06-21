local opts = {noremap = true, silent = true}

local term_opts = {silent = true}

local keymap = vim.api.nvim_set_keymap

function nmap(shortcut, command)
    keymap('n', shortcut, command, opts)
end

function leader(shortcut, command)
    keymap('n', "<leader>"..shortcut, command, opts)
end

-- leader setup
keymap("", "Space", "<Nop>", opts)

vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- keymaps
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-x>", ":q<CR>", opts)
keymap("n", "<C-s>", ":wa<CR>", opts)

keymap("n", "<F2>", ":tabn<CR>", opts)
keymap("n", "<F3>", ":tabp<CR>", opts)

keymap("n", "<C-T>", "tabnew %<CR>", opts)


keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)

keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

keymap("v", ">", ">gv", opts)
keymap("v", "<", "<gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

--- Leader Keys ---
leader("1r", ":source  $MYVIMRC<CR>")
leader("1i", ":PlugInstall<CR>")
leader("1l", ":e ~/my_vimrc/base.lua<CR>")
leader("1L", ":e $MYVIMRC<CR>")

leader("ss", ":split<CR>")
leader("sv", ":vs w<CR>")

leader("wt", ":tabnew %<CR>")
leader("wl", ":tabn<CR>")
leader("wh", ":tabp<CR>")