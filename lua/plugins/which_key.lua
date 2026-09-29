return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- Plain-text labels work without Nerd Fonts on other machines.
    icons = {
      mappings = false,
      breadcrumb = ">",
      separator = "->",
      group = "+",
      ellipsis = "...",
      keys = {
        Up = "Up", Down = "Down", Left = "Left", Right = "Right",
        C = "Ctrl-", M = "Alt-", D = "Cmd-", S = "Shift-",
        CR = "Enter", Esc = "Esc", NL = "Enter", BS = "Backspace",
        Space = "Space", Tab = "Tab",
        ScrollWheelDown = "WheelDown", ScrollWheelUp = "WheelUp",
        F1 = "F1", F2 = "F2", F3 = "F3", F4 = "F4",
        F5 = "F5", F6 = "F6", F7 = "F7", F8 = "F8",
        F9 = "F9", F10 = "F10", F11 = "F11", F12 = "F12",
      },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
