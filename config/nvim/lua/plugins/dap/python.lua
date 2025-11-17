return {
  "mfussenegger/nvim-dap-python",
  dependencies = { "mfussenegger/nvim-dap" },
  ft = "python",
  config = function()
    require("dap-python").setup("uv")

    -- require("dap-python").resolve_python = function()
    --   local cwd = vim.fn.getcwd()

    --   if vim.fn.filereadable(cwd .. "/pyproject.toml") then
    --     return vim.fn.executable("uv")
    --   end

    --   -- -- Poetry
    --   -- if vim.fn.glob("poetry.lock") ~= "" then
    --   --   local handle = io.popen("poetry env info -p 2>/dev/null")
    --   --   if handle then
    --   --     local venv = handle:read("*a"):gsub("%s+$", "")
    --   --     handle:close()
    --   --     if venv ~= "" and vim.fn.executable(venv .. "/bin/python") == 1 then
    --   --       return venv .. "/bin/python"
    --   --     end
    --   --   end
    --   -- end

    --   -- -- Pipenv
    --   -- if vim.fn.glob("Pipfile") ~= "" then
    --   --   local handle = io.popen("pipenv --venv 2>/dev/null")
    --   --   if handle then
    --   --     local venv = handle:read("*a"):gsub("%s+$", "")
    --   --     handle:close()
    --   --     if venv ~= "" and vim.fn.executable(venv .. "/bin/python") == 1 then
    --   --       return venv .. "/bin/python"
    --   --     end
    --   --   end
    --   -- end

    --   if vim.env.VIRTUAL_ENV then
    --     return vim.env.VIRTUAL_ENV .. "/bin/python"
    --   elseif vim.env.CONDA_PREFIX then
    --     return vim.env.CONDA_PREFIX .. "/bin/python"
    --   end

    --   return vim.fn.exepath("python") or "python"
    -- end
  end,
}
