--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
local markers = {}
--------------------------------------------------------------------------------------------------------------------------------
function addMarker(type, x, y, z, size, int, dim)
    local marker = {["type"] = type, ["pos"] = {x, y, z}, ["size"] = size,  ["int"] = int, ["dim"] = dim}
    table.insert(markers, marker)
    triggerClientEvent(root, "UpdateMarkers", resourceRoot, "new", marker)
end
--------------------------------------------------------------------------------------------------------------------------------
local function onLogin()
    setTimer(function(source)
        triggerClientEvent(source, "UpdateMarkers", resourceRoot, "login", markers)
    end, 1500, 1, source)
end
addEventHandler("onPlayerLogin", root, onLogin)
--------------------------------------------------------------------------------------------------------------------------------