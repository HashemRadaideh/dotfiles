return function()
  vim.diagnostic.config({
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
    float = {
      source = "if_many",
      show_header = true,
      border = "none",
      focusable = true,
    },
    signs = { --  
      text = {
        -- [vim.diagnostic.severity.ERROR] = "", -- ⮾
        -- [vim.diagnostic.severity.WARN] = "", -- ⚠
        -- [vim.diagnostic.severity.INFO] = "",
        -- [vim.diagnostic.severity.HINT] = "💡",
        [vim.diagnostic.severity.ERROR] = "󰅚 ",
        [vim.diagnostic.severity.WARN] = "󰀪 ",
        [vim.diagnostic.severity.INFO] = "󰋽 ",
        [vim.diagnostic.severity.HINT] = "󰌶 ",
      },
    },
    underline = true,
    update_in_insert = true,
    severity_sort = true,
  })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function(event)
      local map = function(mode, keys, func, desc)
        vim.keymap.set(mode, keys, func, { silent = true, noremap = true, buffer = event.buf, desc = "LSP: " .. desc })
      end

      map("n", "<leader>d[", vim.diagnostic.setloclist, "Add diagnostics to the location list")
      map("n", "<leader>d]", vim.diagnostic.open_float, "Show diagnostics")
      map("n", "gk", vim.diagnostic.goto_prev, "Goto previous diagnostic")
      map("n", "gj", vim.diagnostic.goto_next, "Goto next diagnostic")

      -- map("n", "<leader>D", vim.lsp.buf.type_definition, "Goto Type Definition")
      map("n", "<leader>D", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")
      map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
      -- map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
      map("n", "gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
      -- map("n", "gr", vim.lsp.buf.references, "Goto References")
      map("n", "gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
      -- map("n", "gi", vim.lsp.buf.implementation, "Goto Implementation")
      map("n", "gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

      map("n", "K", vim.lsp.buf.hover, "Hover Documentation")

      map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
      map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")

      map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add Workspace Folder")
      map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove Workspace Folder")
      map("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, "List Workspace Folders")

      map("n", "gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")
      map("n", "gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")

      local client = vim.lsp.get_client_by_id(event.data.client_id)
      local filetype = vim.api.nvim_buf_get_option(event.buf, "filetype")

      if filetype ~= "fsharp" then
        -- https://www.reddit.com/r/neovim/comments/so4g5e/if_you_guys_arent_using_lsp_signaturenvim_what/
        require("lsp_signature").on_attach({
          padding = " ",
          handler_opts = {
            border = "none",
          },
          hint_prefix = "🔍",
          max_height = 6,
          toggle_key = "<C-u>",
          move_cursor_key = "<C-w>",
        }, event.buf)
      end

      -- if client.server_capabilities.documentSymbolProvider then
      --   require("nvim-navic").attach(client, event.buf)
      -- end

      -- require("illuminate").on_attach(client)

      -- vim.g.Illuminate_ftblacklist = { "neo-tree" }

      if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
        local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
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
          group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
          end,
        })
      end

      if client and client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { event.buf })

        map("n", "<leader>uh", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, "Toggle Inlay Hints")
      end

      if client and client.server_capabilities.codeLensProvider then
        local codelens_running = false
        vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
          buffer = event.buf,
          callback = function()
            if codelens_running then
              return
            end
            codelens_running = true

            vim.lsp.codelens.refresh()
            vim.defer_fn(function()
              codelens_running = false
            end, 4000)
          end,
        })

        map("n", "<leader>cl", vim.lsp.codelens.run, "Toggle Code Lens")
      end

      -- vim.api.nvim_create_autocmd("VimEnter", {
      --   group = vim.api.nvim_create_augroup("Illuminate", { clear = true }),
      --   pattern = "*",
      --   callback = function()
      --     vim.command([[hi illuminatedWord cterm=underline gui=underline]])
      --   end,
      -- })

      -- vim.api.nvim_command([[ hi def link LspReferenceText CursorLine ]])
      -- vim.api.nvim_command([[ hi def link LspReferenceWrite CursorLine ]])
      -- vim.api.nvim_command([[ hi def link LspReferenceRead CursorLine ]])

      -- vim.api.nvim_create_autocmd("CursorHold", {
      --   buffer = event.buf,
      --   callback = function()
      --     vim.diagnostic.open_float(nil, {
      --       close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      --     })
      --   end,
      -- })

      -- -- Prioritize null-ls formatting over native lsp formatting.
      -- local function has_formatter(filetype)
      --   local available = require("null-ls.sources").get_available(filetype, require("null-ls").methods.FORMATTING)
      --   return #available > 0
      -- end

      -- local enable = false
      -- if has_formatter(vim.api.nvim_buf_get_option(bufnr, "filetype")) then
      --   enable = client.name == "null-ls"
      -- else
      --   enable = not (client.name == "null-ls")
      -- end

      -- client.server_capabilities.document_formatting = enable
      -- client.server_capabilities.document_range_formatting = enable

      -- Auto-formatting
      -- if client and client.server_capabilities.documentFormattingProvider then
      --   vim.api.nvim_create_autocmd("BufWritePre", {
      --     group = vim.api.nvim_create_augroup("Format", { clear = true }),
      --     buffer = bufnr,
      --     callback = function()
      --       vim.lsp.buf.format({
      --         -- formatting_options = {
      --         -- 	tabSize = vim.api.nvim_buf_get_option(bufnr, "tabstop"),
      --         -- 	-- tabSize = 2,
      --         -- 	insertSpaces = true,
      --         -- 	trimTrailingWhitespace = true,
      --         -- 	insertFinalNewline = false,
      --         -- 	trimFinalNewlines = true,
      --         -- },
      --         bufnr = bufnr,
      --         async = false,
      --       })
      --     end,
      --   })
      -- end
    end,
  })

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
  capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

  -- capabilities = {
  --   signatureHelpProvider = {
  --     triggerCharacters = { "(", ",", " " },
  --   },
  --   workspace = {
  --     didChangeWatchedFiles = {
  --       dynamicRegistration = true,
  --     },
  --   },
  --   textDocument = {
  --     completion = {
  --       completionItem = {
  --         snippetSupport = true,
  --         resolveSupport = {
  --           properties = { "documentation", "detail", "additionalTextEdits" },
  --         },
  --       },
  --     },
  --     foldingRange = {
  --       dynamicRegistration = false,
  --       lineFoldingOnly = true,
  --     },
  --   },
  -- }

  local function goto_definition(split_cmd)
    local log = require("vim.lsp.log")

    local handler = function(_, result, ctx)
      if result == nil or vim.tbl_isempty(result) then
        local _ = log.info() and log.info(ctx.method, "No location found")
        return nil
      end

      if split_cmd then
        vim.cmd(split_cmd)
      end

      if vim.tbl_islist(result) then
        vim.lsp.util.jump_to_location(result[1])

        if #result > 1 then
          vim.diagnostic.setqflist(vim.lsp.util.locations_to_items(result))
          vim.api.nvim_command("copen")
          vim.api.nvim_command("wincmd p")
        end
      else
        vim.lsp.util.jump_to_location(result)
      end
    end

    return handler
  end

  local handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help),
    ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = true,
      -- signs = true,
      update_in_insert = true,
      virtual_text = {
        spacing = 5,
        -- severity_limit = "Warning",
      },
    }),
    ["textDocument/definition"] = goto_definition("vsplit"),
    -- ["window/logMessage"] = function(_, result, ctx, _)
    --   local client = vim.lsp.get_client_by_id(ctx.client_id)
    --   local message = result.message

    --   local messageType = result.type
    --   local clientName = client and client.name or "Unknown client"
    --   if messageType == vim.lsp.protocol.MessageType.Error then
    --     vim.notify(string.format("%s LSP Error: %s", clientName, message), vim.log.levels.ERROR)
    --   end
    -- end,
  }

  vim.lsp.config("*", {
    capabilities = capabilities,
    handlers = handlers,
  })
end
