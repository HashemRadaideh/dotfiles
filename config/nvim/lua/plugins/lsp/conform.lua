-- https://www.josean.com/posts/neovim-linting-and-formatting
return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      toml = { "taplo" },
      go = { "goimports", "gofmt" },
      svelte = { "prettier" },
      javascript = { "biome", "prettier", stop_after_first = true },
      typescript = { "biome", "prettier", stop_after_first = true },
      javascriptreact = { "biome", "prettier", stop_after_first = true },
      typescriptreact = { "biome", "prettier", stop_after_first = true },
      css = { "biome", "prettier", stop_after_first = true },
      scss = { "biome", "prettier", stop_after_first = true },
      json = { "biome", "prettier", stop_after_first = true },
      graphql = { "biome", "prettier", stop_after_first = true },
      html = { "biome", "prettier" },
      yaml = { "prettier", "yamlfix" },
      liquid = { "biome", "prettier" },
      ruby = { "rubocop", "standardrb", stop_after_first = true },
      python = function(bufnr)
        if require("conform").get_formatter_info("ruff_format", bufnr).available then
          return { "ruff_organize_imports", "ruff_format" }
        elseif require("conform").get_formatter_info("blue", bufnr).available then
          return { "isort", "blue" }
        else
          return { "isort", "black" }
        end
      end,
      kotlin = { "ktlint", "ktfmt", stop_after_first = true },
      java = { "google-java-format" },
      markdown = { "mdformat", "prettier", stop_after_first = true },
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
      cmake = { "cmakelang" },
      asm = { "asmfmt" },
      fsharp = { "fantomas" },
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
