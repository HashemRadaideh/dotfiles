return {
  "vuki656/package-info.nvim",
  event = { "BufReadPost", "BufNewFile" },
  ft = "json",
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {
    autostart = true,
    package_manager = "yarn",
    colors = {
      outdated = "#db4b4b",
    },
    hide_up_to_date = true,
  },
}
