-- keymap leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- autocomplete
vim.opt.completeopt = "menu,menuone,noselect"

vim.opt.autowrite = true
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
vim.opt.colorcolumn = "81,120"
vim.opt.textwidth = 80
vim.opt.conceallevel = 0
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
vim.opt.fixeol = false -- Don't add \n at the of the file. Breaks formatters.
vim.opt.foldlevel = 99
vim.opt.foldmethod = "indent"
vim.opt.formatoptions = "jcroqlnt"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.ignorecase = true
vim.opt.inccommand = "nosplit" -- preview incremental substitute
vim.opt.jumpoptions = "view"
vim.opt.laststatus = 3 -- global statusline
vim.opt.linebreak = true -- Wrap lines at convenient points
vim.opt.list = true -- Show some invisible characters (tabs...
vim.opt.listchars = "tab:> ,trail:-,nbsp:+"
vim.opt.messagesopt = "wait:2000,history:500"
vim.opt.mouse = "n" -- Enable mouse mode in normal mode
vim.opt.number = true -- Print line number
vim.opt.pumblend = 10 -- Popup blend
vim.opt.pumheight = 10 -- Maximum number of entries in a popup
vim.opt.relativenumber = false -- Relative line numbers
vim.opt.ruler = false -- Disable the default ruler
vim.opt.scrolloff = 10 -- Lines of context
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
vim.opt.shiftround = true -- Round indent
vim.opt.shiftwidth = 4 -- Size of an indent
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })
vim.opt.showmode = false -- Dont show mode since we have a statusline
vim.opt.sidescrolloff = 8 -- Columns of context
vim.opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.opt.smartcase = true -- Don't ignore case with capitals
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.smoothscroll = true
vim.opt.spelllang = { "en", "ru" }
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitkeep = "screen"
vim.opt.splitright = true -- Put new windows right of current

vim.opt.tabstop = 4 -- Number of spaces tabs count for
vim.opt.termguicolors = true -- True color support
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.updatetime = 200 -- Save swap file and trigger CursorHold
vim.opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
vim.opt.wildmode = "longest:full,full" -- Command-line completion mode
vim.opt.winminwidth = 5 -- Minimum window width
vim.opt.wrap = false -- Disable line wrap

vim.opt.exrc = true -- allow project-specific config
vim.opt.secure = true -- disable unsafe commands in local configs

vim.opt.winborder = "rounded"
