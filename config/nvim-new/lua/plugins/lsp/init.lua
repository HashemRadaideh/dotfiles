local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
  return
end

-- require('neodev').setup()
require("plugins.lsp.configs.mason")
require("plugins.lsp.configs.nullls")
require("plugins.lsp.configs.cmp")

local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities.textDocument.completion.completionItem.resolveSupport = {
--   properties = { "documentation", "detail", "additionalTextEdits" },
-- }

local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true }
  local buf_map = vim.api.nvim_buf_set_keymap
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  buf_map(bufnr, "n", "gD", ":lua vim.lsp.buf.declaration()<CR>", opts)
  buf_map(bufnr, "n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
  buf_map(bufnr, "n", "K", ":lua vim.lsp.buf.hover()<CR>", opts)
  buf_map(bufnr, "n", "gi", ":lua vim.lsp.buf.implementation()<CR>", opts)
  buf_map(bufnr, "n", "<C-;>", ":lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_map(bufnr, "n", "<leader>wa", ":lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_map(bufnr, "n", "<leader>wr", ":lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_map(bufnr, "n", "<leader>wl", ":lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  buf_map(bufnr, "n", "<leader>D", ":lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_map(bufnr, "n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>", opts)
  buf_map(bufnr, "n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", opts)
  buf_map(bufnr, "n", "gr", ":lua vim.lsp.buf.references()<CR>", opts)
  buf_map(bufnr, "n", "<leader>fn", ":lua vim.lsp.buf.formatting()<CR>", opts)

  -- Prioritize null-ls formatting over native lsp formatting.
  local method = require("null-ls").methods.FORMATTING

  local function has_formatter(filetype)
    local available = require "null-ls.sources".get_available(filetype, method)
    return #available > 0
  end

  local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

  local enable = false
  if has_formatter(filetype) then
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

  -- -- codelens
  -- if client.server_capabilities.code_lens then
  --   vim.api.nvim_command [[autocmd CursorHold,CursorHoldI,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]]
  --   vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cl", "<Cmd>lua vim.lsp.codelens.run()<CR>", { silent = true, })
  -- end

  -- if client.server_capabilities.document_highlight then
  --   -- vim.cmd [[
  --   --     hi! LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
  --   --     hi! LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
  --   --     hi! LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
  --   -- ]]
  --   vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true, })
  --   vim.api.nvim_clear_autocmds({
  --     buffer = bufnr,
  --     group = "lsp_document_highlight",
  --   })
  --   vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  --     group = "lsp_document_highlight",
  --     buffer = bufnr,
  --     callback = vim.lsp.buf.document_highlight,
  --   })
  --   vim.api.nvim_create_autocmd("CursorMoved", {
  --     group = "lsp_document_highlight",
  --     buffer = bufnr,
  --     callback = vim.lsp.buf.clear_references,
  --   })
  -- end

  -- vim.api.nvim_create_autocmd("CursorHold", {
  --   buffer = bufnr,
  --   callback = function()
  --     local optns = {
  --       focusable = false,
  --       close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
  --       border = "rounded",
  --       source = "always",
  --       prefix = " ",
  --       scope = "cursor",
  --     }
  --     vim.diagnostic.open_float(nil, optns)
  --   end
  -- })
end

-- local function goto_definition(split_cmd)
--   local util = vim.lsp.util
--   local log = require("vim.lsp.log")
--   local api = vim.api

--   -- note, this handler style is for neovim 0.5.1/0.6, if on 0.5, call with function(_, method, result)
--   local handler = function(_, result, ctx)
--     if result == nil or vim.tbl_isempty(result) then
--       local _ = log.info() and log.info(ctx.method, "No location found")
--       return nil
--     end

--     if split_cmd then
--       vim.cmd(split_cmd)
--     end

--     if vim.tbl_islist(result) then
--       util.jump_to_location(result[1])

--       if #result > 1 then
--         util.set_qflist(util.locations_to_items(result))
--         api.nvim_command("copen")
--         api.nvim_command("wincmd p")
--       end
--     else
--       util.jump_to_location(result)
--     end
--   end

--   return handler
-- end

