local opts = {noremap = true, silent = true}
local term_opts = {silent = true}

-- huh --

local keymap = vim.api.nvim_set_keymap
local unmap = vim.api.nvim_del_keymap

function nmap(shortcut, command)
    keymap('n', shortcut, command, opts)
end

function leader(shortcut, command)
    keymap('n', "<leader>"..shortcut, command, opts)
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
keymap("v", "p", '"_dP', opts)  -- Do not copy to buffer on paste in visual mode
keymap("v", "d", '"_d', opts)  -- Do not copy to buffer on delete in visual mode
keymap("n", "dd", '"_dd', opts)  -- Do not copy to buffer on delete in normal mode

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation lets you move between windows if one of the windows is terminal
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

--- Leader Keys ---

-- Open various files of interest
leader("1r", ":source  $MYVIMRC<CR>")
leader("1i", ":PackerInstall<CR>")
leader("1l", ":e ~/my_vimrc/base.lua<CR>:cd %:p:h<CR>")
leader("1k", ":e ~/my_vimrc/lua/peter/keybinds.lua<CR>")
leader("1K", ":e ~/my_vimrc/lua/peter/keybinds.lua<CR>")
leader("1L", ":e $MYVIMRC<CR>:cd %:p:h<CR>")
leader("1n", ":e ~/blogaroni/content/todo.md<CR>:cd %:p:h<CR>")
leader("1N", ":!nvim<CR>")
leader("1e", ":e ~/blogaroni/content/exopunk/todo.md<CR>:cd %:p:h<CR>")

leader("jk", ":sv<CR>:e ~/journal.txt<CR>")
leader("hk", ":e ~/journal.txt<CR>:cd %:p:h<CR>")
leader("jm", ":sv<CR>:e ~/OneDrive - Microsoft/notes/notes.txt<CR>")
leader("hm", ":e ~/OneDrive - Microsoft/notes/notes.txt<CR>:cd %:p:h<CR>")

leader("id", ":nput =strftime('%Y-%m-%d')<CR>")
leader("iD", ":nput =strftime('%b %d %Y')<CR>")
leader("Id", ":put =strftime('%Y-%m-%d')<CR>")
leader("ID", ":put =strftime('%b %d %Y')<CR>")

leader("vs", ":split<CR>")
leader("vv", ":vs w<CR>")

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

leader('b1', ":buffer 1<CR>")
leader('b2', ":buffer 2<CR>")
leader('b3', ":buffer 3<CR>")
leader('b4', ":buffer 4<CR>")
leader('b5', ":buffer 5<CR>")
leader('b6', ":buffer 6<CR>")
leader('b7', ":buffer 7<CR>")
leader('b8', ":buffer 8<CR>")
leader('b9', ":buffer 9<CR>")

keymap('n', "<leader>bd", ":bd ", {noremap=true})
keymap('n', "<leader>fr", ":Rg ", {noremap=true})

leader('fW', ":set wrap<CR>")
leader('fw', ":set nowrap<CR>")
leader('fs', ":set fdm=syntax<CR>")
leader('fe', ":set fdm=manual<CR>")

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

leader('1sd', ':!rm -rf \\%LOCALAPPDATA\\%/nvim-data/shada<CR>')

leader('yp', ':CopyPathToClipboard<CR>')
leader('yP', ':CopyDirectoryToClipboard<CR>') --


-- perforce stuff
leader('pr', ':P4revert %:p<CR>') --
leader('pk', ':P4discard %:p<CR>') --
leader('pR', ':P4revert ') --
leader('pK', ':P4discard ') --
leader('pc', ':P4checkout %:p<CR>') --
leader('pa', ':P4add %:p<CR>') --
leader('pC', ':P4checkout ') --
leader('p4', ':P4client ') --
leader('pw', ':P4showClient<CR>')
leader('po', ':P4opened<CR>')

leader('lf', ':luafile %:p<CR>')

leader("rw", ':PjrSetCwd %:p:h<CR>')
leader("rc", ':PjrSetCmd ')
leader("rr", ':PjrRun<CR>')
leader("rx", ':PjrAutocmdForce<CR>')

leader("tt", ':DiffviewOpen<CR>')
leader("rf", ":PjrFormat %:p:h<CR>")


leader("sc", ":set syntax=cpp<CR>")
leader("sz", ":set syntax=zig<CR>")
leader("ss", ":set syntax=")
