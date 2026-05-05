return {
  "andythigpen/nvim-coverage",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = {
    "Coverage",
    "CoverageLoad",
    "CoverageShow",
    "CoverageHide",
    "CoverageToggle",
    "CoverageSummary",
    "CoverageClear",
  },
  opts = {
    auto_reload = true,
    signs = {
      covered = { hl = "CoverageCovered", text = "▎" },
      uncovered = { hl = "CoverageUncovered", text = "▎" },
      partial = { hl = "CoveragePartial", text = "▎" },
    },
    summary = {
      min_coverage = 80.0,
    },
    lang = {
      python = {
        -- requires: pip install coverage && coverage run && coverage json
        coverage_command = "coverage json -q --data-file=.coverage",
      },
      javascript = {
        -- requires jest/vitest with --coverage --reporter=json
        coverage_file = "coverage/coverage-final.json",
      },
      typescript = {
        coverage_file = "coverage/coverage-final.json",
      },
      go = {
        -- requires: go test -coverprofile=coverage.out
        coverage_file = "coverage.out",
      },
      rust = {
        -- requires: cargo llvm-cov --lcov --output-path lcov.info
        coverage_file = "lcov.info",
      },
    },
  },
  keys = {
    { "<leader>tc", "<cmd>CoverageToggle<cr>", desc = "Toggle coverage" },
    { "<leader>tC", "<cmd>CoverageSummary<cr>", desc = "Coverage summary" },
    { "<leader>tL", "<cmd>CoverageLoad<cr>", desc = "Load coverage" },
  },
}