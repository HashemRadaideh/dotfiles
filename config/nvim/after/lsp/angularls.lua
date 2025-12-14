-- vim.filetype.add({
--   pattern = {
--     [".*%.component%.html"] = "htmlangular",
--   },
-- })

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

return {
  -- filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "htmlangular" },
}
