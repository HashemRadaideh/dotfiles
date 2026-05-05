return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost" },
  config = require("plugins.core.lint.config"),
}