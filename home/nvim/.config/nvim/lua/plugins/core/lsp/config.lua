return function()
  vim.diagnostic.config({
    severity_sort = true,
    virtual_text = {
      source = "if_many",
      spacing = 2,
      prefix = "■", -- "●", "▎"
      format = function(diagnostic)
        local diagnostic_message = {
          [vim.diagnostic.severity.ERROR] = diagnostic.message,
          [vim.diagnostic.severity.WARN] = diagnostic.message,
          [vim.diagnostic.severity.INFO] = diagnostic.message,
          [vim.diagnostic.severity.HINT] = diagnostic.message,
        }
        return diagnostic_message[diagnostic.severity]
      end,
    },
    virtual_lines = { current_line = true },
    float = {
      severity_sort = true,
      source = "if_many",
      show_header = true,
      border = "none",
      focusable = true,
    },
    signs = { --  
      text = {
        [vim.diagnostic.severity.ERROR] = " ", --  󰅚 ⮾ 
        [vim.diagnostic.severity.WARN] = " ", --  󰀪 ⚠
        [vim.diagnostic.severity.INFO] = " ", --  󰋽 
        [vim.diagnostic.severity.HINT] = "󰌶 ", -- 💡
      },
    },
    underline = true,
    update_in_insert = true,
  })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function(event)
      local map = function(mode, keys, func, desc)
        vim.keymap.set(mode, keys, func, { silent = true, noremap = true, buffer = event.buf, desc = "LSP: " .. desc })
      end

      map("n", "<leader>dal", vim.diagnostic.setloclist, "Add diagnostics to the location list")
      map("n", "<leader>dof", vim.diagnostic.open_float, "Show diagnostics")

      map("n", "<leader>vl", function()
        local current = vim.diagnostic.config().virtual_lines
        vim.diagnostic.config({ virtual_lines = not current and { current_line = true } or false })
      end, "Toggle diagnostic virtual_lines")

      map("n", "<leader>dw", vim.diagnostic.setqflist, "Workspace Diagnostics")

      map("n", "gk", function()
        vim.diagnostic.jump({ count = -1, float = false })
      end, "Goto previous diagnostic")
      map("n", "gj", function()
        vim.diagnostic.jump({ count = 1, float = false })
      end, "Goto next diagnostic")
      map("n", "<leader>ge", function()
        vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
      end, "Goto next error")
      map("n", "<leader>gE", function()
        vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
      end, "Goto prev error")

      map("n", "<leader>ci", vim.lsp.buf.incoming_calls, "Incoming Calls")
      map("n", "<leader>co", vim.lsp.buf.outgoing_calls, "Outgoing Calls")

      map("n", "<leader>ts", vim.lsp.buf.typehierarchy, "Type Hierarchy")

      map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
      map("n", "gR", vim.lsp.buf.references, "Goto References")
      map("n", "gi", vim.lsp.buf.implementation, "Goto Implementation")
      map("n", "<leader>D", vim.lsp.buf.type_definition, "Type Definition")
      map("n", "gO", vim.lsp.buf.document_symbol, "Document Symbols")
      map("n", "gW", vim.lsp.buf.workspace_symbol, "Workspace Symbols")

      -- map("i", "<C-h>", vim.lsp.buf.signature_help, "Signature Help")

      map("n", "K", vim.lsp.buf.hover, "Hover Documentation")

      map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")

      -- map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")

      map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add Workspace Folder")
      map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove Workspace Folder")
      map("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, "List Workspace Folders")

      local client = vim.lsp.get_client_by_id(event.data.client_id)

      if client and client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })

        map("n", "<leader>uh", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
        end, "Toggle Inlay Hints")
      end

      -- if client and client.server_capabilities.codeLensProvider then
      --   vim.lsp.codelens.enable(true, { bufnr = event.buf })

      --   map("n", "<leader>cl", function()
      --     vim.lsp.codelens.enable(not vim.lsp.codelens.is_enabled({ bufnr = event.buf }))
      --   end, "Toggle Code Lens")
      -- end

      if client and client.server_capabilities.semanticTokensProvider then
        vim.lsp.semantic_tokens.enable(true, { bufnr = event.buf })
      end

      -- if client and client:supports_method("textDocument/completion") then
      --   vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
      -- end

      -- if client and client:supports_method("textDocument/inlineCompletion") then
      --   vim.lsp.inline_completion.enable(true, { bufnr = event.buf })
      -- end

      -- if client and client:supports_method("textDocument/onTypeFormatting") then
      --   vim.lsp.on_type_formatting.enable(true, { bufnr = event.buf })
      -- end

      if client and client:supports_method("textDocument/linkedEditingRange") then
        vim.lsp.linked_editing_range.enable(true, { client_id = client.id })
      end

      if client and client:supports_method("textDocument/documentColor") then
        vim.lsp.document_color.enable(true, { bufnr = event.buf })
      end

      if client and client.server_capabilities.documentHighlightProvider then
        local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd("LspDetach", {
          group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
          end,
        })
      end

      -- local filetype = vim.bo[event.buf].filetype
      -- if filetype ~= "fsharp" then
      --   -- https://www.reddit.com/r/neovim/comments/so4g5e/if_you_guys_arent_using_lsp_signaturenvim_what/
      --   local ok, lsp_signature = pcall(require, "lsp_signature")
      --   if ok then
      --     lsp_signature.on_attach({
      --       padding = " ",
      --       handler_opts = {
      --         border = "none",
      --       },
      --       hint_prefix = "🔍",
      --       max_height = 6,
      --       toggle_key = "<C-u>",
      --       move_cursor_key = "<C-w>",
      --     }, event.buf)
      --   end
      -- end
    end,
  })
end
