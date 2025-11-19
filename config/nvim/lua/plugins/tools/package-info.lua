return {
  "vuki656/package-info.nvim",
  event = { "BufReadPost", "BufNewFile" },
  ft = "json",
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {
    autostart = true,
    package_manager = "bun",
    hide_up_to_date = true,
    highlight = {
      outdated = {
        fg = "#db4b4b",
      },
    },
  },
}
