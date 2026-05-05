return {
  "VidocqH/lsp-lens.nvim",
  event = "LspAttach",
  opts = {
    sections = {
      references = function(count)
        return "Ref: " .. count
      end,
      definition = function(count)
        return "Def: " .. count
      end,
      implements = function(count)
        return "Impl: " .. count
      end,
      git_authors = function(latest_author, count)
        return "  " .. latest_author .. (count - 1 == 0 and "" or (" + " .. count - 1))
      end,
    },
    target_symbol_kinds = {
      vim.lsp.protocol.SymbolKind.Interface,
      vim.lsp.protocol.SymbolKind.Enum,
      vim.lsp.protocol.SymbolKind.Struct,
      vim.lsp.protocol.SymbolKind.Class,
      vim.lsp.protocol.SymbolKind.Function,
      vim.lsp.protocol.SymbolKind.Method,
      vim.lsp.protocol.SymbolKind.Constructor,
      vim.lsp.protocol.SymbolKind.EnumMember,
      vim.lsp.protocol.SymbolKind.Constant,
      vim.lsp.protocol.SymbolKind.Variable,
      vim.lsp.protocol.SymbolKind.Property,
      vim.lsp.protocol.SymbolKind.Field,
    },
    wrapper_symbol_kinds = {
      vim.lsp.protocol.SymbolKind.File,
      vim.lsp.protocol.SymbolKind.Module,
      vim.lsp.protocol.SymbolKind.Package,
      vim.lsp.protocol.SymbolKind.Namespace,
      vim.lsp.protocol.SymbolKind.Interface,
      vim.lsp.protocol.SymbolKind.Enum,
      vim.lsp.protocol.SymbolKind.Struct,
      vim.lsp.protocol.SymbolKind.Class,
    },
  },
}