return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  ft = { "markdown", "Avante" },
  opts = {
    -- -- Pre configured settings that will attempt to mimic various target user experiences.
    -- -- User provided settings will take precedence.
    -- -- | obsidian | mimic Obsidian UI                                          |
    -- -- | lazy     | will attempt to stay up to date with LazyVim configuration |
    -- -- | none     | does nothing                                               |
    preset = "obsidian",
    file_types = { "markdown", "Avante" },
    render_modes = { "n", "c", "t", "i" },
    restart_highlighter = true,
    completions = {
      lsp = { enabled = true },
      blink = { enabled = true },
    },
  },
}
