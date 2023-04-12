local ok, dap = pcall(require, "dap")
if not ok then
  return
end

require("plugins.dap.configs.dapui")
require("plugins.dap.configs.virtual_text")

--[[
-- https://www.reddit.com/r/neovim/comments/pzlzof/will_we_ever_get_nice_debugging_functionality_in/
-- https://www.reddit.com/r/neovim/comments/silikv/debugging_in_neovim/
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
--]]


-- local venv = os.getenv("VIRTUAL_ENV")
-- command = vim.fn.getcwd() .. string.format("%s/bin/python", venv)

---@diagnostic disable-next-line: undefined-global
dap.adapters.python = {
  type = "executable",
  -- https://docs.python.org/3/library/venv.html
  command = "C:\\Users\\Hashem\\venv\\Scripts\\python.exe",
  args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = "launch",
    name = "Launch file",

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}", -- This configuration will launch the current file if used.
    -- pythonPath = function()
    --     -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
    --     -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
    --     -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
    --     local cwd = vim.fn.getcwd()
    --     if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
    --         return cwd .. "/venv/bin/python"
    --     elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
    --         return cwd .. "/.venv/bin/python"
    --     else
    --         return "/usr/bin/python"
    --     end
    -- end,
  },
}
