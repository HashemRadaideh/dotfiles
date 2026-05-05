return {
  "Bekaboo/dropbar.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    icons = {
      ui = {
        bar = {
          separator = "  ",
          extends = "…",
        },
        menu = {
          separator = "┃",
          indicator = " ",
        },
      },
    },
  },
  config = function(_, opts)
    require("dropbar").setup(opts)

    local dropbar_api = require("dropbar.api")
    vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
    vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
    vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })

    vim.api.nvim_set_hl(0, "DropBarKindDir", { link = "Conceal" })
  end,
}
