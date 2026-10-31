local function ai_whichkey(opts)
  local objects = {
    { " ", desc = "whitespace" },
    { '"', desc = '" string' },
    { "'", desc = "' string" },
    { "(", desc = "() block" },
    { ")", desc = "() block with ws" },
    { "<", desc = "<> block" },
    { ">", desc = "<> block with ws" },
    { "?", desc = "user prompt" },
    { "U", desc = "use/call without dot" },
    { "[", desc = "[] block" },
    { "]", desc = "[] block with ws" },
    { "_", desc = "underscore" },
    { "`", desc = "` string" },
    { "a", desc = "argument" },
    { "b", desc = ")]} block" },
    { "c", desc = "class" },
    { "d", desc = "digit(s)" },
    { "e", desc = "CamelCase / snake_case" },
    { "f", desc = "function" },
    { "g", desc = "entire file" },
    { "i", desc = "indent" },
    { "o", desc = "block, conditional, loop" },
    { "q", desc = "quote `\"'" },
    { "t", desc = "tag" },
    { "u", desc = "use/call" },
    { "{", desc = "{} block" },
    { "}", desc = "{} with ws" },
  }

  ---@type wk.Spec[]
  local ret = { mode = { "o", "x" } }

  ---@type table<string, string>
  local mappings = vim.tbl_extend("force", {}, {
    around = "a",
    inside = "i",
    around_next = "an",
    inside_next = "in",
    around_last = "al",
    inside_last = "il",
  }, opts.mappings or {})

  mappings.goto_left = nil
  mappings.goto_right = nil

  for name, prefix in pairs(mappings) do
    local group = name:gsub("^around_", ""):gsub("^inside_", "")
    ret[#ret + 1] = { prefix, group = group }
    for _, obj in ipairs(objects) do
      local desc = obj.desc
      if prefix:sub(1, 1) == "i" then
        desc = desc:gsub(" with ws", "")
      end
      ret[#ret + 1] = { prefix .. obj[1], desc = desc }
    end
  end

  require("which-key").add(ret, { notify = false })
end

vim.pack.add({
  "https://github.com/nvim-mini/mini.pairs",
  "https://github.com/nvim-mini/mini.ai",
  "https://github.com/nvim-mini/mini.align",
  "https://github.com/nvim-mini/mini.surround",
})

require("mini.pairs").setup({
  modes = { insert = true, command = true, terminal = false },
})

local ai = require("mini.ai")
local ai_opts = {
  n_lines = 500,
  custom_textobjects = {
    o = ai.gen_spec.treesitter({
      a = { "@block.outer", "@conditional.outer", "@loop.outer" },
      i = { "@block.inner", "@conditional.inner", "@loop.inner" },
    }),
    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
    t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
    d = { "%f[%d]%d+" },
    e = {
      { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
      "^().*()$",
    },
    u = ai.gen_spec.function_call(),
    U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }),
  },
}
ai.setup(ai_opts)
vim.schedule(function()
  ai_whichkey(ai_opts)
  require("which-key").add({
    { "gsa", desc = "Add Surrounding", mode = { "n", "x" } },
    { "gsd", desc = "Delete Surrounding", mode = { "n", "x" } },
    { "gsf", desc = "Find Right Surrounding", mode = { "n", "x" } },
    { "gsF", desc = "Find Left Surrounding", mode = { "n", "x" } },
    { "gsh", desc = "Highlight Surrounding", mode = { "n", "x" } },
    { "gsr", desc = "Replace Surrounding", mode = { "n", "x" } },
    { "gsn", desc = "Update n_lines", mode = { "n", "x" } },
  })
end)

require("mini.align").setup({})

require("mini.surround").setup({
  mappings = {
    add = "gsa",
    delete = "gsd",
    find = "gsf",
    find_left = "gsF",
    highlight = "gsh",
    replace = "gsr",
  },
})

vim.keymap.set(
  { "n", "x" },
  "gsn",
  function() require("mini.surround").update_n_lines() end,
  { desc = "Update n_lines" }
)
