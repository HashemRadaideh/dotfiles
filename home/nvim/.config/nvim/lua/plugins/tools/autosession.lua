return {
  "rmagatti/auto-session",
  lazy = false,
  cond = not vim.g.vscode,
  keys = {
    {
      "<leader>ss",
      "<cmd>AutoSession search<cr>",
      desc = "Search for session",
    },
    {
      "<leader>sd",
      "<cmd>AutoSession deletePicker<cr>",
      desc = "Delete a session",
    },
  },
  opts = {
    git_use_branch_name = true,
    git_auto_restore_on_branch_change = true,
    suppressed_dirs = { "~/", "~/Downloads", "/" },
    bypass_save_filetypes = { "alpha", "neo-tree" },
    session_lens = {
      mappings = {
        delete_session = { "i", "<C-d>" },
        alternate_session = { "i", "<C-s>" },
        copy_session = { "i", "<C-y>" },
      },
    },
    pre_save_cmds = {
      function()
        vim.cmd([[Neotree close]])
      end,
    },
    save_extra_data = function(_)
      local ok, breakpoints = pcall(require, "dap.breakpoints")
      if not ok or not breakpoints then
        return
      end

      local bps = {}
      local breakpoints_by_buf = breakpoints.get()
      for buf, buf_bps in pairs(breakpoints_by_buf) do
        bps[vim.api.nvim_buf_get_name(buf)] = buf_bps
      end
      if vim.tbl_isempty(bps) then
        return
      end
      local extra_data = {
        breakpoints = bps,
      }
      return vim.fn.json_encode(extra_data)
    end,
    restore_extra_data = function(_, extra_data)
      local json = vim.fn.json_decode(extra_data)

      if json.breakpoints then
        local ok, breakpoints = pcall(require, "dap.breakpoints")

        if not ok or not breakpoints then
          return
        end

        for buf_name, buf_bps in pairs(json.breakpoints) do
          for _, bp in pairs(buf_bps) do
            local line = bp.line
            local opts = {
              condition = bp.condition,
              log_message = bp.logMessage,
              hit_condition = bp.hitCondition,
            }

            local bufnr = vim.fn.bufnr(buf_name, true)
            if vim.fn.bufloaded(bufnr) == 0 then
              vim.api.nvim_buf_call(bufnr, vim.cmd.edit)
            end

            breakpoints.set(opts, bufnr, line)
          end
        end
      end
    end,
  },
}