local ok, mason = pcall(require, "mason")
if not ok then
  return
end

mason.setup({
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  }
})

local ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not ok then
  return
end

mason_lspconfig.setup({
  ensure_installed = {},
  automatic_installation = true,
})
