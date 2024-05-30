
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
        ostr = ostr .. lastStr

        lastStr = token .. "/"

        if not first then
            lastStr = lastStr
        else 
            first = false
        end
    end
    ostr = string.sub(ostr, 1, string.len(ostr) - 1)
    return ostr
end

local function copy_directory_to_clipboard()
    local path = vim.fn.expand('%:p')
    local directory = get_directory_from_path(path)
    print("Copied directory to clipboard: " .. directory)
    vim.fn.setreg('+', directory)
end

vim.api.nvim_create_user_command("CopyPathToClipboard", copy_path_to_clipboard, {nargs = 0, force = true, desc = "Copies the current file path to clipboard"})
vim.api.nvim_create_user_command("CopyDirectoryToClipboard", copy_directory_to_clipboard, {nargs = 0, force = true, desc = "Copies the current file's directory to clipboard"})

