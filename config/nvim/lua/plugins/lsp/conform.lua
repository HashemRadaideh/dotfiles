return {
  "stevearc/conform.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      rust = { "rustfmt", lsp_format = "fallback" },
      toml = { "taplo" },
      go = { "goimports", "gofmt" },
      svelte = { { "prettierd", "prettier" } },
      javascript = { { "prettierd", "prettier" } },
      typescript = { { "prettierd", "prettier" } },
      javascriptreact = { { "prettierd", "prettier" } },
      typescriptreact = { { "prettierd", "prettier" } },
      css = { { "prettierd", "prettier" } },
      scss = { { "prettierd", "prettier" } },
      json = { { "prettierd", "prettier" } },
      graphql = { { "prettierd", "prettier" } },
      yaml = { "yamlfix" },
      liquid = { "prettierd", "prettier" },
      ruby = { { "standardrb", "rubocop" } },
      -- python = { "isort", "ruff_format", { "blue", "black" } },
      python = function(bufnr)
        if require("conform").get_formatter_info("blue", bufnr).available then
          return { "isort", "blue" }
        elseif require("conform").get_formatter_info("ruff_format", bufnr).available then
          return { "isort", "ruff_format" }
        else
          return { "isort", "black" }
        end
      end,
      kotlin = { "ktlint" },
      java = { "google-java-format" },
      markdown = { { "prettierd", "prettier" } },
      protobuf = { "buf" },
      -- erb = { "htmlbeautifier" },
      -- html = { "htmlbeautifier" },
      sh = { { "beautysh", "shfmt" } },
      bash = { { "beautysh", "shfmt" } },
      zsh = { "beautysh" },
      fish = { { "beautysh", "shfmt" } },
      proto = { "buf" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      cmake = { "gersemi" },
      ["_"] = { "trim_whitespace" },
    },
    -- format_on_save = {
    --   lsp_fallback = true,
    --   async = false,
    --   timeout_ms = 10000,
    -- },
    format_after_save = {
      lsp_format = "fallback",
    },
  },
  keys = {
    {
      "<leader>fn",
      function()
        require("conform").format({ async = true })
      end,
      mode = { "n", "v" },
      desc = "Format file or range (in visual mode)",
    },
  },
}
