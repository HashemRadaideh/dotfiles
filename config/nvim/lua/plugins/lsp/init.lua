return {
  {
    { require("plugins.lsp.mason") },
    { require("plugins.lsp.mason-lspconfig") },
    { require("plugins.lsp.mason-tool-installer") },
    -- { require("plugins.lsp.none-ls") },
    { require("plugins.lsp.conform") },
    { require("plugins.lsp.lint") },
    { require("plugins.lsp.cmp") },
    { "RRethy/vim-illuminate", event = "LspAttach" },
    { "ray-x/lsp_signature.nvim", event = "LspAttach" },
    -- { "onsails/lspkind.nvim", event = "LspAttach" },
    { "j-hui/fidget.nvim", event = "LspAttach", tag = "legacy", opts = {} },
    { "lvimuser/lsp-inlayhints.nvim", event = "LspAttach", opts = {} },
    -- { "folke/trouble.nvim", event = "LspAttach", opts = {} },
    -- { "folke/neoconf.nvim" },
    -- { "folke/neodev.nvim" },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      -- require("neoconf").setup({
      --   -- override any of the default settings here
      -- })
      -- require("neodev").setup({
      --   -- add any options here, or leave empty to use the default settings
      -- })

      require("plugins.lsp.languages")

      local options = function(hint)
        return { silent = true, desc = hint }
      end

      vim.keymap.set("n", "<leader>d[", vim.diagnostic.setloclist, options("Add diagnostics to the location list"))
      vim.keymap.set("n", "<leader>d]", vim.diagnostic.open_float, options("Show diagnostics"))
      -- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, options("Go to previous diagnostic"))
      -- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, options("Go to next diagnostic"))
      vim.keymap.set("n", "gk", vim.diagnostic.goto_prev, options("Go to previous diagnostic"))
      vim.keymap.set("n", "gj", vim.diagnostic.goto_next, options("Go to next diagnostic"))

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "gi", require("telescope.builtin").lsp_implementations, opts)
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
          -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, opts)
          -- vim.keymap.set("n", "<leader>fn", function()
          --   vim.lsp.buf.format({ async = false })
          -- end, opts)
        end,
      })
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    ft = { "rust" },
  },
  {
    "ray-x/go.nvim",
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    dependencies = {
      { "leoluz/nvim-dap-go", ft = "go", opts = {} },
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
  },
  {
    "akinsho/flutter-tools.nvim",
    ft = { "dart" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    -- config = true,
    config = function()
      local config = require("plugins.lsp.config")
      require("flutter-tools").setup({
        lsp = {
          on_attach = config.on_attach,
          capabilities = config.capabilities,
          settings = {
            showTodos = true,
            completeFunctionCalls = true,
            analysisExcludedFolders = {
              vim.fn.expand("$HOME/AppData/Local/Pub/Cache"),
              vim.fn.expand("$HOME/.pub-cache"),
              vim.fn.expand("/opt/homebrew"),
              vim.fn.expand("$HOME/tools/flutter"),
            },
            renameFilesWithClasses = "prompt",
            enableSnippets = true,
            updateImportsOnRename = true,
          },
        },
      })
    end,
  },
  -- {
  --   "mfussenegger/nvim-jdtls",
  --   ft = { "java" },
  -- },
  {
    "nvim-java/nvim-java",
    ft = { "java" },
    dependencies = {
      "nvim-java/lua-async-await",
      "nvim-java/nvim-java-core",
      "nvim-java/nvim-java-test",
      "nvim-java/nvim-java-dap",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      local config = require("plugins.lsp.config")

      require("java").setup()
      require("lspconfig").jdtls.setup(config)
    end,
  },
}
