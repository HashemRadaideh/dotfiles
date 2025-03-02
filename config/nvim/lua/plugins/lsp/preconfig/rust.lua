return {
  {
    "mrcjkb/rustaceanvim",
    ft = { "rust" },
    config = function()
      local config = require("plugins.lsp.config")

      local mason_registry = require("mason-registry")
      local codelldb = mason_registry.get_package("codelldb")
      local extension_path = codelldb:get_install_path() .. "/extension"
      local codelldb_path = extension_path .. "/adapter/codelldb"
      local liblldb_path = extension_path .. "/lldb/lib/liblldb.so"
      local cfg = require("rustaceanvim.config")

      vim.g.rustaceanvim = {
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
        server = {
          capabilities = config.capabilities,
          on_attach = config.on_attach,
          handlers = config.handlers,
          flags = config.flags,
        },
      }
    end,
  },
  {
    "cordx56/rustowl",
    ft = { "rust" },
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      local config = require("plugins.lsp.config")

      require("lspconfig").rustowl.setup({
        -- capabilities = config.capabilities,
        -- on_attach = config.on_attach,
        -- handlers = config.handlers,
        -- flags = config.flags,
        trigger = {
          hover = false,
        },
      })

      vim.keymap.set(
        "n",
        "<c-o>",
        require("rustowl").rustowl_cursor,
        { noremap = true, silent = true, desc = "Toggle Rustowl" }
      )
    end,
  },
}
