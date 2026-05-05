return function()
  ---@diagnostic disable-next-line: different-requires
  local lint = require("lint")

  -- vim.filetype.add({
  --   pattern = {
  --     [".*%.env"] = "env",
  --   },
  -- })

  -- -- Configure checkstyle to use custom config file
  -- local config_dir = vim.fn.stdpath("config")
  -- local checkstyle_config_path = config_dir .. "/checkstyle.xml"
  -- lint.linters.checkstyle = lint.linters.checkstyle or {}
  -- lint.linters.checkstyle.args = function()
  --   return { "-c", checkstyle_config_path }
  -- end

  -- lint.linters.revive.args = function()
  --   local config = vim.fn.findfile("revive.toml", ".;")
  --   if config ~= "" then
  --     return { "-config", vim.fn.fnamemodify(config, ":p"), "-formatter", "json" }
  --   end
  --   return { "-formatter", "json" }
  -- end
  --

  lint.linters_by_ft = {
    -- Shell
    sh = { "shellcheck" },
    bash = { "shellcheck" },
    zsh = { "shellcheck" },

    -- Go
    go = { "revive" },

    -- C / C++
    c = { "cpplint" },
    cpp = { "cpplint" },

    -- JavaScript / TypeScript
    javascript = { "eslint_d" },
    typescript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    typescriptreact = { "eslint_d" },
    svelte = { "eslint_d" },

    -- Kotlin
    kotlin = { "ktlint" },

    -- Haskell
    haskell = { "hlint" },

    -- Clojure
    clojure = { "clj-kondo" },

    -- Ruby
    ruby = { "rubocop" },
    eruby = { "erb_lint" },

    -- Python
    python = { "ruff" }, --[[ "mypy", "pylint" ]]

    -- Lua
    lua = { "selene" },

    -- Dart
    dart = { "dcm" },

    -- Terraform
    terraform = { "tflint" },

    -- Java
    -- java = { "checkstyle" }, -- needs a checkstyle.xml config file to be useful

    -- Markup / Config
    yaml = { "yamllint", "actionlint" },
    markdown = { "markdownlint" },
    make = { "checkmake" },
    cmake = { "cmakelint" },
    dockerfile = { "hadolint" },
    protobuf = { "protolint" },

    -- GDScript
    gdscript = { "gdlint" },

    -- Vim
    vim = { "vint" },

    -- Generic (runs on all filetypes)
    ["*"] = { "codespell", "misspell", "cspell", "trivy", "ast-grep", "semgrep" },
  }

  local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

  vim.api.nvim_create_autocmd({
    "BufReadPost",
    "BufWritePost",
    "CursorMoved",
    "CursorMovedI",
    "ModeChanged",
    "InsertLeave",
  }, {
    group = lint_augroup,
    callback = function()
      lint.try_lint()
    end,
  })

  vim.keymap.set("n", "<leader>ll", function()
    lint.try_lint()
  end, { desc = "Trigger linting for current file" })
end
