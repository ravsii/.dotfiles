rex.bind("cmd+=", "pane.balance")
rex.bind("cmd+r", "client.config.reload")
rex.bind("cmd+b", "client.sidebar.toggle")
rex.bind("cmd+p", "client.palette.toggle")

rex.bind("cmd+ctrl+alt+left", "pane.move", { direction = "left" })
rex.bind("cmd+ctrl+alt+right", "pane.move", { direction = "right" })
rex.bind("cmd+ctrl+alt+up", "pane.move", { direction = "up" })
rex.bind("cmd+ctrl+alt+down", "pane.move", { direction = "down" })

-- Binds for custom actions
rex.bind("cmd+g", "float_lazygit")
rex.bind("cmd+/", "float_scratch")
rex.bind("cmd+alt+\\", "expand_float")
rex.bind("cmd+shift+'", "cascade_floats")
rex.bind("cmd+o", "open_in_finder")
rex.bind("cmd+;", "session_agent")
