require("utils.mason_ensure").ensure({
  "gopls",
  "gofumpt",
  "revive",
  "staticcheck",
  "delve",
  "gomodifytags",
  "gotests",
  "impl",
  "json-to-struct",
})

local config = vim.fn.findfile("revive.toml", ".;")
require("lint").linters.revive.args = config == "" and { "-formatter", "json", "./..." }
  or {
    "-config",
    vim.fn.fnamemodify(type(config) ~= "table" and config or config[1], ":p"),
    "-formatter",
    "json",
    "./...",
  }

