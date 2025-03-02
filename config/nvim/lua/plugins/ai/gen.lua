return {
  "David-Kunz/gen.nvim",
  cmd = { "Gen" },
  keys = {
    {
      "<leader>]",
      ":Gen<CR>",
      { noremap = true, silent = true },
      mode = { "n", "v" },
    },
    {
      "<leader>as",
      ':lua require("gen").select_model()<CR>',
      { noremap = true, silent = true },
      mode = { "n", "v" },
    },
  },
  opts = {
    model = "llama3.2:3b",
    host = "localhost",
    port = "11434",
    display_mode = "float",
    show_prompt = false,
    show_model = true,
    quit_map = "q",
    no_auto_close = false,
    init = function(options)
      pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
    end,
    command = function(options)
      return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
    end,
    debug = false,
  },
  config = function()
    require("gen").prompts["Elaborate_Text"] = {
      prompt = "Elaborate the following text:\n$text",
      replace = true,
    }

    require("gen").prompts["Fix_Code"] = {
      prompt = "Fix the following code. Only ouput the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
      replace = true,
      extract = "```$filetype\n(.-)```",
    }
  end,
}
