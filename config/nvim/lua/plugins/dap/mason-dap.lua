return {
  "jay-babu/mason-nvim-dap.nvim",
  opts = {
    ensure_installed = {
      "delve",
      -- "codelldb",
      "python", -- "debugpy",
      -- "js-debug-adapter",
      -- "chrome-debug-adapter",
      "firefox", -- "firefox-debug-adapter",
      -- "node-debug2-adapter",
      -- "dart-debug-adapter",
      -- "kotlin-debug-adapter",
      -- "netcoredbg",
    },
    automatic_installation = true,
    handlers = {
      function(config)
        require("mason-nvim-dap").default_setup(config)
      end,
    },
  },
}
