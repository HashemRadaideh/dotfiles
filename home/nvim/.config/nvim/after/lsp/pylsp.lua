return {
  settings = {
    pylsp = {
      plugins = {
        ruff = { enabled = true },

        -- import sorting
        pyls_isort = { enabled = true },

        -- formatter options
        blue = { enabled = true },
        black = { enabled = false },
        autopep8 = { enabled = false },
        yapf = { enabled = false },

        -- linter options
        pyflakes = { enabled = true },
        pylint = {
          enabled = true,
          args = {
            "--disable=" .. table.concat({
              "import-outside-toplevel",
              "g-import-not-at-top",
              "ungrouped-imports",
              "bad-indentation",
              "missing-module-docstring",
              "missing-class-docstring",
              "missing-function-docstring",
              "too-few-public-methods",
              "too-many-locals",
              "too-many-statements",
              "too-many-branches",
              "too-many-arguments",
              "too-many-positional-arguments",
              "too-many-instance-attributes",
              "line-too-long",
              "broad-exception-caught",
              "broad-exception-raised",
              "trailing-newlines",
            }, ","),
          },
        },
        pycodestyle = {
          enabled = false,
          args = {
            "--ignore=" .. table.concat({
              "E501",
              "E121",
              "E123",
              "E126",
              "E226",
              "E24",
              "E704",
              "W503",
              "W504",
            }, ","),
          },
        },

        -- type checker
        pylsp_mypy = {
          enabled = true,
          overrides = {
            "--python-executable",
            (function()
              -- https://jdhao.github.io/2023/07/22/neovim-pylsp-setup/
              local venv_path = os.getenv("VIRTUAL_ENV")

              return venv_path ~= nil and venv_path .. "/bin/python" or vim.g.python3_host_prog
            end)(),
            true
          },
          report_progress = true,
          live_mode = false,
        },

        -- auto-completion options
        jedi_completion = { fuzzy = true },
      },
    },
  },
}