-- local border = {
--   { "", "FloatBorder" },
--   { "", "FloatBorder" },
--   { "", "FloatBorder" },
--   { "", "FloatBorder" },
--   { "", "FloatBorder" },
--   { "", "FloatBorder" },
--   { "", "FloatBorder" },
--   { "", "FloatBorder" },
-- }

-- local handlers = {
--   ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
--   ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
--   ["textDocument/publishDiagnostics"] = vim.lsp.with(
--     vim.lsp.diagnostic.on_publish_diagnostics,
--     {
--       underline = true,
--       signs = true,
--       update_in_insert = true,
--       virtual_text = {
--         spacing = 5,
--         severity_limit = "Warning",
--       },
--     }),
--   ["textDocument/definition"] = goto_definition("vsplit")
-- }

local flags = { debounce_text_changes = 150 }

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  -- handlers = handlers,
  flags = flags,
  settings = {
    Lua = {
      workspace = { checkThirdParty = false },
      runtime = {
        version = 'LuaJIT',
        -- path = runtime_path,
      },
      completion = {
        callSnippet = 'Replace',
      },
      diagnostics = {
        enable = true,
        globals = { 'vim', 'use' },
      },
      -- workspace = {
      --   library = vim.api.nvim_get_runtime_file('', true),
      --   maxPreload = 10000,
      --   preloadFileSize = 10000,
      -- },
      telemetry = { enable = false },
      -- telemetry = { enable = true },
    },
  },
}

lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  -- handlers = handlers,
  flags = flags,
  settings = {
    ['rust-analyzer'] = {},
  },
}

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  -- handlers = handlers,
  flags = flags,
}

lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  -- handlers = handlers,
  flags = flags,
}

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  -- handlers = handlers,
  flags = flags,
}

lspconfig.clangd.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  -- handlers = handlers,
  flags = flags,
}

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-----@diagnostic disable-next-line: unused-function, unused-local
--local function PrintDiagnostics(opts, bufnr, line_nr, client_id)
--  bufnr = bufnr or 0
--  line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
--  opts = opts or { ["lnum"] = line_nr }

--  local line_diagnostics = vim.diagnostic.get(bufnr, opts)
--  if vim.tbl_isempty(line_diagnostics) then return end

--  local diagnostic_message = ""
--  for i, diagnostic in ipairs(line_diagnostics) do
--    diagnostic_message = diagnostic_message .. string.format("%d: %s", i, diagnostic.message or "")
--    print(diagnostic_message)
--    if i ~= #line_diagnostics then
--      diagnostic_message = diagnostic_message .. "\n"
--    end
--  end
--  vim.api.nvim_echo({ { diagnostic_message, "Normal" } }, false, {})
--end

-- -- vim.cmd [[ autocmd! CursorHold,CursorHoldI * lua PrintDiagnostics() ]]
-- vim.cmd [[ autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"}) ]]

-- vim.cmd [[
--   highlight! DiagnosticLineNrError guibg=#51202A guifg=#FF0000 gui=bold
--   highlight! DiagnosticLineNrWarn guibg=#51412A guifg=#FFA500 gui=bold
--   highlight! DiagnosticLineNrInfo guibg=#1E535D guifg=#00FFFF gui=bold
--   highlight! DiagnosticLineNrHint guibg=#1E205D guifg=#0000FF gui=bold

--   sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticLineNrError
--   sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticLineNrWarn
--   sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticLineNrInfo
--   sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticLineNrHint
-- ]]

-- vim.cmd [[ autocmd! Colorscheme * highlight NormalFloat guibg=#1f2335 ]]
-- vim.cmd [[ autocmd! Colorscheme * highlight FloatBorder guibg=#1f2335 guifg=#ffffff ]]

-- vim.diagnostic.config({
--   virtual_text = {
--     source = "always", -- Or "if_many"
--     prefix = "■",    -- Could be "●", "▎", "x"
--   },
--   float = {
--     source = "always", -- Or "if_many"
--     show_header = true,
--     border = 'rounded',
--     focusable = false,
--   },
--   signs = true,
--   underline = true,
--   update_in_insert = true,
--   severity_sort = false,
-- })
