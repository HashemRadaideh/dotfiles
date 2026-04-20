vim.filetype.add({
  pattern = {
    [".*/hypr/.*%.conf"] = "hyprlang",
    ["hypr*.conf"] = "hyprlang",
    [".*%.hl"] = "hyprlang",
  },
})

return {
  name = "hyprlang",
  cmd = { "hyprls" },
  root_dir = vim.fn.getcwd(),
  settings = {
    hyprls = {
      preferIgnoreFile = true,
      ignore = { "hyprlock.conf", "hypridle.conf" }
    }
  }
}
