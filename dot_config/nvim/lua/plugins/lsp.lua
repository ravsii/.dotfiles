vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if vim.tbl_contains({ "null-ls" }, client.name) then -- blacklist lsp
      return
    end
    require("lsp_signature").on_attach({
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      max_height = 12, -- max height of signature floating_window
      max_width = 80, -- max_width of signature floating_window, line will be wrapped if exceed max_width
      wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long
      floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
      floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
      hint_enable = true, -- virtual hint enable
      -- hint_prefix = "🐼 ", -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
      hint_prefix = {
        above = "↙ ", -- when the hint is on the line above the current line
        current = "← ", -- when the hint is on the same line
        below = "↖ ", -- when the hint is on the line below the current line
      },
      hint_scheme = "String",
      hint_inline = function()
        return false
      end, -- should the hint be inline(nvim 0.10 only)?  default false
      -- return true | 'inline' to show hint inline, return 'eol' to show hint at end of line, return false to disable
      -- return 'right_align' to display hint right aligned in the current line
      hi_parameter = "LspKindObject", -- how your parameter will be highlight
      handler_opts = {
        border = "single", -- double, rounded, single, shadow, none, or a table of borders
      },
    }, bufnr)
  end,
})
return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.inlay_hints = {
        enabled = false,
      }
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },
}
