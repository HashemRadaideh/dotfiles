return {
  "joeveiga/ng.nvim",
  keys = {
    {
      "<leader>at",
      '<cmd>lua require("ng").goto_template_for_component()<cr>',
      { noremap = true, silent = true, desc = "go to template for component" }
    },
    {
      "<leader>ac",
      '<cmd>lua require("ng").goto_component_with_template_file()<cr>',
      { noremap = true, silent = true, desc = "go to component with template file" }
    },
    {
      "<leader>aT",
      '<cmd>lua require("ng").get_template_tcb()<cr>',
      { noremap = true, silent = true, desc = "get the template's tcb" }
    }
  },
}
