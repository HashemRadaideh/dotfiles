local config = require("plugins.lsp.config")

-- https://jdhao.github.io/2023/07/22/neovim-pylsp-setup/
local venv_path = os.getenv("VIRTUAL_ENV")
local py_path = nil
-- decide which python executable to use for mypy
if venv_path ~= nil then
  py_path = venv_path .. "/bin/python3"
else
  py_path = vim.g.python3_host_prog
end

vim.lsp.config("pylsp", {
  on_attach = config.on_attach,
  flags = config.flags,
  capabilities = config.capabilities,
  handlers = config.handlers,
  settings = {
    pylsp = {
      plugins = {
        -- formatter options
        blue = { enabled = true },
        black = { enabled = false },
        autopep8 = { enabled = false },
        yapf = { enabled = false },
        -- linter options
        pylint = {
          enabled = true,
          args = {
            "--disable=missing-module-docstring,missing-function-docstring,too-many-positional-arguments,too-many-arguments,too-many-instance-attributes,line-too-long,broad-exception-caught,missing-class-docstring,broad-exception-raised,too-few-public-methods,trailing-newlines,import-error,too-many-locals,too-many-statements,too-many-branches",
          },
        },
        ruff = { enabled = true },
        pyflakes = { enabled = true },
        pycodestyle = {
          enabled = false,
          args = {
            "--ignore=E501,E121,E123,E126,E226,E24,E704,W503,W504",
          },
        },
        -- type checker
        pylsp_mypy = {
          enabled = true,
          overrides = { "--python-executable", py_path, true },
          report_progress = true,
          live_mode = false,
        },
        -- auto-completion options
        jedi_completion = { fuzzy = true },
        -- import sorting
        pyls_isort = { enabled = true },
      },
    },
  },
})
vim.lsp.enable("pylsp")

-- vim.lsp.config("pyright", config)
-- vim.lsp.enable("pyright")

-- vim.lsp.config("ruff", config)
-- vim.lsp.enable("ruff")

-- vim.lsp.config("pylyzer", config)
-- vim.lsp.enable("pylyzer")

-- vim.lsp.config("django_template_lsp", config)
-- vim.lsp.enable("django_template_lsp")

-- vim.lsp.config("pyre", config)
-- vim.lsp.enable("pyre")

-- vim.lsp.config("sourcery",  config)
-- vim.lsp.enable("sourcery")
