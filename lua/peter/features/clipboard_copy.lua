
local function copy_path_to_clipboard()
    local path = vim.fn.expand('%:p')
    vim.fn.setreg('+', path)
    print("Copied path to clipboard: " .. path)
end

vim.api.nvim_create_user_command("CopyPathToClipboard", copy_path_to_clipboard, {
    nargs = 0, force = true, desc = "Copies the current file path to clipboard"})
