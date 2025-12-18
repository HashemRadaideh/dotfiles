return {
  "stevearc/conform.nvim",
  event = { "BufReadPre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>fn",
      function()
        require("conform").format()
      end,
      mode = { "n", "v" },
      desc = "Format file or range (in visual mode)",
    },
  },
  opts = {
    format_on_save = function(_bufnr)
      if vim.fs.dirname(vim.fs.find({ "nuget.config" }, { upward = true })[1]) then
        return nil
      else
        return {
          lsp_format = "fallback",
        }
      end
    end,
    formatters_by_ft = {
      lua = { "stylua" },
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
      yaml = { "prettier" },
      liquid = { "prettier" },
      toml = { "taplo" },
      ruby = { "rubocop", "standardrb", stop_after_first = true },
      kotlin = { "ktlint", "ktfmt", stop_after_first = true },
      java = { "google-java-format", "clang-format", stop_after_first = true },
      markdown = { "mdformat", "prettier", stop_after_first = true },
      sh = { "beautysh", "shfmt", stop_after_first = true },
      bash = { "beautysh", "shfmt", stop_after_first = true },
      zsh = { "beautysh", "shfmt", stop_after_first = true },
      fish = { "beautysh", "shfmt", stop_after_first = true },
      proto = { "buf" },
      protobuf = { "buf" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      cmake = { "cmakelang" },
      asm = { "asmfmt" },
      fsharp = { "fantomas" },
      cs = { "csharpier" },
      dart = { "dcm" },
      python = function(bufnr)
        if require("conform").get_formatter_info("ruff_format", bufnr).available then
          return { "ruff_organize_imports", "ruff_format" }
        elseif require("conform").get_formatter_info("blue", bufnr).available then
          return { "isort", "blue" }
        else
          return { "isort", "black" }
        end
      end,
      ["_"] = { "trim_whitespace" },
    },
    notify_on_error = false,
    notify_no_formatters = false,
    formatters = {
      ["google-java-format"] = {
        prepend_args = { "-a" },
      },
    },
  },
}
