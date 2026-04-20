return {
  "LiadOz/nvim-dap-repl-highlights",
  dependency = {
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("nvim-dap-repl-highlights").setup()
    require("nvim-treesitter").install({ "dap_repl" })
  end,
}
