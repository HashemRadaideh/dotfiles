return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {

    {
      "<leader>aa",
      function()
        require("harpoon"):list():append()
      end,
    },

    {
      "<leader>ak",
      function()
        -- basic telescope configuration
        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
          local file_paths = {}
          for _, item in ipairs(harpoon_files.items) do
            table.insert(file_paths, item.value)
          end

          require("telescope.pickers")
            .new({}, {
              prompt_title = "Harpoon",
              finder = require("telescope.finders").new_table({
                results = file_paths,
              }),
              previewer = conf.file_previewer({}),
              sorter = conf.generic_sorter({}),
            })
            :find()
        end

        toggle_telescope(require("harpoon"):list())
      end,
      { desc = "Open harpoon window" },
    },
    -- {"<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end},

    {
      "<C-1>",
      function()
        require("harpoon"):list():select(1)
      end,
    },
    {
      "<C-2>",
      function()
        require("harpoon"):list():select(2)
      end,
    },
    {
      "<C-3>",
      function()
        require("harpoon"):list():select(3)
      end,
    },
    {
      "<C-4>",
      function()
        require("harpoon"):list():select(4)
      end,
    },

    -- Toggle previous & next buffers stored within Harpoon list
    {
      "<leader>ah",
      function()
        require("harpoon"):list():prev()
      end,
    },
    {
      "<leader>al",
      function()
        require("harpoon"):list():next()
      end,
    },
  },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup({})
  end,
}
