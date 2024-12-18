return {
  "mfussenegger/nvim-lint",
  event = {
    "BufReadPost",
    "BufNewFile",
  },
  -- opts = {
  --   linters = {
  --     eslint_d = {
  --       args = {
  --         "--no-warn-ignored",
  --         "--format",
  --         "json",
  --         "--stdin",
  --         "--stdin-filename",
  --         function()
  --           return vim.api.nvim_buf_get_name(0)
  --         end,
  --       },
  --     },
  --   },
  -- },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      -- javascript = { "eslint_d" },
      -- typescript = { "eslint_d" },
      -- javascriptreact = { "eslint_d" },
      -- typescriptreact = { "eslint_d" },
      -- svelte = { "eslint_d" },
      kotlin = { "ktlint" },
      clojure = { "clj-kondo" },
      terraform = { "tflint" },
      ruby = { { "standardrb", "rubocop" } },
      python = {
        "ruff" --[[ , "mypy", "pylint" ]],
      },
      cmake = { "cmakelint" },
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
