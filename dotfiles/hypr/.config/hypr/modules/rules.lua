-- Project Kintsugi — Window & Layer Rules
-- Responsability: Application positioning, floating exceptions, and layer behaviors

-- Ignore maximize requests from apps
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix dragging issues with XWayland
hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})

-- Emoji Selector
hl.window_rule({
    name = "emoji-selector",
    match = {
        class = "^org.kde.plasma.emojier$",
    },
    float = true,
    size  = { 10, 10 },
    move  = {"cursor_x-(window_w*0.5)", "cursor_y-(window_h*0.5)"},
})
