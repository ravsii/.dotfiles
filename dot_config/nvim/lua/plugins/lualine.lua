-- super epic scrollbar from https://github.com/mcauley-penney/nvim/blob/main/lua/ui/statusline.lua
local function get_scrollbar()
  local sbar_chars = {
    "▔",
    "🮂",
    "🬂",
    "🮃",
    "▀",
    "▄",
    "▃",
    "🬭",
    "▂",
    "▁",
  }

  local cur_line = vim.api.nvim_win_get_cursor(0)[1]
  local lines = vim.api.nvim_buf_line_count(0)

  local i = math.floor((cur_line - 1) / lines * #sbar_chars) + 1
  local sbar = string.rep(sbar_chars[i], 2)

  return sbar
end

local ignoreFiles = require("files").ignored

return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "bwpge/lualine-pretty-path",
    },
    ---@module 'lualine'
    opts = {
      options = {
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = ignoreFiles,
          winbar = ignoreFiles,
        },
        globalstatus = true,
      },
      sections = {
        lualine_a = { { "mode" } },
        lualine_b = { { "branch" } },
        lualine_c = { { "pretty_path" }, { "diagnostics" } },
        lualine_x = { { "filetype" }, { "encoding" } },
        lualine_y = { { "location" } },
        lualine_z = {
          { function() return require("timer.integrations.lualine").closest_timer() end },
          { "progress" },
          { get_scrollbar },
        },
      },
      winbar = {
        lualine_c = { { "buffers" } },
        lualine_z = { { "lsp_status" } },
      },
    },
  },
}
