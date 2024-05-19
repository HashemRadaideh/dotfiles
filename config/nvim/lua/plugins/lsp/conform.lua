return {
  "stevearc/conform.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      rust = { "rustfmt" },
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
      python = { "isort", "blue" },
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
    format_on_save = {
      lsp_fallback = true,
      async = false,
      timeout_ms = 1000,
    },
  },
  keys = {
    {
      "<leader>fn",
      function()
        require("conform").format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        })
      end,
      mode = { "n", "v" },
      desc = "Format file or range (in visual mode)",
    },
  },
}
