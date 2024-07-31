return {
  {
    {
      "ibhagwan/fzf-lua",
      cmd = "FzfLua",
      opts = function(_, opts)
        local img_previewer ---@type string[]?
        for _, v in ipairs({
          -- { cmd = "ueberzugpp", args = {} },
          -- { cmd = "ueberzug", args = {} },
          { cmd = "chafa", args = { "{file}", "--format=symbols" } },
          { cmd = "viu", args = { "-b" } },
        }) do
          if vim.fn.executable(v.cmd) == 1 then
            img_previewer = vim.list_extend({ v.cmd }, v.args)
            break
          end
        end

        opts.previewers.builtin.extensions = {
          ["png"] = img_previewer,
          ["jpg"] = img_previewer,
          ["jpeg"] = img_previewer,
          ["gif"] = img_previewer,
          ["webp"] = img_previewer,
        }
      end,
    },
  },
}
