local astal = require("astal")
local App = require("astal.gtk3.app")
local Widget = require("astal.gtk3.widget")
local Variable = astal.Variable
local Gdk = astal.require("Gdk", "3.0")
local GLib = astal.require("GLib")
local bind = astal.bind
local Battery = astal.require("AstalBattery")
local Wp = astal.require("AstalWp")
local Network = astal.require("AstalNetwork")
local Tray = astal.require("AstalTray")
local Hyprland = astal.require("AstalHyprland")
local map = require("util").map

local function SysTray()
	local tray = Tray.get_default()

	return Widget.Box({
		class_name = "SysTray IconBox",

		bind(tray, "items"):as(function(items)
			return map(items, function(item)
				if item.icon_theme_path ~= nil then
					App:add_icons(item.icon_theme_path)
				end

				local menu = item:create_menu()

				return Widget.Button({
					tooltip_markup = bind(item, "tooltip_markup"),
					on_destroy = function()
						if menu ~= nil then
							menu:destroy()
						end
					end,
					on_click_release = function(self)
						if menu ~= nil then
							menu:popup_at_widget(self, Gdk.Gravity.SOUTH, Gdk.Gravity.NORTH, nil)
						end
					end,
					Widget.Icon({
						g_icon = bind(item, "gicon"),
					}),
				})
			end)
		end),
	})
end

local function FocusedClient()
	local hypr = Hyprland.get_default()
	local focused = bind(hypr, "focused-client")

	return Widget.Box({
		class_name = "Focused",
		visible = focused,
		focused:as(function(client)
			return client and Widget.Label({
				label = bind(client, "title"):as(tostring),
			})
		end),
	})
end

local function Wifi()
	local wifi = Network.get_default().wifi

	return Widget.Icon({
		tooltip_text = bind(wifi, "ssid"):as(tostring),
		class_name = "Wifi",
		icon = bind(wifi, "icon-name"),
	})
end

local function AudioSlider()
	local speaker = Wp.get_default().audio.default_speaker

	return Widget.Box({
		class_name = "IconBox",
		Widget.Label({
			label = bind(speaker, "volume"):as(function(v) 
				return tostring(math.floor(v * 100)) .. "%"
			end),
		}),
		Widget.Icon({
			icon = bind(speaker, "volume-icon"),
		}),
	})
end

local function BatteryLevel()
	local bat = Battery.get_default()

	return Widget.Box({
		class_name = "IconBox",
		visible = bind(bat, "is-present"),
		Widget.Label({
			label = bind(bat, "percentage"):as(function(p)
				return tostring(math.floor(p * 100)) .. "%"
			end),
		}),
		Widget.Icon({
			icon = bind(bat, "battery-icon-name"),
		}),
	})
end

local function Workspaces()
	local hypr = Hyprland.get_default()
	local names = {
		[5] = "Q",
		[6] = "W",
		[7] = "E",
		[8] = "R",
		[-98] = "~",
	}

	return Widget.Box({
		class_name = "Workspaces",
		bind(hypr, "workspaces"):as(function(wss)
			table.sort(wss, function(a, b)
				return a.id < b.id
			end)

			return map(wss, function(ws)
				return Widget.Button({
					class_name = bind(hypr, "focused-workspace"):as(function(fw)
						return fw == ws and "focused" or ""
					end),
					on_clicked = function()
						ws:focus()
					end,
					label = bind(ws, "id"):as(function(v)
						return names[v] or tostring(v)
					end),
				})
			end)
		end),
	})
end

local function Time()
	local time = Variable(""):poll(1000, function()
		return GLib.DateTime.new_now_local():format("%H:%M")
	end)

	return Widget.Box({
		class_name = "IconBox",

		Widget.Label({
			class_name = "Time",
			on_destroy = function()
					time:drop()
				end,
			label = time(),
		}),

		Widget.Icon({
			icon = "preferences-system-time-symbolic",
		}),
	})
end

return function(gdkmonitor)
	local WindowAnchor = astal.require("Astal", "3.0").WindowAnchor

	return Widget.Window({
		class_name = "Bar",
		gdkmonitor = gdkmonitor,
		anchor = WindowAnchor.TOP + WindowAnchor.LEFT + WindowAnchor.RIGHT,
		exclusivity = "EXCLUSIVE",

		Widget.CenterBox({
			Widget.Box({
				halign = "START",
				Workspaces(),
				FocusedClient(),
			}),
			Widget.Box({
			}),
			Widget.Box({
				halign = "END",
				SysTray(),
				Wifi(),
				AudioSlider(),
				BatteryLevel(),
				Time(),
			}),
		}),
	})
end
