local placeId = tostring(game.PlaceId or "unknown")
local url = ("https://raw.githubusercontent.com/GlibShark/SilverWare/refs/heads/main/place/%s.lua"):format(placeId)

local ok, body = pcall(function() return game:HttpGet(url) end)
if not ok or not body or body == "" then
    warn(("cant load sorry %s"):format(url))
    return
end

local fn, err = loadstring(body)
if not fn then
    error(("cant execute sorry %s"):format(tostring(err)))
end

pcall(fn)