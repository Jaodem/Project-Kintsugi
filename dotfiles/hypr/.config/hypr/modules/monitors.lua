---@diagnostic disable: undefined-global

-- Project Kintsugi — Monitor Configuration
-- Responsability: Display layout, scaling, and positioning

hl.monitor({
    output   = "eDP-1",
    mode     = "preferred",
    position = "0x0",
    scale    = 1.25,
})

hl.monitor({
    output   = "HDMI-A-1",
    mode     = "preferred",
    position = "1536x0",
    scale    = 1,
})
