local util = {}

function util.src(path)
	local str = debug.getinfo(2, "S").source:sub(2)
	local src = str:match("(.*/)") or str:match("(.*\\)") or "./"
	return src .. path
end

---@generic T, R
---@param arr T[]
---@param func fun(T, integer): R
---@return R[]
function util.map(arr, func)
	local new_arr = {}
	for i, v in ipairs(arr) do
		new_arr[i] = func(v, i)
	end
	return new_arr
end

return util
