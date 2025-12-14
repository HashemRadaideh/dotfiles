return {
  "goolord/alpha-nvim",
  lazy = false,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local ok, alpha = pcall(require, "alpha")
    if not ok then
      return
    end

    local _, _, path = string.find(debug.getinfo(1).short_src, "(.*nvim)")

    local function getOrdinal(number)
      local day = number or tonumber(os.date("%d"))
      if day >= 11 and day <= 13 then
        return day .. "th"
      end

      if day % 10 == 1 then
        return day .. "st"
      elseif day % 10 == 2 then
        return day .. "nd"
      elseif day % 10 == 3 then
        return day .. "rd"
      else
        return day .. "th"
      end
    end

    local function get_greeting()
      local tableTime = os.date("*t")
      local hour = tableTime.hour
      local greetingsTable = {
        [1] = "It's bedtime",
        [2] = "Good morning",
        [3] = "Good afternoon",
        [4] = "Good evening",
        [5] = "Good night",
      }
      local greetingIndex = 0
      if hour == 23 or hour < 7 then
        greetingIndex = 1
      elseif hour < 12 then
        greetingIndex = 2
      elseif hour >= 12 and hour < 18 then
        greetingIndex = 3
      elseif hour >= 18 and hour < 21 then
        greetingIndex = 4
      elseif hour >= 21 then
        greetingIndex = 5
      end

      return greetingsTable[greetingIndex]
        .. " "
        .. os.getenv("USER"):gsub("^%l", os.getenv("USER").upper)
        .. " it's "
        .. os.date("%A, ")
        .. getOrdinal()
        .. os.date(" of %B, ")
        .. os.date("%H:%M")
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

    -- to find a color use `:h highlight-groups`
    alpha.setup({
      layout = {
        { type = "padding", val = 9 },
        {
          type = "text",
          val = {
            -- http://patorjk.com/software/taag/#p=display&f=Graffiti&t=Type%20Something%20
            -- NScript
            -- [[                                                    gg                     ]],
            -- [[                                                    ""                     ]],
            -- [[ ,ggg,,ggg,    ,ggg,     ,ggggg,       ggg    gg    gg    ,ggg,,ggg,,ggg,  ]],
            -- [[,8" "8P" "8,  i8" "8i   dP"  "Y8ggg   d8"Yb   88bg  88   ,8" "8P" "8P" "8, ]],
            -- [[     8I   8I  I8, ,8I  i8"    ,8I    dP  I8   8I    88   I8   8I   8I   8I ]],
            -- [[     8I   Yb, `YbadP" ,d8,   ,d8"        I8, ,8I  _,88,_,dP   8I   8I   Yb,]],
            -- [[     8I   `Y8888P"Y888P"Y8888P"           "Y8P"   8P""Y88P"   8I   8I   `Y8]],

            [[                                                gg                     ]],
            [[                                                ""                     ]],
            [[ ,ggg,,ggg,    ,ggg,     ,ggggg,   ggg    gg    gg    ,ggg,,ggg,,ggg,  ]],
            [[,8" "8P" "8,  i8" "8i   dP"  "Y8ggg8"Yb   88bg  88   ,8" "8P" "8P" "8, ]],
            [[     8I   8I  I8, ,8I  i8'    ,8I    I8   8I    88   I8   8I   8I   8I ]],
            [[     8I   Yb, `YbadP' ,d8,   ,d8'    I8, ,8I  _,88,_,dP   8I   8I   Yb,]],
            [[     8I   `Y8888P"Y888P"Y8888P"       "Y8P"   8P""Y88P'   8I   8I   `Y8]],

            -- [[ ,ggg, ,ggggggg,                     ,ggg,         ,gg                       ]],
            -- [[dP""Y8,8P"""""Y8b                   dP""Y8a       ,8P                        ]],
            -- [[Yb, `8dP'     `88                   Yb, `88       d8'                        ]],
            -- [[ `"  88'       88                    `"  88       88  gg                     ]],
            -- [[     88        88                        88       88  ""                     ]],
            -- [[     88        88   ,ggg,     ,ggggg,    I8       8I  gg    ,ggg,,ggg,,ggg,  ]],
            -- [[     88        88  i8" "8i   dP"  "Y8ggg `8,     ,8'  88   ,8" "8P" "8P" "8, ]],
            -- [[     88        88  I8, ,8I  i8'    ,8I    Y8,   ,8P   88   I8   8I   8I   8I ]],
            -- [[     88        Y8, `YbadP' ,d8,   ,d8'     Yb,_,dP  _,88,_,dP   8I   8I   Yb,]],
            -- [[     88        `Y8888P"Y888P"Y8888P"        "Y8P"   8P""Y88P'   8I   8I   `Y8]],
                                                                             
            -- [[     ***** *     **                              ***** *      **                            ]],
            -- [[  ******  **    **** *                        ******  *    *****     *                      ]],
            -- [[ **   *  * **    ****                        **   *  *       *****  ***                     ]],
            -- [[*    *  *  **    * *                        *    *  **       * **    *                      ]],
            -- [[    *  *    **   *                  ****        *  ***      *                               ]],
            -- [[   ** **    **   *        ***      * ***  *    **   **      *      ***     *** **** ****    ]],
            -- [[   ** **     **  *       * ***    *   ****     **   **      *       ***     *** **** ***  * ]],
            -- [[   ** **     **  *      *   ***  **    **      **   **     *         **      **  **** ****  ]],
            -- [[   ** **      ** *     **    *** **    **      **   **     *         **      **   **   **   ]],
            -- [[   ** **      ** *     ********  **    **      **   **     *         **      **   **   **   ]],
            -- [[   *  **       ***     *******   **    **       **  **    *          **      **   **   **   ]],
            -- [[      *        ***     **        **    **        ** *     *          **      **   **   **   ]],
            -- [[  ****          **     ****    *  ******          ***     *          **      **   **   **   ]],
            -- [[ *  *****               *******    ****            *******           *** *   ***  ***  ***  ]],
            -- [[*     **                 *****                       ***              ***     ***  ***  *** ]],
            -- [[*                                                                                           ]],
            -- [[ **                                                                                         ]],

            -- [[     ##### #     ##                       ##### /      ##                         ]],
            -- [[  ######  /#    #### /                 ######  /    #####    #                    ]],
            -- [[ /#   /  / ##    ###/                 /#   /  /       ##### ###                   ]],
            -- [[/    /  /  ##    # #                 /    /  ##       / ##   #                    ]],
            -- [[    /  /    ##   #                       /  ###      /                            ]],
            -- [[   ## ##    ##   #    /##       /###    ##   ##      #     ###   ### /### /###    ]],
            -- [[   ## ##     ##  #   / ###     / ###  / ##   ##      /      ###   ##/ ###/ /##  / ]],
            -- [[   ## ##     ##  #  /   ###   /   ###/  ##   ##     /        ##    ##  ###/ ###/  ]],
            -- [[   ## ##      ## # ##    ### ##    ##   ##   ##     #        ##    ##   ##   ##   ]],
            -- [[   ## ##      ## # ########  ##    ##   ##   ##     /        ##    ##   ##   ##   ]],
            -- [[   #  ##       ### #######   ##    ##    ##  ##    /         ##    ##   ##   ##   ]],
            -- [[      /        ### ##        ##    ##     ## #     #         ##    ##   ##   ##   ]],
            -- [[  /##/          ## ####    / ##    ##      ###     /         ##    ##   ##   ##   ]],
            -- [[ /  #####           ######/   ######        ######/          ### / ###  ###  ###  ]],
            -- [[/     ##             #####     ####           ###             ##/   ###  ###  ### ]],
            -- [[#                                                                                 ]],
            -- [[ ##                                                                               ]],

            -- [[     ...     ...                                                    .                       ]],
            -- [[  .=*8888n.."%888:                                                 @88>                     ]],
            -- [[ X    ?8888f '8888                     u.        ...     ..        %8P      ..    .     :   ]],
            -- [[ 88x. '8888X  8888>       .u     ...ue888b    :~""888h.:^"888:      .     .888: x888  x888. ]],
            -- [['8888k 8888X  '"*8h.   ud8888.   888R Y888r  8X   `8888X  8888>   .@88u  ~`8888~'888X`?888f`]],
            -- [[ "8888 X888X .xH8    :888'8888.  888R I888> X888n. 8888X  ?888>  ''888E`   X888  888X '888> ]],
            -- [[   `8" X888!:888X    d888 '88%"  888R I888> '88888 8888X   ?**h.   888E    X888  888X '888> ]],
            -- [[  =~`  X888 X888X    8888.+"     888R I888>   `*88 8888~ x88x.     888E    X888  888X '888> ]],
            -- [[   :h. X8*` !888X    8888L      u8888cJ888   ..<"  88*`  88888X    888E    X888  888X '888> ]],
            -- [[  X888xX"   '8888..: '8888c. .+  "*888*P"       ..XC.    `*8888k   888&   "*88%""*88" '888!`]],
            -- [[:~`888f     '*888*"   "88888%      'Y"        :888888H.    `%88>   R888"    `~    "    `"`  ]],
            -- [[    ""        `"`       "YP'                 <  `"888888:    X"     ""                      ]],
            -- [[                                                   %888888x.-`                              ]],
            -- [[                                                     ""**""                                 ]],
                                                                                             
                                                             
            -- [[ _______ _______ _______ _______ _______ _______ ]],
            -- [[|\     /|\     /|\     /|\     /|\     /|\     /|]],
            -- [[| +---+ | +---+ | +---+ | +---+ | +---+ | +---+ |]],
            -- [[| |   | | |   | | |   | | |   | | |   | | |   | |]],
            -- [[| |N  | | |e  | | |o  | | |V  | | |i  | | |m  | |]],
            -- [[| +---+ | +---+ | +---+ | +---+ | +---+ | +---+ |]],
            -- [[|/_____\|/_____\|/_____\|/_____\|/_____\|/_____\|]],
                                                 
                                                                                            
            -- [[.------..------..------..------..------..------.]],
            -- [[|N.--. ||E.--. ||O.--. ||V.--. ||I.--. ||M.--. |]],
            -- [[| :(): || (\/) || :/\: || :(): || (\/) || (\/) |]],
            -- [[| ()() || :\/: || :\/: || ()() || :\/: || :\/: |]],
            -- [[| '--'N|| '--'E|| '--'O|| '--'V|| '--'I|| '--'M|]],
            -- [[`------'`------'`------'`------'`------'`------']],

            -- [[ _____                                     ]],
            -- [[|A .  | _____                    _______   ]],
            -- [[| /.\ ||A ^  | _____           /\       \  ]],
            -- [[|(_._)|| / \ ||A _  | _____   /()\   ()  \ ]],
            -- [[|  |  || \ / || ( ) ||A_ _ | /    \_______\]],
            -- [[|____V||  .  ||(_'_)||( v )| \    /()     /]],
            -- [[       |____V||  |  || \ / |  \()/   ()  / ]],
            -- [[              |____V||  .  |   \/_____()/  ]],
            -- [[                     |____V|               ]],

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
          type = "text",
          val = get_greeting(),
          opts = {
            position = "center",
            hl = "String",
          },
        },
        { type = "padding", val = 1 },
        {
          type = "group",
          val = {
            button("SPC s s", "  Open session"),
            button("SPC f p", "  Find repo"),
            button("SPC f f", "  Find file"),
            button("SPC f e", "  File browser"),
            button("SPC m p", "  Sync/Update"),
            -- button("c", "  Config", (":cd %s | e init.lua <CR>"):format(path)),
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

    -- vim.api.nvim_create_augrsup("alpha_tabline", { clear = true })

    -- vim.api.nvim_create_autocmd("FileType", {
    --   group = "alpha_tabline",
    --   pattern = "alpha",
    --   command = "setlocal showtabline=0 laststatus=0 noruler nofoldenable",
    -- })

    -- vim.api.nvim_create_autocmd("FileType", {
    --   group = "alpha_tabline",
    --   pattern = "alpha",
    --   callback = function()
    --     vim.api.nvim_create_autocmd("BufUnload", {
    --       group = "alpha_tabline",
    --       buffer = 0,
    --       command = "setlocal showtabline=2 laststatus=3 ruler nofoldenable",
    --     })
    --   end,
    -- })
  end,
}
