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
local textures = {
    ["circle"] = dxCreateTexture("assets/gfx/circle.png"),
    ["door"] = dxCreateTexture("assets/gfx/door.png"),
}
--------------------------------------------------------------------------------------------------------------------------------
function updateMarkers(type, data)
    if type == "new" then
        table.insert(markers, data)
    elseif type == "login" then
        markers = data
    end
end
addEvent("UpdateMarkers", true)
addEventHandler("UpdateMarkers", resourceRoot, updateMarkers)
--------------------------------------------------------------------------------------------------------------------------------
addEventHandler("onClientRender", root, function()
    for i, v in pairs(markers) do
        local int = v["int"]
        local dim = v["dim"]
        if getElementInterior(localPlayer) == int and getElementDimension(localPlayer) == dim then
            local x, y, z = unpack(v["pos"])
            local x2, y2, z2 = getElementPosition(localPlayer)
            local distance = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
            if distance <= 50 then
                local image = textures[v["type"]]
                local circle = textures["circle"]
                local x3, y3, z3 = getCameraMatrix(localPlayer)
                local size = v["size"]
                dxDrawMaterialLine3D(x + size, y + size, z - 0.995, x - size, y - size, z - 0.995, circle, size * 2.75, tocolor(255, 255, 255, 255), false, x, y, z)
                dxDrawMaterialLine3D(x, y, z - 0.4 + (size * 2.5), x, y, z - 0.4, image, size * 2.5, tocolor(255, 255, 255, 255))
            end
        end
    end
end)
--------------------------------------------------------------------------------------------------------------------------------