---@diagnostic disable: undefined-global

-- Project Kintsugi — Input Configuration
-- Responsability: Keyboard layouts, mouse behavior, gestures, and per-device setups

hl.config({
    input = {
        kb_layout  = "us,latam",
        kb_variant = "intl,",
        kb_model   = "",
        kb_options = "grp:win_space_toggle",
        kb_rules   = "",

        follow_mouse = 1,
        sensitivity  = 0,

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})
