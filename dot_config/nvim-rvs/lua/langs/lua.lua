require("install"):add_mason({ "stylua" })

return {
  {
    "nvim-neotest/neotest",
    dependencies = { "HiPhish/neotest-busted" },
    opts = { adapters = { ["neotest-busted"] = {} } },
  },
}
