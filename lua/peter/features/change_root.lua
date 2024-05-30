local function up_one()
end

local vim = vim

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
    return ostr
end

-- changes the current working 
local function find_root(path)
    local path = vim.fn.expand('%:p')
    local directory = get_directory_from_path(path)

    vim.cmd("cd " .. directory)
    return found_root
end

local function change_root() 
    local current_file = vim.fn.expand('%:p')
    local directory = get_directory_from_path(current_file)
end

local gActiveClient = nil


local function set_client(client)
    vim.api.nvim_set_var("p4client", client)
end

local function perforce_set_client(opts)
    print("perforce_set_client: " .. vim.inspect(args))
    set_client(opts.args)
end

local function update_client_from_p4()
    local handle = io.popen("p4 client -o")
    local result = handle:read("*a")

    local client = nil

    for line in result:gmatch("[^\r\n]+") do
        if line:find("Client:") then
            client = line:sub(8)
            set_client(client)
            print("Active client set to: " .. client)
            break
        end
    end
    return client
end

local function get_client()
    return vim.api.nvim_get_var("p4client")
end

vim.cmd([[
    let g:p4client = "none"
]])


local function perforce_checkout_auto()
    local file_path = vim.api.nvim_buf_get_name(0)

    if get_client() == nil then
        print("No active client set")
        return
    end

    perforce_checkout(get_client(), file_path)
end

vim.api.nvim_create_user_command("P4Client", perforce_set_client, {nargs = 1, force = true, desc = "sets the active perforce client"})

-- this function runs a console command from vim
local function perforce_checkout(client, file_path)

    
    local handle = io.popen("p4 edit " .. file_path .. " -c " .. client)
    local result = handle:read("*a")

    if result == "" then
        print("Checked out file: " .. file_path)
    else
        print("Error checking out file: " .. file_path)
        print(result)
    end
    
    return result
end

local function perforce_checkout_user(opts)
    local file_path = vim.fn.expand(opts.args)
    
    if get_client() == nil then
        print("No active client set")
        return
    end

    perforce_checkout(get_client(), file_path)
end



vim.api.nvim_create_user_command("P4checkout",  perforce_checkout_user, {nargs = 1, force = true, desc = "Uses the active client and checks out the specified file"})

local function perforce_show_client()
    if get_client() == nil then
        print("No active client set")
        return
    end

    print("active client: " .. get_client())
end

vim.api.nvim_create_user_command("P4showClient", perforce_show_client, {nargs = 0, force = true, desc = "shows the currently active perforce client used for commands"})


-- p4 reconcile for current cwd

local function p4_add(file_path) 
    print(vim.inspect(current_dir))

    local handle = io.popen("p4 add " .. file_path )
    local result = handle:read("*a")

    if result == "" then
        print("added file: " .. file_path)
    else
        print("Error adding file: " .. file_path)
        print(result)
    end
end

local function perforce_add(opts)
    local file_path = vim.fn.expand(opts.args)
    p4_add(file_path)
end

vim.api.nvim_create_user_command("P4add", perforce_add, {nargs = 1, force = true, desc = "adds the specified file to perforce"})


local function p4_revert(opts)

    print(vim.inspect(vim.fn.expand(opts.args)))
    local file_path = vim.fn.expand(opts.args)
    
    local handle = io.popen("p4 revert " .. file_path)
    local result = handle:read("*a")

    if result == "" then
        print("reverting changes to file file: " .. file_path)
    else
        print("Error reverting changes to  file: " .. file_path)
        print(result)
    end
end

vim.api.nvim_create_user_command("P4revert", p4_revert , {nargs = 1, force = true, desc = "reverts a file in perforce"})

local function p4_discard(opts)
    local file_path = vim.fn.expand(opts.args)
    
    local handle = io.popen("p4 revert -k " .. file_path)
    local result = handle:read("*a")

    if result == "" then
        print("discarded changes to file file: " .. file_path)
    else
        print("Error discarding changes to  file: " .. file_path)
        print(result)
    end
end

vim.api.nvim_create_user_command("P4discard", p4_discard , {nargs = 1, force = true, desc = "reverse -k on a file in perforce"})

local function p4_opened(event)
    local handle = io.popen("p4 opened -C " .. get_client())
    local result = handle:read("*a")
    print(result)
end

vim.api.nvim_create_user_command("P4opened", p4_opened , {nargs = 0, force = true, desc = "shows the files currently opened in perforce"})
