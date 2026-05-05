-- Full tool list — not loaded at startup.
-- Use :MasonToolsInstall to install everything at once,
-- or open a file of that type to install per-language tools lazily.
return vim
  .iter({
    -- require("ensure_installed.lsps"),
    -- require("ensure_installed.daps"),
    -- require("ensure_installed.formatters"),
    -- require("ensure_installed.linters"),
    -- require("ensure_installed.codegen"),
    require("ensure_installed.generic"),
  })
  :flatten()
  :totable()
