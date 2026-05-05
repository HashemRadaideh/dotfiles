vim.filetype.add({
  extension = {
    ["http"] = "http",
  },
})

vim.treesitter.language.register("json", "kulala-json")
vim.treesitter.language.register("xml", "kulala-xml")
vim.treesitter.language.register("html", "kulala-html")

return {
  "mistweaverco/kulala.nvim",
  keys = {
    { "<leader>rs", "<cmd>lua require('kulala').run()<cr>", desc = "Send request" },
    { "<leader>ra", "<cmd>lua require('kulala').inspect()<cr>", desc = "Insepct request" },
    { "<leader>ro", "<cmd>lua require('kulala').scratchpad()<cr>", desc = "Open kulala" },
  },
  ft = { "http", "rest" },
  opts = {
    contenttypes = {
      ["application/json"] = { ft = "kulala-json" },
      ["application/xml"] = { ft = "kulala-xml" },
      ["text/html"] = { ft = "kulala-html" },
    },
    default_view = "headers_body",
  },
}
