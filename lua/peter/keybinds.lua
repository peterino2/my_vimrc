local opts = {noremap = true, silent = true}

local term_opts = {silent = true}

local keymap = vim.api.nvim_set_keymap

function nmap(shortcut, command)
    keymap('n', shortcut, command, opts)
end

function leader(shortcut, command)
    keymap('n', "<leader>"..shortcut, command, opts)
end

vim.cmd[[
    set timeoutlen=300
]]

-- leader setup
keymap("", "Space", "<Nop>", opts)
keymap("", "M", "<Nop>", opts)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("n", "<leader>", ":<c-u>WhichKey '<Space>'<CR>", opts)

-- keymaps
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-x>", ":q<CR>", opts)
keymap("n", "<C-s>", ":wa<CR>", opts)

keymap("n", "<F2>", ":tabp<CR>", opts)
keymap("n", "<F3>", ":tabn<CR>", opts)

keymap("n", "<C-t>", "tabnew %<CR>", opts)


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

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

--- Leader Keys ---
leader("1r", ":source  $MYVIMRC<CR>")
leader("1i", ":PackerInstall<CR>")
leader("1l", ":e ~/my_vimrc/base.lua<CR>")
leader("1L", ":e $MYVIMRC<CR>")

leader("ss", ":split<CR>")
leader("sv", ":vs w<CR>")

leader("wt", ":tabnew %<CR>")
leader("wl", ":tabn<CR>")
leader("wh", ":tabp<CR>")

leader("n", ":NERDTreeToggle<CR>")
leader("m", ":NERDTreeFind<CR>")

-- map('n','gD','<cmd>lua vim.lsp.buf.declaration()<CR>')
-- map('n','gd','<cmd>lua vim.lsp.buf.definition()<CR>')
-- map('n','K','<cmd>lua vim.lsp.buf.hover()<CR>')
-- map('n','gr','<cmd>lua vim.lsp.buf.references()<CR>')
-- map('n','gs','<cmd>lua vim.lsp.buf.signature_help()<CR>')
-- map('n','gi','<cmd>lua vim.lsp.buf.implementation()<CR>')
-- map('n','gt','<cmd>lua vim.lsp.buf.type_definition()<CR>')
-- map('n','<leader>gw','<cmd>lua vim.lsp.buf.document_symbol()<CR>')
-- map('n','<leader>gW','<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
-- map('n','<leader>ah','<cmd>lua vim.lsp.buf.hover()<CR>')
-- map('n','<leader>af','<cmd>lua vim.lsp.buf.code_action()<CR>')
-- map('n','<leader>ee','<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')
-- map('n','<leader>ar','<cmd>lua vim.lsp.buf.rename()<CR>')
-- map('n','<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>')
-- map('n','<leader>ai','<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
-- map('n','<leader>ao','<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')
