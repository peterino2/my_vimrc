
vim.cmd([[
    set rtp+=~/my_vimrc
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
require("peter.plugins")
require("peter.color")
require("peter.lsp_config")
require("peter.filetypes")
require("peter.init_fzf")
require("peter.snippets")
require("peter.coq_setup")
require("peter.keybinds")

