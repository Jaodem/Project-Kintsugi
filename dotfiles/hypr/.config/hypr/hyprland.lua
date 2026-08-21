-- Project Kintsugi — Hyprland Main Entrypoint
-- Architecture: Modular Lua Configuration

local config_dir = os.getenv("HOME") .. "/.config/hypr/"
package.path = config_dir .. "modules/?.lua;" .. package.path

require("monitors")
require("autostart")
require("env")
require("appearance")
require("input")
require("rules")
require("keybindings")
