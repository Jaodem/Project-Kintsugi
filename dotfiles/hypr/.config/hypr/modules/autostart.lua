---@diagnostic disable: undefined-global

-- Project Kintsugi — Autostart Configuration
-- Responsability: Core session daemons and startup scripts

hl.on("hyprland.start", function ()
hl.exec_cmd("waybar")
hl.exec_cmd("~/.config/hypr/scripts/wallpaper.sh")
end)
