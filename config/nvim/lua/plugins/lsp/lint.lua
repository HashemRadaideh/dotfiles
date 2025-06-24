return {
  "mfussenegger/nvim-lint",
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      -- javascript = { "biome", "eslint_d" },
      -- typescript = { "biome", "eslint_d" },
      -- javascriptreact = { "biome", "eslint_d" },
      -- typescriptreact = { "biome", "eslint_d" },
      -- svelte = { "biome", "eslint_d" },
      -- lua = { "selene" }, -- "luacheck",
      rust = { "bacon" },
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
  end,
}
