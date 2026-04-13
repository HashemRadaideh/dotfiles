return function()
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

  lint.linters_by_ft = {
    -- javascript = { "biome", "eslint_d" },
    -- typescript = { "biome", "eslint_d" },
    -- javascriptreact = { "biome", "eslint_d" },
    -- typescriptreact = { "biome", "eslint_d" },
    -- svelte = { "biome", "eslint_d" },
    -- lua = { "selene" }, -- "luacheck",
    -- rust = { "bacon" },
    -- java = { "checkstyle" },
    c = { "cpplint" },
    cpp = { "cpplint" },
    cc = { "cpplint" },
    -- markdown = { "markdownlint" },
    kotlin = { "ktlint" },
    clojure = { "clj-kondo" },
    terraform = { "tflint" },
    ruby = {
      "rubocop", --[[ "standardrb" ]]
    },
    python = {
      "ruff", --[[ "mypy", "pylint" ]]
    },
    make = { "checkmake" },
    cmake = { "cmakelint" },
    docker = { "hadolint" },
    protobuf = { "protolint" },
    ["*"] = { "codespell", "misspell", "cspell", "trivy", "ast-grep" },
  }

  local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
    group = lint_augroup,
    callback = function()
      lint.try_lint()
    end,
  })

  vim.keymap.set("n", "<leader>ll", function()
    lint.try_lint()
  end, { desc = "Trigger linting for current file" })
end
