local ok, installer = pcall(require, "nvim-lsp-installer")
if not ok then
  return
end

installer.setup({
  ensure_installed = "all",
  automatic_installation = true,
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  }
})
