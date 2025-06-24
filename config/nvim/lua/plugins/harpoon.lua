return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("harpoon"):setup({})
  end,
  keys = {
    {
      "<leader>ha",
      function()
        require("harpoon"):list():add()
      end,
      { desc = "Added current file to harpoon" },
    },
    {
      "<leader>hs",
      function()
        require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
      end,
      { desc = "Open harpoon window" },
    },
    {
      "<leader>hl",
      function()
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
      { desc = "Open harpoon telescope picker" },
    },
    {
      "<C-S-p>",
      function()
        require("harpoon"):list():prev()
      end,
      { desc = "Open harpoon previous window" },
    },
    {
      "<C-S-n>",
      function()
        require("harpoon"):list():next()
      end,
      { desc = "Open harpoon next window" },
    },
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
  },
}
