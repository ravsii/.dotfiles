return {
  {
    {
      "shortcuts/no-neck-pain.nvim",
      version = "*",
      opts = {
        debug = false,
        width = 130,
        minSideBufferWidth = 10,
        disableOnLastBuffer = false,
        -- When `true`, disabling the plugin closes every other windows except the initially focused one.
        --- @type boolean
        killAllBuffersOnDisable = false,
        autocmds = {
          -- When `true`, enables the plugin when you start Neovim.
          -- If the main window is  a side tree (e.g. NvimTree) or a dashboard, the command is delayed until it finds a valid window.
          -- The command is cleaned once it has successfuly ran once.
          --- @type boolean
          enableOnVimEnter = false,
          -- When `true`, enables the plugin when you enter a new Tab.
          -- note: it does not trigger if you come back to an existing tab, to prevent unwanted interfer with user's decisions.
          --- @type boolean
          enableOnTabEnter = false,
          reloadOnColorSchemeChange = true,
          skipEnteringNoNeckPainBuffer = false,
        },
        -- Creates mappings for you to easily interact with the exposed commands.
        --- @type table
        mappings = {
          enabled = true,
          toggle = "<Leader>np",
          toggleLeftSide = "<Leader>nql",
          toggleRightSide = "<Leader>nqr",
          widthUp = "<Leader>n=",
          widthDown = "<Leader>n-",
          scratchPad = "<Leader>ns",
        },
      },
    },
  },
}
