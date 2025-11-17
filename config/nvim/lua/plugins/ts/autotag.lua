return {
  "windwp/nvim-ts-autotag",
  event = { "BufReadPost", "BufNewFile" },
  -- event = "LazyFile",
  opts = {
    aliases = {
      ["typescript"] = "html",
      ["htmlangular"] = "html",
    },
  },
  per_filetype = {
    ["typescript"] = {
      enable_close = true,
      enable_rename = true,
      enable_close_on_slash = true,
    },
    ["htmlangular"] = {
      enable_close = true,
      enable_rename = true,
      enable_close_on_slash = true,
    },
  },
}
