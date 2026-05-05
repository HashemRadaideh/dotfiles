return {
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
    rust = { "rust_analyzer" },
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
    sh = { "shfmt", "beautysh", stop_after_first = true },
    bash = { "shfmt", "beautysh", stop_after_first = true },
    zsh = { "shfmt", "beautysh", stop_after_first = true },
    fish = { "fish_indent", "beautysh", stop_after_first = true },
    proto = { "buf" },
    protobuf = { "buf" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    cmake = { "cmakelang" },
    asm = { "asmfmt" },
    fsharp = { "fantomas" },
    cs = { "csharpier" },
    dart = { "dcm" },
    nix = { "nixpkgs_fmt" },
    haskell = { "fourmolu", "ormolu", stop_after_first = true },
    gdscript = { "gdformat" },
    eruby = { "erb_format" },
    php = { "php_cs_fixer" },
    python = function(bufnr)
      if require("conform").get_formatter_info("ruff_format", bufnr).available then
        return { "ruff_organize_imports", "ruff_format" }
      end

      local formatters = {}
      if require("conform").get_formatter_info("isort", bufnr).available then
        table.insert(formatters, "isort")
      end

      if require("conform").get_formatter_info("blue", bufnr).available then
        table.insert(formatters, "blue")
      elseif require("conform").get_formatter_info("black", bufnr).available then
        table.insert(formatters, "black")
      end

      return formatters
    end,
    ["_"] = { "trim_whitespace" },
  },
  notify_on_error = false,
  notify_no_formatters = false,
  formatters = {
    ["google-java-format"] = {
      prepend_args = function(_self, ctx)
        return vim.bo[ctx.buf].shiftwidth > 2 and { "--aosp" } or {}
      end,
    },
    ["ruff_format"] = {
      prepend_args = function(_self, ctx)
        return {
          "--config",
          "line-length = " .. vim.bo[ctx.buf].textwidth,
        }
      end,
    },
  },
}
