#!/usr/bin/env luajit

local function relPath()
    local source = debug.getinfo(1,'S').source
    local spath = source:sub(2):gsub("^([^/])","./%1"):gsub("[^/]*$","")
    return spath.."?.lua;" .. spath.."?/init.lua;"
end
package.path = relPath() .. package.path

local astal = require("astal")
local App = require("astal.gtk3.app")
local Bar = require("widget.Bar")
local src = require("util").src
local scss = src("style.scss")
local css = "/tmp/style.css"

astal.exec("sass " .. scss .. " " .. css)

App:start({
	instance_name = "main-ui",
	css = css,
	request_handler = function(msg, res)
		print(msg)
		res("ok")
	end,
	main = function()
		for _, mon in pairs(App.monitors) do
			Bar(mon)
		end
	end,
})
