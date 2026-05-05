function _G.get_oil_winbar()
  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  local dir = require("oil").get_current_dir(bufnr)

  local current_dir = nil

  if dir then
    current_dir = vim.fn.fnamemodify(dir, ":~")
  else
    current_dir = vim.api.nvim_buf_get_name(0)
  end

  if not current_dir then
    return ""
  end

  if current_dir:sub(-1) == "/" then
    current_dir = current_dir:sub(1, -2)
  end

  local parent_dir, folder_name = current_dir:match("^(.*/)(.*)")

  local prefix = "%#String#" .. os.getenv("USER") .. "@" .. vim.fn.hostname() .. ":%#Directory#"

  if not parent_dir then
    return prefix .. current_dir
  end

  return prefix .. parent_dir .. "%#Normal#" .. folder_name
end

local function parse_output(proc)
  local result = proc:wait()
  local ret = {}
  if result.code == 0 then
    for line in vim.gsplit(result.stdout, "\n", { plain = true, trimempty = true }) do
      line = line:gsub("/$", "")
      ret[line] = true
    end
  end
  return ret
end

local function new_git_status()
  return setmetatable({}, {
    __index = function(self, key)
      local ignore_proc = vim.system(
        { "git", "ls-files", "--ignored", "--exclude-standard", "--others", "--directory" },
        {
          cwd = key,
          text = true,
        }
      )
      local tracked_proc = vim.system({ "git", "ls-tree", "HEAD", "--name-only" }, {
        cwd = key,
        text = true,
      })
      local ret = {
        ignored = parse_output(ignore_proc),
        tracked = parse_output(tracked_proc),
      }

      rawset(self, key, ret)
      return ret
    end,
  })
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",
  once = true,
  callback = function()
    _G.git_status = new_git_status()
    local refresh = require("oil.actions").refresh
    local orig_refresh = refresh.callback
    refresh.callback = function(...)
      _G.git_status = new_git_status()
      orig_refresh(...)
    end
  end,
})

return {
  "stevearc/oil.nvim",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    {
      "benomahony/oil-git.nvim",
      dependencies = { "stevearc/oil.nvim" },
      ft = { "oil" },
    },
    {
      "JezerM/oil-lsp-diagnostics.nvim",
      dependencies = { "stevearc/oil.nvim" },
      ft = { "oil" },
      opts = {},
    },
  },
  cmd = { "Oil" },
  keys = {
    {
      "<leader>fe",
      [[<cmd>Oil<cr>]],
      { noremap = true, silent = true, desc = "Open oil explorer" },
    },
    {
      "<leader>fo",
      [[<cmd>Oil --float<cr>]],
      { noremap = true, silent = true, desc = "Open oil explorer" },
    },
  },
  opts = {
    default_file_explorer = true,
    columns = {
      "permissions",
      "size",
      "mtime",
      "icon",
    },
    win_options = {
      cursorline = true,
      winbar = "%!v:lua.get_oil_winbar()",
    },
    delete_to_trash = true,
    skip_confirm_for_simple_edits = false,
    prompt_save_on_select_new_entry = true,
    cleanup_delay_ms = 200,
    lsp_file_methods = {
      timeout_ms = 2000,
      autosave_changes = true,
    },
    constrain_cursor = "name",
    experimental_watch_for_changes = true,
    keymaps = {
      ["g?"] = "actions.show_help",
      ["q"] = "actions.close",
      ["<esc><esc>"] = "actions.close",
      ["H"] = "actions.parent",
      ["J"] = "actions.preview_scroll_down",
      ["K"] = "actions.preview_scroll_up",
      ["L"] = "actions.select",
      ["<CR>"] = "actions.select",
      ["_"] = "actions.select_split",
      ["|"] = "actions.select_vsplit",
      ["<C-l>"] = "actions.refresh",
      ["<C-h>"] = "actions.toggle_hidden",
      ["<C-p>"] = "actions.preview",
      ["gs"] = "actions.change_sort",
      ["gx"] = "actions.open_external",
      ["g\\"] = "actions.toggle_trash",
      ["<C-t>"] = "actions.select_tab",
      -- ["_"] = "actions.open_cwd",
      -- ["`"] = "actions.cd",
      -- ["~"] = "actions.tcd",
    },
    use_default_keymaps = false,
    view_options = {
      show_hidden = false,
      is_hidden_file = function(name, bufnr)
        local dir = require("oil").get_current_dir(bufnr)
        local is_dotfile = vim.startswith(name, ".") -- and name ~= ".."
        if not dir then
          return is_dotfile
        end
        -- if is_dotfile then
        -- 	return not _G.git_status[dir].tracked[name]
        -- else
        return _G.git_status[dir].ignored[name] or is_dotfile
        -- end
      end,
      natural_order = false,
    },
    float = {
      padding = 0,
      max_width = 80,
      max_height = 0.5,
      border = "rounded",
      win_options = {
        winblend = 0,
      },
      get_win_title = function(_winid)
        return "Oil"
      end,
      -- preview_split: Split direction: "auto", "left", "right", "above", "below".
      preview_split = "auto",
    },
    preview_win = {
      update_on_cursor_moved = true,
      -- How to open the preview window "load"|"scratch"|"fast_scratch"
      preview_method = "fast_scratch",
      win_options = {},
    },
    confirmation = {
      -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
      -- min_width and max_width can be a single value or a list of mixed integer/float types.
      -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
      max_width = 0.9,
      -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
      min_width = { 40, 0.4 },
      max_height = 0.9,
      min_height = { 5, 0.1 },
      border = "rounded",
      win_options = {
        winblend = 0,
      },
    },
    progress = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      width = nil,
      max_height = { 10, 0.9 },
      min_height = { 5, 0.1 },
      height = nil,
      border = "rounded",
      minimized_border = "none",
      win_options = {
        winblend = 0,
      },
    },
  },
}
