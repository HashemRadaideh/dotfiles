return {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = "MCPHub",
  build = "npm install -g mcp-hub@latest",
  opts = {
    shutdown_delay = 0,
    extensions = {
      avante = {
        make_slash_commands = true,
      },
    },
    auto_approve = function(params)
      if params.server_name == "github" and params.tool_name == "get_issue" then
        return true -- Auto approve
      end

      if params.arguments.repo == "private" then
        return "You can't access my private repo"
      end

      if params.tool_name == "read_file" then
        local path = params.arguments.path or ""
        if path:match("^" .. vim.fn.getcwd()) then
          return true -- Auto approve
        end
      end

      if params.is_auto_approved_in_server then
        return true
      end

      return false
    end,
  },
  keys = {
    {
      "<leader>mc",
      "<cmd>MCPHub<CR>",
      { noremap = true, silent = true },
    },
  },
}