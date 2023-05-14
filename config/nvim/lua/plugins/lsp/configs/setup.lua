vim.diagnostic.config({
  virtual_text = {
    source = "always", -- Or "if_many"
    prefix = "■",   -- Could be "●", "▎", "x"
  },
  float = {
    source = "always", -- Or "if_many"
    show_header = true,
    border = 'rounded',
    focusable = false,
  },
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = false,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
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
  ["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
      underline = true,
      signs = true,
      update_in_insert = true,
      virtual_text = {
        spacing = 5,
        severity_limit = "Warning",
      },
    }),
  ["textDocument/definition"] = goto_definition("vsplit"),
}

local on_attach = function(client, bufnr)
  -- Prioritize null-ls formatting over native lsp formatting.
  local function has_formatter(filetype)
    local available = require "null-ls.sources".get_available(filetype, require("null-ls").methods.FORMATTING)
    return #available > 0
  end

  local enable = false
  if has_formatter(vim.api.nvim_buf_get_option(bufnr, "filetype")) then
    enable = client.name == "null-ls"
  else
    enable = not (client.name == "null-ls")
  end

  client.server_capabilities.document_formatting = enable
  client.server_capabilities.document_range_formatting = enable

  -- Auto-formatting
  if client.server_capabilities.document_formatting then
    vim.api.nvim_command [[ augroup Format ]]
    vim.api.nvim_command [[ autocmd! * <buffer> ]]
    vim.api.nvim_command [[ autocmd BufWritePre <buffer> lua vim.lsp.buf.format() ]]
    vim.api.nvim_command [[ augroup END ]]
  end

  -- codelens
  if client.server_capabilities.code_lens then
    vim.api.nvim_command [[autocmd CursorHold,CursorHoldI,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]]
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cl", "<Cmd>lua vim.lsp.codelens.run()<CR>", { silent = true, })
  end

  -- inlay hints
  if client.server_capabilities.inlayHintProvider then
    -- require("inlay-hints").on_attach(client, bufnr)
    require("lsp-inlayhints").on_attach(client, bufnr)
  end

  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end

  require("lsp_signature").on_attach({
    bind = true,
    padding = '',
    handler_opts = {
      border = "rounded"
    }
  }, bufnr)

  require("illuminate").on_attach(client)

  vim.g.Illuminate_ftblacklist = { "neo-tree", }

  vim.cmd([[
        augroup illuminate_augroup
            autocmd!
            autocmd VimEnter * hi illuminatedWord cterm=underline gui=underline
        augroup END
    ]])

  vim.api.nvim_command [[ hi def link LspReferenceText CursorLine ]]
  vim.api.nvim_command [[ hi def link LspReferenceWrite CursorLine ]]
  vim.api.nvim_command [[ hi def link LspReferenceRead CursorLine ]]

  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      vim.diagnostic.open_float(nil, {
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      })
    end
  })

  -- Enable completion triggered by <c-x><c-o>
  vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

  local opts = function(hint)
    return { buffer = bufnr, silent = true, desc = hint }
  end

  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace"))
  vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace"))
  vim.keymap.set("n", "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
    opts("List workspace folders"))
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts("Project wild rename"))
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts("Add diagnostics to the location list"))
  vim.keymap.set('n', '<leader>pd', vim.diagnostic.open_float, opts("Show diagnostics"))
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts("Go to previous diagnostic"))
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts("Go to next diagnostic"))
  vim.keymap.set('n', 'gk', vim.diagnostic.goto_prev, opts("Go to previous diagnostic"))
  vim.keymap.set('n', 'gj', vim.diagnostic.goto_next, opts("Go to next diagnostic"))
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts("Perform code action"))
  vim.keymap.set('v', '<leader>ca', vim.lsp.buf.range_code_action, opts("Perform code action"))

  if client.server_capabilities.declarationProvider then
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration("Go to declaration"))
  end

  if client.server_capabilities.definitionProvider then
    vim.api.nvim_buf_set_option(bufnr, 'tagfunc', 'v:lua.vim.lsp.tagfunc')
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition("Go to definition"))
  end

  if client.server_capabilities.typeDefinitionProvider then
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition("Go to type definition"))
  end

  if client.server_capabilities.hoverProvider then
    vim.keymap.set('n', 'K', vim.lsp.buf.hover("LSP hover"))
  end

  if client.server_capabilities.implementationProvider then
    -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation("Go to implementation"))
    vim.keymap.set("n", "gi", require('telescope.builtin').lsp_implementations())
  end

  if client.server_capabilities.signatureHelpProvider then
    vim.keymap.set('n', '<leader>sa', vim.lsp.buf.signature_help("Show signature help"))
  end

  if client.server_capabilities.referencesProvider then
    -- vim.keymap.set('n', 'gr', vim.lsp.buf.references("Go to references"))
    vim.keymap.set("n", "gr", require('telescope.builtin').lsp_references())
  end

  if client.server_capabilities.documentFormattingProvider then
    vim.keymap.set('n', '<leader>fa', function()
      vim.lsp.buf.format { async = true }
    end, opts("Format buffer"))

    -- vim.keymap.set('n', '<leader>fa', vim.lsp.buf.format("Format buffer"))

    -- vim.keymap.set("n", "<leader>fa", vim.lsp.buf.formatting())
  end

  if client.server_capabilities.documentRangeFormattingProvider then
    vim.api.nvim_buf_set_option(bufnr, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')
    vim.keymap.set('v', '<leader>fn', vim.lsp.buf.range_formatting("Format range"))
  end
end

return {
  capabilities = capabilities,
  flags = flags,
  handlers = handlers,
  on_attach = on_attach,
}
