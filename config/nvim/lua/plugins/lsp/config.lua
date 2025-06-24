vim.diagnostic.config({
  virtual_text = {
    source = true,
    prefix = "■", -- "●", "▎"
  },
  float = {
    source = true,
    show_header = true,
    border = "rounded",
    focusable = true,
  },
  signs = { --  
    text = {
      [vim.diagnostic.severity.ERROR] = "", -- ⮾
      [vim.diagnostic.severity.WARN] = "", -- ⚠
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "💡",
    },
  },
  underline = true,
  update_in_insert = true,
  severity_sort = true,
})

-- local signs = {}
-- for type, icon in pairs(signs) do
--   local hl = "DiagnosticSign" .. type
--   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
-- end

-- local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
local capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities.textDocument.completion.completionItem.resolveSupport = {
-- 	properties = { "documentation", "detail", "additionalTextEdits" },
-- }
-- capabilities.textDocument.foldingRange = {
-- 	dynamicRegistration = false,
-- 	lineFoldingOnly = true,
-- }
capabilities = {
  signatureHelpProvider = {
    triggerCharacters = { "(", ",", " " },
  },
  textDocument = {
    completion = {
      completionItem = {
        snippetSupport = true,
        resolveSupport = {
          properties = { "documentation", "detail", "additionalTextEdits" },
        },
      },
    },
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    },
  },
}

local flags = { debounce_text_changes = 100 }

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

local border = {
  { "", "FloatBorder" },
  { "", "FloatBorder" },
  { "", "FloatBorder" },
  { "", "FloatBorder" },
  { "", "FloatBorder" },
  { "", "FloatBorder" },
  { "", "FloatBorder" },
  { "", "FloatBorder" },
}

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
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
  ["window/logMessage"] = function(_, result, ctx, _)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    local message = result.message

    local messageType = result.type
    local clientName = client and client.name or "Unknown client"
    if messageType == vim.lsp.protocol.MessageType.Error then
      vim.notify(string.format("%s LSP Error: %s", clientName, message), vim.log.levels.ERROR)
    end
  end,
}

