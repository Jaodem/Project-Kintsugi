-- Project Kintsugi — Keybindings & Input Controls
-- Responsability: Global keyboard shortcuts, window actions, mouse binds, and media controls

local mainMod = "SUPER"

-- Programs
local terminal    = "kitty"
local fileManager = "dolphin"
local menu        = "fuzzel"

-- Disable middle-click (MMB) globally
hl.bind("mouse:274", hl.dsp.exec_cmd("true"))

-- Core Applications & Launchers
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd("~/.config/hypr/scripts/emoji-selector.sh"))

-- Session & Menus
hl.bind("CTRL + ALT + Delete", hl.dsp.exec_cmd("~/.config/hypr/scripts/session-menu.sh"))
hl.bind(mainMod .. " + W",       hl.dsp.exec_cmd("~/.config/hypr/scripts/wallpaper-menu.sh"))
hl.bind(mainMod .. " + M",       hl.dsp.exec_cmd("~/.config/hypr/scripts/monitor-menu.sh"))
hl.bind(mainMod .. " + F",       hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle-follow-mouse.sh"))

-- Window Management
hl.bind(mainMod .. " + C",          hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + C",  hl.dsp.window.kill())
hl.bind(mainMod .. " + V",          hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + F",  hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + P",          hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J",          hl.dsp.layout("togglesplit"))

-- Screenshots (Grimblast)
hl.bind("Print",         hl.dsp.exec_cmd("grimblast copy area"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("mkdir -p ~/Pictures/Screenshots && grimblast -n save area ~/Pictures/Screenshots/Screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png"))
hl.bind("CTRL + Print",  hl.dsp.exec_cmd("grimblast copy screen"))

-- Focus Movement (Super + Arrows)
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Move Tiled Window (Super + Shift + Arrows)
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "d" }))

-- Precise Floating Movement (Super + Alt + Arrows)
hl.bind(mainMod .. " + ALT + left",  hl.dsp.window.move({ x = -40, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.move({ x = 40, y = 0, relative = true }),  { repeating = true })
hl.bind(mainMod .. " + ALT + up",    hl.dsp.window.move({ x = 0, y = -40, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + down",  hl.dsp.window.move({ x = 0, y = 40, relative = true }),  { repeating = true })

-- Resize Window (Super + Ctrl + Arrows)
hl.bind(mainMod .. " + CTRL + left",  hl.dsp.window.resize({ x = -40, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.resize({ x = 40, y = 0, relative = true }),  { repeating = true })
hl.bind(mainMod .. " + CTRL + up",    hl.dsp.window.resize({ x = 0, y = -40, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + down",  hl.dsp.window.resize({ x = 0, y = 40, relative = true }),  { repeating = true })

-- Workspace Navigation
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
    end

    hl.bind(mainMod .. " + Tab", hl.dsp.focus({ workspace = "previous" }))

    -- Special Workspace (Scratchpad)
    hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
    hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

    -- Mouse Workspace Scrolling & Dragging
    hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
    hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))
    hl.bind(mainMod .. " + mouse:272",  hl.dsp.window.drag(),   { mouse = true })
    hl.bind(mainMod .. " + mouse:273",  hl.dsp.window.resize(), { mouse = true })

    -- Hardware Audio Controls (wpctl)
    hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
    hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
    hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
    hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })

    -- Hardware Brightness Controls (brightnessctl)
    hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
    hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

    -- Multimedia Controls (playerctl)
    hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
    hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
    hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
    hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
