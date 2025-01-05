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

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(res)
              return res:sub(1, 1)
            end,
          },
        },
        lualine_b = {
          { "branch" },
        },
        lualine_c = {
          { LazyVim.lualine.pretty_path(), padding = { left = 1, right = 0 } },
        },
        lualine_x = {
          { "filetype", icon_only = false, separator = "", padding = { left = 0, right = 1 } },
        },
        lualine_y = {
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          {
            function()
              return get_scrollbar()
            end,
            padding = { left = 0, right = 1 },
          },
        },
      },
    },
  },
}
