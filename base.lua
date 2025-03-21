
vim.cmd([[
    set rtp+=~/my_vimrc
    set isfname-=:
]])

function test_path()
-- :help optionsfunction script_path()
    local paths = vim.api.nvim_list_runtime_paths()
    for count = 1, #paths do
        print("Runtime path: " .. paths[count])
    end
end
-- runtimepath = runtimepath .. script_path()

require("peter.options")
require("peter.color")
require("peter.plugins")
require("peter.filetypes")
require("peter.init_fzf")
require("peter.snippets")
require("peter.cmp")
require("peter.keybinds")
require("peter.local_features")
require("peter.autocmds")

vim.cmd([[set wrap]])
vim.cmd([[set lbr]])
