---@meta

if not table.unpack then
    table.unpack = unpack
end

local lgi = require("lgi")
local Binding = require("astal.binding")
local File = require("astal.file")
local Process = require("astal.process")
local Time = require("astal.time")
---@type Variable | fun(v: any): Variable
local Variable = require("astal.variable")

return {
    Variable = Variable,
    bind = Binding.new,

    interval = Time.interval,
    timeout = Time.timeout,
    idle = Time.idle,

    subprocess = Process.subprocess,
    exec = Process.exec,
    exec_async = Process.exec_async,

    read_file = File.read_file,
    read_file_async = File.read_file_async,
    write_file = File.write_file,
    write_file_async = File.write_file_async,
    monitor_file = File.monitor_file,

    require = lgi.require,
}
