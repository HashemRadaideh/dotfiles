return {
  {
    "mrcjkb/rustaceanvim",
    ft = { "rust" },
    config = function()
      local config = require("plugins.lsp.config")

      -- local mason_registry = require("mason-registry")
      -- local codelldb = mason_registry.get_package("codelldb")
      -- local extension_path = codelldb:get_install_path() .. "/extension"
      -- local codelldb_path = extension_path .. "/adapter/codelldb"
      -- local liblldb_path = extension_path .. "/lldb/lib/liblldb.so"

      local stdpath = vim.fn.stdpath("data")
      local extension_path = stdpath .. "/mason" .. "/packages" .. "/codelldb" .. "/extension"
      local codelldb_path = extension_path .. "/adapter" .. "/codelldb"
      local liblldb_path = extension_path .. "/lldb" .. "/lib" .. "/liblldb.so"

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
  -- {
  --   "cordx56/rustowl",
  --   ft = { "rust" },
  --   dependencies = { "neovim/nvim-lspconfig" },
  --   build = "cd rustowl && cargo install --path . --locked",
  --   opts = {
  --     auto_attach = true, -- Auto attach the RustOwl LSP client when opening a Rust file
  --     auto_enable = false, -- Enable RustOwl immediately when attaching the LSP client
  --     idle_time = 500, -- Time in milliseconds to hover with the cursor before triggering RustOwl
  --     client = {}, -- LSP client configuration that gets passed to `vim.lsp.start`
  --   },
  --   -- config = function()
  --   --   local config = require("plugins.lsp.config")

  --   --   vim.lsp.enable("rustowl")
  --   --   vim.lsp.config("rustowl", {
  --   --     -- capabilities = config.capabilities,
  --   --     -- on_attach = config.on_attach,
  --   --     -- handlers = config.handlers,
  --   --     -- flags = config.flags,
  --   --     trigger = {
  --   --       hover = false,
  --   --     },
  --   --   })
  --   -- end,
  --   key = {
  --     "<leader>ro",
  --     [[<cmd>Rustowl toggle<CR>]],
  --     { noremap = true, silent = true, desc = "Toggle Rustowl" },
  --   },
  -- },
}
