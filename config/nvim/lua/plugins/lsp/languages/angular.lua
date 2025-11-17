local config = require("plugins.lsp.config")

vim.lsp.config("angularls", {
  capabilities = config.capabilities,
  flags = config.flags,
  handlers = config.handlers,
  on_attach = config.on_attach,
  -- filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "htmlangular" },
})
vim.lsp.enable("angularls")

-- vim.filetype.add({
--   pattern = {
--     [".*%.component%.html"] = "htmlangular",
--   },
-- })

local ng = require("ng")

vim.keymap.set(
  "n",
  "<leader>at",
  ng.goto_template_for_component,
  { noremap = true, silent = true, desc = "go to template for component" }
)

vim.keymap.set(
  "n",
  "<leader>ac",
  ng.goto_component_with_template_file,
  { noremap = true, silent = true, desc = "go to component with template file" }
)

vim.keymap.set(
  "n",
  "<leader>aT",
  ng.get_template_tcb,
  { noremap = true, silent = true, desc = "get the template's tcb" }
)

-- vim.treesitter.query.set(
--   "typescript",
--   "injections",
--   [[
--     ((pair
--         key: (property_identifier) @key (#eq? @key "template")
--         value: (template_string) @html) @injection.content
--       (#offset! @injection.content 0 1 0 -1)
--       (#set! injection.include-children)
--       (#set! injection.combined)
--       (#set! injection.language "html"))

--     ((pair
--       key: (property_identifier) @key (#eq? @key "styles")
--       value: (array (template_string) @css)) @injection.content
--       (#offset! @injection.content 0 1 0 -1)
--       (#set! injection.include-children)
--       (#set! injection.combined)
--       (#set! injection.language "css"))

--     ((pair
--       key: (property_identifier) @key (#eq? @key "styles")
--       value: (template_string) @css) @injection.content
--       (#offset! @injection.content 0 1 0 -1)
--       (#set! injection.include-children)
--       (#set! injection.combined)
--       (#set! injection.language "scss"))
--   ]]
-- )
