return {
  "Jorenar/nvim-dap-disasm",
  dependencies = {
    "mfussenegger/nvim-dap",
    "igorlfs/nvim-dap-view",
  },
  opts = {
    dapui_register = false,
    dapview_register = true,
    dapview = {
      keymap = "D",
      label = "Disassembly",
      short_label = "󰒓 [D]",
    },
    winbar = {
      enabled = true,
      labels = {
        step_into = "Step Into",
        step_over = "Step Over",
        step_back = "Step Back",
      },
      order = {
        "step_into",
        "step_over",
        "step_back",
      },
    },
    sign = "DapStopped",
    ins_before_memref = 16,
    ins_after_memref = 16,
    columns = {
      "address",
      "instructionBytes",
      "instruction",
    },
  },
}