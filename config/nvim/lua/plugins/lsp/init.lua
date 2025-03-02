return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      -- require("neoconf").setup()
      -- require("neodev").setup()

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
          -- local client = vim.lsp.get_client_by_id(ev.data.client_id)
          -- if client.server_capabilities.inlayHintProvider then
          --   vim.lsp.inlay_hint.enable(true, { ev.buf })
          -- end
          -- vim.lsp.util.make_position_params(ev.buf, "utf-8")
          -- vim.lsp.util.make_position_params(0, "utf-8")

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
          vim.keymap.set("n", "<leader>gr", require("telescope.builtin").lsp_references, opts)
          vim.keymap.set("n", "<leader>uh", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end, opts)
          -- vim.keymap.set("n", "<leader>fn", function()
          --   vim.lsp.buf.format({ async = false })
          -- end, opts)
        end,
      })
    end,
  },
  require("plugins.lsp.conform"),
  require("plugins.lsp.lint"),
  require("plugins.lsp.cmp"),
  require("plugins.lsp.preconfig"),
  { "RRethy/vim-illuminate", event = "LspAttach" },
  { "ray-x/lsp_signature.nvim", event = "LspAttach" },
  { "SmiteshP/nvim-navic", event = "LspAttach" },
  -- { "j-hui/fidget.nvim", event = "LspAttach", opts = {}, },
  -- { "folke/trouble.nvim", event = "LspAttach", opts = {} },
  -- { "folke/neoconf.nvim" },
  -- { "folke/neodev.nvim" },
  --  require("plugins.lsp.none-ls") ,
}
