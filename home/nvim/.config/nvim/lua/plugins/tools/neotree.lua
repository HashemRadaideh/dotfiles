return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = { "Neotree" },
  keys = {
    {
      "<leader>ft",
      [[<cmd>Neotree toggle<cr>]],
      { noremap = true, silent = true, desc = "Explorer NeoTree (root dir)" },
    },
    {
      "<leader>fc",
      [[<cmd>Neotree toggle current<cr>]],
      { noremap = true, silent = true, desc = "Explorer NeoTree Current Buffer (root dir)" },
    },
    {
      "<leader>gt",
      [[<cmd>Neotree toggle git_status<CR>]],
      { noremap = true, silent = true, desc = "Git explorer" },
    },
    {
      "<leader>bt",
      [[<cmd>Neotree toggle buffers<CR>]],
      { noremap = true, silent = true, desc = "Buffer explorer" },
    },
    {
      "<leader>so",
      [[<cmd>Neotree toggle document_symbols<CR>]],
      { noremap = true, silent = true, desc = "Document_symbols explorer" },
    },
  },
  opts = {
    sources = {
      "filesystem",
      "buffers",
      "git_status",
      "document_symbols",
    },
    add_blank_line_at_top = false,
    auto_clean_after_session_restore = true,
    close_if_last_window = true,
    default_source = "filesystem",
    enable_diagnostics = true,
    enable_git_status = true,
    enable_modified_markers = true,
    enable_opened_markers = true,
    enable_refresh_on_write = true,
    enable_cursor_hijack = false,
    git_status_async = true,
    git_status_async_options = {
      batch_size = 1000,
      batch_delay = 100,
      max_lines = 10000,
    },
    hide_root_node = false,
    retain_hidden_root_indent = false,
    open_files_in_last_window = true,
    open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy" },
    open_files_using_relative_paths = false,
    -- popup_border_style is for input and confirmation dialogs.
    -- Configurtaion of floating window is done in the individual source sections.
    -- "NC" is a special style that works well with NormalNC set
    popup_border_style = "NC", -- "double", "none", "rounded", "shadow", "single" or "solid"
    resize_timer_interval = 200, -- in ms, needed for containers to redraw right aligned and faded content
    -- set to -1 to disable the resize timer entirely
    --                           -- NOTE: this will speed up to 50 ms for 1 second following a resize
    sort_case_insensitive = true, -- used when sorting files and directories in the tree
    use_popups_for_input = false, -- If false, inputs will use vim.ui.input() instead of custom floats.
    use_default_mappings = false,
    source_selector = {
      winbar = false,
      statusline = true,
      show_scrolled_off_parent_node = false, -- this will replace the tabs with the parent path of the top visible node when scrolled down.
      sources = {
        { source = "filesystem" },
        { source = "buffers" },
        { source = "git_status" },
        { source = "document_symbols" },
      },
      content_layout = "start", -- only with `tabs_layout` = "equal", "focus"
      tabs_layout = "equal", -- start, end, center, equal, focus
      truncation_character = "…", -- character to use when truncating the tab label
      padding = { left = 0, right = 0 },
      -- separator = { left = "▏", right = "▕" },
      separator = { left = "", right = "" },
      separator_active = "", -- set separators around the active tab. nil falls back to `source_selector.separator`
      show_separator_on_edge = false,
    },
    default_component_configs = {
      container = {
        enable_character_fade = true,
        width = "100%",
        right_padding = 0,
      },
      indent = {
        indent_size = 2,
        padding = 0,
        with_markers = true,
        indent_marker = "│",
        last_indent_marker = "└",
        highlight = "NeoTreeIndentMarker",
        with_expanders = false,
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "󰉖",
        folder_empty_open = "󰷏",
        -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
        -- then these will never be used.
        default = "*",
        highlight = "NeoTreeFileIcon",
        provider = function(icon, node, _state) -- default icon provider utilizes nvim-web-devicons if available
          if node.type == "file" or node.type == "terminal" then
            local success, web_devicons = pcall(require, "nvim-web-devicons")
            local name = node.type == "terminal" and "terminal" or node.name
            if success then
              local devicon, hl = web_devicons.get_icon(name)
              icon.text = devicon or icon.text
              icon.highlight = hl or icon.highlight
            end
          end
        end,
      },
      modified = {
        symbol = "●",
        highlight = "NeoTreeModified",
      },
      name = {
        trailing_slash = true,
        highlight_opened_files = true,
        use_git_status_colors = true,
        highlight = "NeoTreeFileName",
      },
      git_status = {
        symbols = {
          added = "✚",
          deleted = "✖",
          modified = "",
          renamed = "󰁕",
          untracked = "",
          ignored = "",
          unstaged = "󰄱",
          staged = "",
          conflict = "",
        },
        align = "right",
      },
      file_size = {
        enabled = true,
        width = 12,
        required_width = 64,
      },
      type = {
        enabled = true,
        width = 10,
        required_width = 110,
      },
      last_modified = {
        enabled = true,
        width = 20,
        required_width = 88,
        format = "%Y-%m-%d %I:%M %p",
        -- format = require("neo-tree.utils").relative_date,
      },
      created = {
        enabled = false,
        width = 20,
        required_width = 120,
        format = "%Y-%m-%d %I:%M %p",
        --format = require("neo-tree.utils").relative_date,
      },
      symlink_target = {
        enabled = false,
        text_format = " ➛ %s",
      },
    },
    renderers = {
      directory = {
        { "indent" },
        { "icon" },
        { "current_filter" },
        {
          "container",
          content = {
            { "name", zindex = 10 },
            {
              "symlink_target",
              zindex = 10,
              highlight = "NeoTreeSymbolicLinkTarget",
            },
            { "clipboard", zindex = 10 },
            {
              "diagnostics",
              errors_only = true,
              zindex = 20,
              align = "left",
              hide_when_expanded = false,
            },
            { "git_status", zindex = 10, align = "right", hide_when_expanded = false },
            { "file_size", zindex = 10, align = "right" },
            { "type", zindex = 10, align = "right" },
            { "last_modified", zindex = 10, align = "right" },
            { "created", zindex = 10, align = "right" },
          },
        },
      },
      file = {
        { "indent" },
        { "icon" },
        {
          "container",
          content = {
            {
              "name",
              zindex = 10,
            },
            {
              "symlink_target",
              zindex = 10,
              highlight = "NeoTreeSymbolicLinkTarget",
            },
            { "clipboard", zindex = 10 },
            { "bufnr", zindex = 10 },
            { "modified", zindex = 20, align = "left" },
            { "diagnostics", zindex = 20, align = "left" },
            { "git_status", zindex = 10, align = "right" },
            { "file_size", zindex = 10, align = "right" },
            { "type", zindex = 10, align = "right" },
            { "last_modified", zindex = 10, align = "right" },
            { "created", zindex = 10, align = "right" },
          },
        },
      },
      message = {
        { "indent", with_markers = false },
        { "name", highlight = "NeoTreeMessage" },
      },
      terminal = {
        { "indent" },
        { "icon" },
        { "name" },
        { "bufnr" },
      },
    },
    window = {
      position = "right",
      width = 20,
      auto_expand_width = true,
      popup = {
        size = {
          height = "80%",
          width = "50%",
        },
        position = "50%",
        title = function(state)
          return "Neo-tree " .. state.name:gsub("^%l", string.upper)
        end,
      },
      same_level = false,
      insert_as = "child",
      -- "child":   Insert nodes as children of the directory under cursor.
      -- "sibling": Insert nodes  as siblings of the directory under cursor.
      -- Mappings for tree window. See `:h neo-tree-mappings` for a list of built-in commands.
      -- You can also create your own commands by providing a function instead of a string.
      mapping_options = {
        noremap = true,
        nowait = true,
      },
      mappings = {
        ["<space>"] = {
          "toggle_node",
          nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
        },
        ["<2-LeftMouse>"] = "open",
        ["<cr>"] = { "open", config = { expand_nested_files = true } },
        ["<esc>"] = "cancel", -- close preview or floating neo-tree window
        ["P"] = {
          "toggle_preview",
          config = {
            use_float = true,
            use_image_nvim = false,
            -- title = "Neo-tree Preview", -- You can define a custom title for the preview floating window.
          },
        },
        ["<C-f>"] = { "scroll_preview", config = { direction = -10 } },
        ["<C-b>"] = { "scroll_preview", config = { direction = 10 } },
        ["l"] = "focus_preview",
        ["S"] = "open_split",
        -- ["S"] = "split_with_window_picker",
        ["s"] = "open_vsplit",
        -- ["sr"] = "open_rightbelow_vs",
        -- ["sl"] = "open_leftabove_vs",
        -- ["s"] = "vsplit_with_window_picker",
        ["t"] = "open_tabnew",
        -- ["<cr>"] = "open_drop",
        -- ["t"] = "open_tab_drop",
        ["w"] = "open_with_window_picker",
        ["C"] = "close_node",
        ["zR"] = "expand_all_nodes",
        ["zM"] = "close_all_nodes",
        ["zr"] = "expand_all_subnodes",
        ["zm"] = "close_all_subnodes",
        ["R"] = "refresh",
        ["a"] = {
          "add",
          -- some commands may take optional config options, see `:h neo-tree-mappings` for details
          config = {
            show_path = "none", -- "none", "relative", "absolute"
          },
        },
        ["A"] = "add_directory", -- also accepts the config.show_path and config.insert_as options.
        ["d"] = "delete",
        ["r"] = "rename",
        ["b"] = "rename_basename",
        ["y"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["c"] = "copy", -- takes text input for destination, also accepts the config.show_path and config.insert_as options
        ["m"] = "move", -- takes text input for destination, also accepts the config.show_path and config.insert_as options
        ["e"] = "toggle_auto_expand_width",
        ["q"] = "close_window",
        ["?"] = "show_help",
        ["<"] = "prev_source",
        [">"] = "next_source",
        ["<S-tab>"] = "prev_source",
        ["<tab>"] = "next_source",
      },
    },
    filesystem = {
      window = {
        mappings = {
          ["H"] = "toggle_hidden",
          ["/"] = "fuzzy_finder",
          ["D"] = "fuzzy_finder_directory",
          --["/"] = "filter_as_you_type", -- this was the default until v1.28
          ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
          -- ["D"] = "fuzzy_sorter_directory",
          ["f"] = "filter_on_submit",
          ["<C-x>"] = "clear_filter",
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
          ["[g"] = "prev_git_modified",
          ["]g"] = "next_git_modified",
          ["i"] = "show_file_details", -- see `:h neo-tree-file-actions` for options to customize the window.
          ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
          ["oc"] = { "order_by_created", nowait = false },
          ["od"] = { "order_by_diagnostics", nowait = false },
          ["og"] = { "order_by_git_status", nowait = false },
          ["om"] = { "order_by_modified", nowait = false },
          ["on"] = { "order_by_name", nowait = false },
          ["os"] = { "order_by_size", nowait = false },
          ["ot"] = { "order_by_type", nowait = false },
        },
        fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
          ["<down>"] = "move_cursor_down",
          ["<C-n>"] = "move_cursor_down",
          ["<up>"] = "move_cursor_up",
          ["<C-p>"] = "move_cursor_up",
          ["<esc>"] = "close",
        },
      },
      async_directory_scan = "auto", -- "auto"   means refreshes are async, but it's synchronous when called from the Neotree commands.
      -- "always" means directory scans are always async.
      -- "never"  means directory scans are never async.
      scan_mode = "shallow", -- "shallow": Don't scan into directories to detect possible empty directory a priori
      -- "shallow": Scan into directories to detect empty or grouped empty directories a priori.
      bind_to_cwd = true, -- true creates a 2-way binding between vim's cwd and neo-tree's root
      cwd_target = {
        sidebar = "tab", -- sidebar is when position = left or right
        current = "window", -- current is when position = current
      },
      check_gitignore_in_search = true, -- check gitignore status for files/directories when searching
      -- setting this to false will speed up searches, but gitignored
      -- items won't be marked if they are visible.
      -- The renderer section provides the renderers that will be used to render the tree.
      --   The first level is the node type.
      --   For each node type, you can specify a list of components to render.
      --       Components are rendered in the order they are specified.
      --         The first field in each component is the name of the function to call.
      --         The rest of the fields are passed to the function as the "config" argument.
      filtered_items = {
        visible = false,
        force_visible_in_empty_folder = false,
        show_hidden_count = false,
        hide_dotfiles = true,
        hide_gitignored = true,
        hide_hidden = true,
        hide_by_name = {
          ".DS_Store",
          "thumbs.db",
          "node_modules",
        },
        hide_by_pattern = {
          --"*.meta",
          --"*/src/*/tsconfig.json"
        },
        always_show = {
          -- remains visible even if other settings would normally hide it
          --".gitignored",
        },
        always_show_by_pattern = {
          -- uses glob style patterns
          --".env*",
        },
        never_show = {
          -- remains hidden even if visible is toggled to true, this overrides always_show
          --".DS_Store",
          --"thumbs.db"
        },
        never_show_by_pattern = {
          -- uses glob style patterns
          --".null-ls_*",
        },
      },
      find_by_full_path_words = true,
      group_empty_dirs = true,
      search_limit = 50,
      follow_current_file = {
        enabled = true,
        leave_dirs_open = true,
      },
      hijack_netrw_behavior = "disabled",
      use_libuv_file_watcher = true,
    },
    buffers = {
      bind_to_cwd = true,
      follow_current_file = {
        enabled = true,
        leave_dirs_open = true,
      },
      group_empty_dirs = true,
      show_unloaded = false,
      terminals_first = false,
      window = {
        position = "float",
        mappings = {
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
          ["bd"] = "buffer_delete",
          ["i"] = "show_file_details", -- see `:h neo-tree-file-actions` for options to customize the window.
          ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
          ["oc"] = { "order_by_created", nowait = false },
          ["od"] = { "order_by_diagnostics", nowait = false },
          ["om"] = { "order_by_modified", nowait = false },
          ["on"] = { "order_by_name", nowait = false },
          ["os"] = { "order_by_size", nowait = false },
          ["ot"] = { "order_by_type", nowait = false },
        },
      },
    },
    git_status = {
      window = {
        position = "float",
        mappings = {
          ["A"] = "git_add_all",
          ["gu"] = "git_unstage_file",
          ["ga"] = "git_add_file",
          ["gr"] = "git_revert_file",
          ["gc"] = "git_commit",
          ["gp"] = "git_push",
          ["gg"] = "git_commit_and_push",
          ["i"] = "show_file_details", -- see `:h neo-tree-file-actions` for options to customize the window.
          ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
          ["oc"] = { "order_by_created", nowait = false },
          ["od"] = { "order_by_diagnostics", nowait = false },
          ["om"] = { "order_by_modified", nowait = false },
          ["on"] = { "order_by_name", nowait = false },
          ["os"] = { "order_by_size", nowait = false },
          ["ot"] = { "order_by_type", nowait = false },
        },
      },
    },
    document_symbols = {
      follow_cursor = true,
      client_filters = "first",
      renderers = {
        root = {
          { "indent" },
          { "icon", default = "C" },
          { "name", zindex = 10 },
        },
        symbol = {
          { "indent", with_expanders = true },
          { "kind_icon", default = "?" },
          {
            "container",
            content = {
              { "name", zindex = 10 },
              { "kind_name", zindex = 20, align = "right" },
            },
          },
        },
      },
      window = {
        mappings = {
          ["<cr>"] = "jump_to_symbol",
          ["o"] = "jump_to_symbol",
          ["A"] = "noop", -- also accepts the config.show_path and config.insert_as options.
          ["d"] = "noop",
          ["y"] = "noop",
          ["x"] = "noop",
          ["p"] = "noop",
          ["c"] = "noop",
          ["m"] = "noop",
          ["a"] = "noop",
          ["/"] = "filter",
          ["f"] = "filter_on_submit",
        },
      },
      kinds = {
        Unknown = { icon = "?", hl = "" },
        Root = { icon = "", hl = "NeoTreeRootName" },
        File = { icon = "󰈙", hl = "Tag" },
        Module = { icon = "", hl = "Exception" },
        Namespace = { icon = "󰌗", hl = "Include" },
        Package = { icon = "󰏖", hl = "Label" },
        Class = { icon = "󰌗", hl = "Include" },
        Method = { icon = "", hl = "Function" },
        Property = { icon = "󰆧", hl = "@property" },
        Field = { icon = "", hl = "@field" },
        Constructor = { icon = "", hl = "@constructor" },
        Enum = { icon = "󰒻", hl = "@number" },
        Interface = { icon = "", hl = "Type" },
        Function = { icon = "󰊕", hl = "Function" },
        Variable = { icon = "", hl = "@variable" },
        Constant = { icon = "", hl = "Constant" },
        String = { icon = "󰀬", hl = "String" },
        Number = { icon = "󰎠", hl = "Number" },
        Boolean = { icon = "", hl = "Boolean" },
        Array = { icon = "󰅪", hl = "Type" },
        Object = { icon = "󰅩", hl = "Type" },
        Key = { icon = "󰌋", hl = "" },
        Null = { icon = "", hl = "Constant" },
        EnumMember = { icon = "", hl = "Number" },
        Struct = { icon = "󰌗", hl = "Type" },
        Event = { icon = "", hl = "Constant" },
        Operator = { icon = "󰆕", hl = "Operator" },
        TypeParameter = { icon = "󰊄", hl = "Type" },
      },
    },
  },
}
