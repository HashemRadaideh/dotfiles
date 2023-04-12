local present, impatient = pcall(require, "impatient")

if present then
  impatient.enable_profile()
end

-- local path = debug.getinfo(1).short_src

-- _, _, Path = string.find(path, "(.*nvim-new)")
Path = "~/.config/nvim-new/"

-- TODO: get username from system
Username = "Hashem" -- NOTE: this is not the best solution, but it works for now

Shade = true

require('configs')
require('plugins')
