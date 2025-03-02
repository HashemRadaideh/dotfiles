return {
  "stevearc/conform.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      rust = { "rustfmt", lsp_format = "fallback" },
      toml = { "taplo" },
      go = { "goimports", "gofmt" },
      svelte = { "prettierd", "prettier", stop_after_first = true },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      css = { "prettierd", "prettier", stop_after_first = true },
      scss = { "prettierd", "prettier", stop_after_first = true },
      json = { "prettierd", "prettier", stop_after_first = true },
      graphql = { "prettierd", "prettier", stop_after_first = true },
      yaml = { "yamlfix" },
      liquid = { "prettierd", "prettier" },
      ruby = { "standardrb", "rubocop", stop_after_first = true },
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
      markdown = { "prettierd", "prettier", stop_after_first = true },
      protobuf = { "buf" },
      -- erb = { "htmlbeautifier" },
      -- html = { "htmlbeautifier" },
      sh = { "beautysh", "shfmt", stop_after_first = true },
      bash = { "beautysh", "shfmt", stop_after_first = true },
      zsh = { "beautysh" },
      fish = { "beautysh", "shfmt", stop_after_first = true },
      proto = { "buf" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      cc = { "clang-format" },
      cmake = { "gersemi" },
      asm = { "asmfmt" },
      ["_"] = { "trim_whitespace" },
    },
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
