local opts = {noremap = true, silent = true}

local term_opts = {silent = true}

local keymap = vim.api.nvim_set_keymap
local unmap = vim.api.nvim_del_keymap

function nmap(shortcut, command)
    keymap('n', shortcut, command, opts)
end

function leader(shortcut, command)
    keymap('n', "<leader>"..shortcut, command, opts)
end

vim.cmd[[
    set timeoutlen=150
]]

-- leader setup
keymap("", "Space", "<Nop>", opts)
keymap("", "M", "<Nop>", opts)

keymap("n", "<S-k>", "<Nop>", opts)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("n", "<leader>", ":<c-u>WhichKey '<Space>'<CR>", opts)

-- keymaps
keymap("n", "<C-j>", "<C-w>j", opts) -- change window down
keymap("n", "<C-k>", "<C-w>k", opts) -- change window up
keymap("n", "<C-l>", "<C-w>l", opts) -- change window right
keymap("n", "<C-h>", "<C-w>h", opts) -- change window left
keymap("n", "<C-x>", ":q<CR>", opts) -- close buffer
keymap("n", "<C-w>", ":q<CR>", opts) -- close buffer
keymap("n", "<C-s>", ":wa<CR>", opts) -- save all

keymap("n", "<F2>", ":tabp<CR>", opts) -- previous tab
keymap("n", "<F3>", ":tabn<CR>", opts) -- next tab

keymap("n", "<C-t>", ":tabnew %<CR>", opts) -- open current buffer in new tab.


keymap("n", "<C-Up>", ":resize -4<CR>", opts)  -- make current buffer smaller (in height, by 4 spaces)
keymap("n", "<C-Down>", ":resize +4<CR>", opts) -- make current buffer larger (in height, by 4 spaces)

keymap("n", "<C-Left>", ":vertical resize -8<CR>", opts) -- make current buffer smaller (horizontally, by 8 spaces)
keymap("n", "<C-Right>", ":vertical resize +8<CR>", opts) -- make curretn buffer larger (horizontally, by 8 spaces)

keymap("i", "<C-BS>", "<ESC>caw", opts) -- delete last word

unmap("i", "<C-w>") -- delete last word

keymap("n", "<C-p>", ":GFiles<CR>", opts) -- Fuzzy search with ripgrep and fzf, git only
keymap("n", "<C-P>", ":Files<CR>", opts) -- Fuzzy search with ripgrep and fzf

--- Visual mode mappings
keymap("v", ">", ">gv", opts) -- indent to the right
keymap("v", "<", "<gv", opts) -- indent to the left

keymap("v", "<A-j>", ":m .+1<CR>==", opts) -- move selected line down
keymap("v", "<A-k>", ":m .-2<CR>==", opts) -- move selected line up
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
leader("1l", ":e ~/my_vimrc/base.lua<CR>:cd %:p:h<CR>")
leader("1k", ":e ~/my_vimrc/lua/peter/keybinds.lua<CR>")
leader("1L", ":e $MYVIMRC<CR>:cd %:p:h<CR>")
leader("1n", ":e ~/blogaroni/content/todo.md<CR>:cd %:p:h<CR>")
leader("1e", ":e ~/blogaroni/content/exopunk/todo.md<CR>:cd %:p:h<CR>")

leader("id", ":nput =strftime('%Y-%m-%d')<CR>")
leader("iD", ":nput =strftime('%b %d %Y')<CR>")
leader("Id", ":put =strftime('%Y-%m-%d')<CR>")
leader("ID", ":put =strftime('%b %d %Y')<CR>")

leader("ss", ":split<CR>")
leader("sv", ":vs w<CR>")

leader("wt", ":tabnew %<CR>")
leader("wn", ":tabnew<CR>")
leader("wl", ":tabn<CR>")
leader("wh", ":tabp<CR>")
leader('ws', ":split %<CR>")
leader('wv', ":vsplit %<CR>")

leader('ce', ":pwd<CR>")
leader('cw', ":cd %:p:h<CR>")

keymap('n', "<leader>cd", ":cd", {noremap=true})

--- Buffers stuff ---
leader('bb', ":buffers<CR>")
leader('bj', ":bnext<CR>")
leader('bk', ":bprevious<CR>")
leader('bJ', ":blast<CR>")
leader('bK', ":bfirst<CR>")

keymap('n', "<leader>bd", ":bd", {noremap=true})
keymap('n', "<leader>fr", ":Rg ", {noremap=true})

leader('eW', ":set wrap<CR>")
leader('ew', ":set nowrap<CR>")
leader('es', ":set fdm=syntax<CR>")
leader('ee', ":set fdm=manual<CR>")

leader("n", ":NERDTreeToggle<CR>")
leader("m", ":NERDTreeFind<CR>")
leader('gD','<cmd>lua vim.lsp.buf.declaration()<CR>')
leader('gd','<cmd>lua vim.lsp.buf.definition()<CR>')
leader('gK','<cmd>lua vim.lsp.buf.hover()<CR>')
leader('gr','<cmd>lua vim.lsp.buf.references()<CR>')
leader('gs','<cmd>lua vim.lsp.buf.signature_help()<CR>')
leader('gi','<cmd>lua vim.lsp.buf.implementation()<CR>')
leader('gt','<cmd>lua vim.lsp.buf.type_definition()<CR>')
leader('gw','<cmd>lua vim.lsp.buf.document_symbol()<CR>')
leader('gW','<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
leader('gh','<cmd>lua vim.lsp.buf.hover()<CR>')
leader('gf','<cmd>lua vim.lsp.buf.code_action()<CR>')
leader('ge','<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')
leader('gr','<cmd>lua vim.lsp.buf.rename()<CR>')
leader('g=','<cmd>lua vim.lsp.buf.formatting()<CR>')
leader('gl','<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
leader('go','<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')
