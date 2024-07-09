
local function pjr_set_cmd(cmd)
    vim.api.nvim_set_var("pjr_cmd", cmd)
end

local function pjr_set_cwd(cwd)
    vim.api.nvim_set_var("pjr_cwd", cwd)
end

local function pjr_get_dir() 
    dir = vim.g.pjr_cwd
    if dir == nil then
        dir = vim.loop.cwd()
    end
    return dir
end

local function pjr_run()
    if vim.g.pjr_cmd == nil then 
        return
    end
    print(pjr_get_dir())

    c = ":tabnew | term cd /d " .. pjr_get_dir() .. " && " .. vim.g.pjr_cmd 

    vim.cmd(c)
end

local function test_main()
    pjr_set_cmd("zig build")
    pjr_set_cwd("D:/uproj/NeonWood/projects")

    x = pjr_get_dir()
    pjr_run()
end

local function pjr_set_cmd_user(opts)
    pjr_set_cmd(opts.args)
end

local function pjr_set_cwd_user(opts)
    pjr_set_cwd(vim.fn.expand(opts.args))
end



local function find_peterino(path)
    tokens = string.gmatch(path, "[^/\\]+")
    l = {}

    for token in tokens do
        table.insert(l, token)
    end
    
    for i=#l, 1, -1 do
        spath = ""
        for x = 1, i do
            spath = spath .. l[x] .. "/"
        end
        basepath = spath
        spath = spath .. ".peterino"

        if vim.fn.filereadable(spath) == 1 then
           local f = assert(io.open(spath, "rb"))
            local cmd = f:read("*all")
            f:close()
            cmd = cmd:gsub("\r", "")
            cmd = cmd:gsub("\n", "")
            print(cmd)
            return cmd, basepath
        end
    end
end


local function pjr_autobuf()
    if vim.g.pjr_cmd ~= nil then
        return
    end
    
    cmd, cwd = find_peterino(vim.fn.expand("%:p:h"))
    pjr_set_cwd(cwd)
    pjr_set_cmd(cmd)
end

local function pjr_autobuf_forced()
    vim.g.pjr_cmd = nil
    
    pjr_autobuf()
end

local function edit_pjr() 
    vim.cmd(":tabnew " .. pjr_get_dir() .. "/.peterino")
    pjr_autobuf_forced()
end

-- test_main()
vim.api.nvim_create_user_command("PjrSetCmd", pjr_set_cmd_user, {nargs = 1, force = true, desc = "Sets the command for the project runner"})
vim.api.nvim_create_user_command("PjrSetCwd", pjr_set_cwd_user, {nargs = 1, force = true, desc = "Sets the working directory for the project runner"})
vim.api.nvim_create_user_command("PjrRun", pjr_run, {nargs = 0, force = true, desc = "Runs the command"})
vim.api.nvim_create_user_command("PjrAutocmd", pjr_autobuf, {nargs = 0, force = true, desc = "automatic .peterino file find"})
vim.api.nvim_create_user_command("PjrAutocmdForce", pjr_autobuf_forced, {nargs = 0, force = true, desc = "automatic .peterino file find"})
vim.api.nvim_create_user_command("PjrEdit", pjr_autobuf_forced, {nargs = 0, force = true, desc = "automatic .peterino file find"})


local function go_to_file()
end

-- how should this work.
-- 1. let me set a command
-- 2. let me set a working directory
--   - if no working directory is set,
-- 3. run the command via tabnew | term <command>
