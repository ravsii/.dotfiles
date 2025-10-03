return {
  {
    -- I leave the configuration here, but with all the major AI models blocked
    -- in russia, I don't wanna spin up VPN just to ask some stupid stuff.
    enabled = false,

    "yetone/avante.nvim",
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    -- ⚠️ must add this setting! ! !
    build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make BUILD_FROM_SOURCE=true",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },

    keys = {
      { "<leader>a", "", desc = "+avante" },
    },

    ---@module 'avante'
    ---@type avante.Config
    opts = {
      instructions_file = "avante.md",
      provider = "gemini",
      providers = {
        ollama = {
          endpoint = "http://localhost:11434",
          model = "qwen2.5-coder:3b",
        },
      },
    },
  },
}
