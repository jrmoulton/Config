
vim.fn.sign_define('DapBreakpoint', {text='B', texthl='', linehl='', numhl=''})

local breakpoints = require('dap.breakpoints')

function _G.store_breakpoints(clear)
    local load_bps_raw = io.open(HOME .. '/.cache/dap/breakpoints.json', 'r'):read("*a")
    local bps = vim.fn.json_decode(load_bps_raw)
    local breakpoints_by_buf = breakpoints.get()
    if (clear) then
        for _, bufrn in ipairs(vim.api.nvim_list_bufs()) do
            local file_path = vim.api.nvim_buf_get_name(bufrn)
            if (bps[file_path] ~= nil) then
                bps[file_path] = {}
            end
        end
    else
        for buf, buf_bps in pairs(breakpoints_by_buf) do
            bps[vim.api.nvim_buf_get_name(buf)] = buf_bps
        end
    end
    local fp = io.open(HOME .. '/.cache/dap/breakpoints.json', 'w')
    local final = vim.fn.json_encode(bps)
    fp:write(final)
    fp:close()
end

function _G.load_breakpoints()
    local fp = io.open(HOME .. '/.cache/dap/breakpoints.json', 'r')
    local content = fp:read('*a')
    local bps = vim.fn.json_decode(content)
    local loaded_buffers = {}
    local found = false
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local file_name = vim.api.nvim_buf_get_name(buf)
        if (bps[file_name] ~= nil and bps[file_name] ~= {}) then
            found = true
        end
        loaded_buffers[file_name] = buf
    end
    if (found == false) then
        return
    end
    for path, buf_bps in pairs(bps) do
        for _, bp in pairs(buf_bps) do
            local line = bp.line
            local opts = {
                condition = bp.condition,
                log_message = bp.logMessage,
                hit_condition = bp.hitCondition
            }
            breakpoints.set(opts, tonumber(loaded_buffers[path]), line)
        end
    end
end

local dap = require('dap')
dap.adapters.lldb = {
    type = 'executable',
    command = '/opt/homebrew/opt/llvm/bin/lldb-vscode', -- adjust as needed
    name = "lldb"
}

local function file_exists(name)
    local f=io.open(name,"r")
    if f~=nil then io.close(f) return true else return false end
end

local function build_c(command)
    -- if there is a make file run make
    if (file_exists('Makefile')) then
        local ret = vim.fn.system('make debug')
        if vim.v.shell_error ~= 0 then
            print(ret)
            vim.api.nvim_err_writeln("Failed to execute the following command:\n" .. "make debug")
            return false
        end
        dap.listeners.after.event_exited["remove main"] = function(_, _)
            print("not deleting main")
        end
        return vim.fn.getcwd() .. "/target/debug/main"
    else
        local file_name = vim.api.nvim_buf_get_name(0)
        local exec_name = "debug_exec"
        local hidden_folder = string.format(".temp_debug%s", math.random(10000))
        vim.fn.system(string.format("mkdir %s", hidden_folder))
        local ret = vim.fn.system(string.format('%s -g -o %s/%s %s', command, hidden_folder, exec_name, file_name))
        if vim.v.shell_error ~= 0 then
            vim.fn.system(string.format("rm -r %s", hidden_folder))
            print(ret)
            vim.api.nvim_err_writeln("Failed to execute the following command:\n" .. "clang")
            return false
        end
        dap.listeners.after.event_exited["remove main"] = function(_, _)
            vim.fn.system(string.format("rm -r %s", hidden_folder))
            -- vim.fn.system(string.format("rm %s %s.dYSM", exec_name, exec_name))
        end
        return string.format("%s/%s/%s", vim.fn.getcwd(), hidden_folder, exec_name)
    end
    -- os.execute('make debug')
end

function Split(s, delimiter)
    local result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

dap.configurations.c = {
{
        name = "Launch",
        type = "lldb",
        request = "launch",
        program = function()
            local path = build_c("clang")
            return path
            -- return string.format('%s/debug-exe', vim.fn.getcwd())
            -- return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = function()
            local val = Split(vim.fn.input('Args: ', ''), " ");
            if (val ~="") then
                return val;
            else
                return;
        end
        end,
    },
}

dap.configurations.cpp = {
{
        name = "Launch",
        type = "lldb",
        request = "launch",
        program = function()
            build_c("clang++")
            return string.format('%s/dap', vim.fn.getcwd())
            -- return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = function() return Split(vim.fn.input('Args: ', ''), " ") end,
    },
}

-- If you want to use this for rust and c, add something like this:

-- dap.configurations.rust = dap.configurations.cpp