local on_attach = function(client, bufnr)
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

  -- -- Auto-formatting
  -- if client.server_capabilities.documentFormattingProvider then
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

  -- vim.lsp.util.make_position_params(0, "utf-8")
  -- vim.lsp.util.make_range_params(0, "utf-8")

  -- codelens
  if client.server_capabilities.codeLensProvider then
    -- vim.api.nvim_command([[autocmd CursorHold,CursorHoldI,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]])
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI", "InsertLeave" }, {
      group = vim.api.nvim_create_augroup("CodeLens", { clear = true }),
      buffer = bufnr,
      callback = function()
        vim.lsp.codelens.refresh()
      end,
    })
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cl", "<Cmd>lua vim.lsp.codelens.run()<CR>", { silent = true })
  end

  -- inlay hints
  if client.server_capabilities.inlayHintProvider then
    -- require("inlay-hints").on_attach(client, bufnr)
    -- require("lsp-inlayhints").on_attach(client, bufnr)
    -- vim.lsp.buf.inlay_hint(bufnr, true)
    -- vim.lsp.inlay_hint(bufnr, true)
    -- vim.lsp.inlay_hint.enable(bufnr, true)
    -- vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 })
    vim.lsp.inlay_hint.enable(true, { bufnr })
  end

  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end

  -- Get the filetype of the current buffer
  local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

  -- Skip lsp_signature setup for F# files
  if filetype ~= "fsharp" then
    -- https://www.reddit.com/r/neovim/comments/so4g5e/if_you_guys_arent_using_lsp_signaturenvim_what/
    require("lsp_signature").on_attach({
      bind = true,
      padding = "",
      handler_opts = {
        border = "rounded",
      },
      hint_enable = true,
      hint_prefix = "🔍 ",
      -- toggle_key = "<C-k>",
      extra_trigger_chars = { "(", ",", " " },
    }, bufnr)
  end

  require("illuminate").on_attach(client)

  vim.g.Illuminate_ftblacklist = { "neo-tree" }

  vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("Illuminate", { clear = true }),
    pattern = "*",
    callback = function()
      vim.command([[ hi illuminatedWord cterm=underline gui=underline ]])
    end,
  })

  vim.api.nvim_command([[ hi def link LspReferenceText CursorLine ]])
  vim.api.nvim_command([[ hi def link LspReferenceWrite CursorLine ]])
  vim.api.nvim_command([[ hi def link LspReferenceRead CursorLine ]])

  -- vim.api.nvim_create_autocmd("CursorHold", {
  --   buffer = bufnr,
  --   callback = function()
  --     vim.diagnostic.open_float(nil, {
  --       close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
  --     })
  --   end,
  -- })

  -- local opts = { noremap = true, silent = true }
  -- local buf_map = vim.api.nvim_buf_set_keymap
  -- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- buf_map(bufnr, "n", "gD", ":lua vim.lsp.buf.declaration()<CR>", opts)
  -- buf_map(bufnr, "n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
  -- buf_map(bufnr, "n", "K", ":lua vim.lsp.buf.hover()<CR>", opts)
  -- -- buf_map(bufnr, "n", "gi", ":lua vim.lsp.buf.implementation()<CR>", opts)
  -- buf_map(bufnr, "n", "gi", ":lua require('telescope.builtin').lsp_implementations()<CR>", opts)
  -- buf_map(bufnr, "n", "<C-k>", ":lua vim.lsp.buf.signature_help()<CR>", opts)
  -- buf_map(bufnr, "n", "<leader>wa", ":lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  -- buf_map(bufnr, "n", "<leader>wr", ":lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  -- buf_map(bufnr, "n", "<leader>wl", ":lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  -- buf_map(bufnr, "n", "<leader>D", ":lua vim.lsp.buf.type_definition()<CR>", opts)
  -- buf_map(bufnr, "n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>", opts)
  -- buf_map(bufnr, "n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", opts)
  -- buf_map(bufnr, "v", "<leader>ca", ":lua vim.lsp.buf.range_code_action()", opts)
  -- -- buf_map(bufnr, "n", "gr", ":lua vim.lsp.buf.references()<CR>", opts)
  -- buf_map(bufnr, "n", "gr", ":lua require('telescope.builtin').lsp_references()<CR>", opts)
  -- buf_map(bufnr, "n", "<leader>fa", ":lua vim.lsp.buf.format { async = true }<CR>", opts)
  -- buf_map(bufnr, "v", "<leader>fn", ":lua vim.lsp.buf.range_formatting()", opts)
  -- buf_map(bufnr, "n", "<leader>sa", ":lua vim.lsp.buf.signature_help()<CR>", opts)

  -- -- Enable completion triggered by <c-x><c-o>
  -- vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

  -- local options = function(hint)
  --   return { buffer = bufnr, silent = true, desc = hint }
  -- end

  -- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, options("Add diagnostics to the location list"))
  -- vim.keymap.set("n", "<leader>pd", vim.diagnostic.open_float, options("Show diagnostics"))
  -- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, options("Go to previous diagnostic"))
  -- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, options("Go to next diagnostic"))
  -- vim.keymap.set("n", "gk", vim.diagnostic.goto_prev, options("Go to previous diagnostic"))
  -- vim.keymap.set("n", "gj", vim.diagnostic.goto_next, options("Go to next diagnostic"))

  -- vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace"))
  -- vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace"))
  -- vim.keymap.set("n", "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
  --   opts("List workspace folders"))
  -- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts("Project wild rename"))
  -- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts("Perform code action"))
  -- vim.keymap.set('v', '<leader>ca', vim.lsp.buf.range_code_action, opts("Perform code action"))

  -- if client.server_capabilities.declarationProvider then
  --   vim.keymap.set('n', 'gD', vim.lsp.buf.declaration())
  -- end

  -- if client.server_capabilities.definitionProvider then
  -- vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
  --   vim.keymap.set('n', 'gd', vim.lsp.buf.definition())
  -- end

  -- if client.server_capabilities.typeDefinitionProvider then
  --   vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition())
  -- end

  -- if client.server_capabilities.hoverProvider then
  --   vim.keymap.set('n', 'K', vim.lsp.buf.hover())
  -- end

  -- if client.server_capabilities.implementationProvider then
  --   -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation("Go to implementation"))
  --   vim.keymap.set("n", "gi", require('telescope.builtin').lsp_implementations())
  -- end

  -- if client.server_capabilities.signatureHelpProvider then
  --   vim.keymap.set('n', '<leader>sa', vim.lsp.buf.signature_help())
  -- end

  -- if client.server_capabilities.referencesProvider then
  --   -- vim.keymap.set('n', 'gr', vim.lsp.buf.references("Go to references"))
  --   vim.keymap.set("n", "gr", require('telescope.builtin').lsp_references())
  -- end

  -- if client.server_capabilities.documentFormattingProvider then
  --   vim.keymap.set('n', '<leader>fa', function()
  --     vim.lsp.buf.format { async = true }
  --   end, opts("Format buffer"))

  --   -- vim.keymap.set('n', '<leader>fa', vim.lsp.buf.format("Format buffer"))

  --   -- vim.keymap.set("n", "<leader>fa", vim.lsp.buf.formatting())
  -- end

  -- if client.server_capabilities.documentRangeFormattingProvider then
  -- vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
  --   vim.keymap.set('v', '<leader>fn', vim.lsp.buf.range_formatting())
  -- end

  -- local function find(table, value)
  --   for _, v in ipairs(table) do
  --     if v == value then
  --       return true
  --     end
  --   end
  --   return false
  -- end

  -- if find(client.server_capabilities.codeActionProvider.codeActionKinds, "source.fixAll") then
  --   -- lua print(vim.inspect(vim.lsp.buf_get_clients(0)[1].server_capabilities))
  --   -- lua =vim.lsp.get_clients()[1].server_capabilities
  --   vim.api.nvim_create_autocmd("BufWritePre", {
  --     group = vim.api.nvim_create_augroup("FixAllCodeAction", { clear = true }),
  --     pattern = { "*" },
  --     callback = function()
  --       vim.lsp.buf.code_action(
  --         {
  --           context = {
  --             diagnostics = {},
  --             only = { "source.fixAll" },
  --             triggerKind = 1,
  --           },
  --           apply = true,
  --         },
  --         vim.api.nvim_get_current_buf(),
  --         {
  --           start = {
  --             line = vim.api.nvim_win_get_cursor(0)[1] - 1,
  --             character = 0,
  --           },
  --           ["end"] = {
  --             line = vim.api.nvim_win_get_cursor(0)[1],
  --             character = 0,
  --           },
  --         }
  --       )
  --     end,
  --   })
  -- end
end

return {
  capabilities = capabilities,
  flags = flags,
  handlers = handlers,
  on_attach = on_attach,
}
