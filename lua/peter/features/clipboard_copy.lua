
local function copy_path_to_clipboard()
    local path = vim.fn.expand('%:p')
    vim.fn.setreg('+', path)
    print("Copied path to clipboard: " .. path)
end

local function get_directory_from_path(path)
    local ostr = ""
    local lastStr = ""
    local first = true
    for token in string.gmatch(path, "[^/\\]+") do
        if first then
            first = false
            ostr = ostr .. lastStr
        else
            first = false
            ostr = ostr .. "/" .. lastStr
        end
        lastStr = token
    end
    print("Copied directory to clipboard" .. ostr)
    return ostr
end

local function copy_directory_to_clipboard()
    local path = vim.fn.expand('%:p')
    local directory = get_directory_from_path(path)
    vim.fn.setreg('+', directory)
end

vim.api.nvim_create_user_command("CopyPathToClipboard", copy_path_to_clipboard, {nargs = 0, force = true, desc = "Copies the current file path to clipboard"})
vim.api.nvim_create_user_command("CopyDirectoryToClipboard", copy_directory_to_clipboard, {nargs = 0, force = true, desc = "Copies the current file's directory to clipboard"})

