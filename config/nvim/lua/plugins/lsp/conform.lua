return {
  "stevearc/conform.nvim",
  event = { "BufReadPre" },
  cmd = { "ConformInfo" },
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
  opts = {
    format_on_save = function(bufnr)
      if vim.fs.dirname(vim.fs.find({ "nuget.config" }, { upward = true })[1]) then
        return nil
      else
        return {
          lsp_format = "fallback",
        }
      end
    end,
    -- format_after_save = {
    --   lsp_format = "fallback",
    -- },
    formatters_by_ft = {
      lua = { "stylua" },
      toml = { "taplo" },
      go = { "goimports", "gofmt" },
      svelte = { "prettier" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      json = { "prettier" },
      graphql = { "prettier" },
      htmlangular = { "prettier" },
      html = { "prettier" },
      -- html = { "htmlbeautifier" },
      -- erb = { "htmlbeautifier" },
      yaml = { "prettier", "yamlfix" },
      liquid = { "prettier" },
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
      cs = { "csharpier" },
      dart = { "dcm" },
      ["_"] = { "trim_whitespace" },
    },
  },
}
