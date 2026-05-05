return {
  "goolord/alpha-nvim",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local ok, alpha = pcall(require, "alpha")
    if not ok then
      return
    end

    local function get_info()
      local stats = require("lazy").stats()
      local plugins = stats.count
      local loaded = stats.loaded
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      local v = vim.version()
      return ("nvim v%d.%d.%d on %s loaded %d of %d plugins in %dms"):format(
        v.major,
        v.minor,
        v.patch,
        vim.fn.has("win32") == 1 and "" or "",
        loaded,
        plugins,
        ms
      )
    end

    local function button(sc, txt, keybind, keybind_opts)
      local b = require("alpha.themes.dashboard").button(sc, txt, keybind, keybind_opts)
      b.opts.hl = "Function"
      b.opts.hl_shortcut = "Keyword"
      b.opts.cursor = 26
      return b
    end

    alpha.setup({
      layout = {
        { type = "padding", val = 9 },
        {
          type = "text",
          val = {
            -- http://patorjk.com/software/taag/#p=display&f=Graffiti&t=Type%20Something%20
            -- NScript
            -- [[                                                gg                     ]],
            -- [[                                                ""                     ]],
            -- [[ ,ggg,,ggg,    ,ggg,     ,ggggg,   ggg    gg    gg    ,ggg,,ggg,,ggg,  ]],
            -- [[,8" "8P" "8,  i8" "8i   dP"  "Y8ggg8"Yb   88bg  88   ,8" "8P" "8P" "8, ]],
            -- [[     8I   8I  I8, ,8I  i8'    ,8I    I8   8I    88   I8   8I   8I   8I ]],
            -- [[     8I   Yb, `YbadP' ,d8,   ,d8'    I8, ,8I  _,88,_,dP   8I   8I   Yb,]],
            -- [[     8I   `Y8888P"Y888P"Y8888P"       "Y8P"   8P""Y88P'   8I   8I   `Y8]],

            [[  _   _ ______ ______      _______ __  __ ]],
            [[ | \ | |  ____/ __ \ \    / /_   _|  \/  |]],
            [[ |  \| | |__ | |  | \ \  / /  | | | \  / |]],
            [[ | . ` |  __|| |  | |\ \/ /   | | | |\/| |]],
            [[ | |\  | |___| |__| | \  /   _| |_| |  | |]],
            [[ |_| \_|______\____/   \/   |_____|_|  |_|]],

            -- [[⢸⠉⣹⠋⠉⢉⡟⢩⢋⠋⣽⡻⠭⢽⢉⠯⠭⠭⠭⢽⡍⢹⡍⠙⣯⠉⠉⠉⠉⠉⣿⢫⠉⠉⠉⢉⡟⠉⢿⢹⠉⢉⣉⢿⡝⡉⢩⢿⣻⢍⠉⠉⠩⢹⣟⡏⠉⠹⡉⢻⡍⡇]],
            -- [[⢸⢠⢹⠀⠀⢸⠁⣼⠀⣼⡝⠀⠀⢸⠘⠀⠀⠀⠀⠈⢿⠀⡟⡄⠹⣣⠀⠀⠐⠀⢸⡘⡄⣤⠀⡼⠁⠀⢺⡘⠉⠀⠀⠀⠫⣪⣌⡌⢳⡻⣦⠀⠀⢃⡽⡼⡀⠀⢣⢸⠸⡇]],
            -- [[⢸⡸⢸⠀⠀⣿⠀⣇⢠⡿⠀⠀⠀⠸⡇⠀⠀⠀⠀⠀⠘⢇⠸⠘⡀⠻⣇⠀⠀⠄⠀⡇⢣⢛⠀⡇⠀⠀⣸⠇⠀⠀⠀⠀⠀⠘⠄⢻⡀⠻⣻⣧⠀⠀⠃⢧⡇⠀⢸⢸⡇⡇]],
            -- [[⢸⡇⢸⣠⠀⣿⢠⣿⡾⠁⠀⢀⡀⠤⢇⣀⣐⣀⠀⠤⢀⠈⠢⡡⡈⢦⡙⣷⡀⠀⠀⢿⠈⢻⣡⠁⠀⢀⠏⠀⠀⠀⢀⠀⠄⣀⣐⣀⣙⠢⡌⣻⣷⡀⢹⢸⡅⠀⢸⠸⡇⡇]],
            -- [[⢸⡇⢸⣟⠀⢿⢸⡿⠀⣀⣶⣷⣾⡿⠿⣿⣿⣿⣿⣿⣶⣬⡀⠐⠰⣄⠙⠪⣻⣦⡀⠘⣧⠀⠙⠄⠀⠀⠀⠀⠀⣨⣴⣾⣿⠿⣿⣿⣿⣿⣿⣶⣯⣿⣼⢼⡇⠀⢸⡇⡇⠇]],
            -- [[⢸⢧⠀⣿⡅⢸⣼⡷⣾⣿⡟⠋⣿⠓⢲⣿⣿⣿⡟⠙⣿⠛⢯⡳⡀⠈⠓⠄⡈⠚⠿⣧⣌⢧⠀⠀⠀⠀⠀⣠⣺⠟⢫⡿⠓⢺⣿⣿⣿⠏⠙⣏⠛⣿⣿⣾⡇⢀⡿⢠⠀⡇]],
            -- [[⢸⢸⠀⢹⣷⡀⢿⡁⠀⠻⣇⠀⣇⠀⠘⣿⣿⡿⠁⠐⣉⡀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠉⠓⠳⠄⠀⠀⠀⠀⠋⠀⠘⡇⠀⠸⣿⣿⠟⠀⢈⣉⢠⡿⠁⣼⠁⣼⠃⣼⠀⡇]],
            -- [[⢸⠸⣀⠈⣯⢳⡘⣇⠀⠀⠈⡂⣜⣆⡀⠀⠀⢀⣀⡴⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢽⣆⣀⠀⠀⠀⣀⣜⠕⡊⠀⣸⠇⣼⡟⢠⠏⠀⡇]],
            -- [[⢸⠀⡟⠀⢸⡆⢹⡜⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠋⣾⡏⡇⡎⡇⠀⡇]],
            -- [[⢸⠀⢃⡆⠀⢿⡄⠑⢽⣄⠀⠀⠀⢀⠂⠠⢁⠈⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠄⡐⢀⠂⠀⠀⣠⣮⡟⢹⣯⣸⣱⠁⠀⡇]],
          },
          opts = {
            position = "center",
            hl = "Label",
          },
        },
        {
          type = "text",
          val = require("alpha.fortune")(),
          opts = {
            position = "center",
            hl = "Comment",
          },
        },
        { type = "padding", val = 1 },
        {
          type = "group",
          val = {
            button("SPC s s", "  Open session"),
            button("SPC f f", "  Find file"),
            button("SPC f e", "  File browser"),
            button(
              "SPC a a",
              "󱜸  AI Agent",
              [[<cmd>lua vim.defer_fn(function() require("avante.api").zen_mode() end, 100)<cr>]]
            ),
            button("SPC m c", "󰐻  Manage MCP"),
            button("SPC m m", "  Manage Mason"),
            button("SPC m p", "󰒲  Manage Lazy"),
            button("q", "  Quit", ":q<CR>"),
          },
          opts = {
            position = "center",
            spacing = 1,
          },
        },
        { type = "padding", val = 1 },
        {
          type = "text",
          val = get_info(),
          opts = {
            position = "center",
            hl = "ErrorMsg",
          },
        },
      },
    })
  end,
}