--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
markers = {}
--------------------------------------------------------------------------------------------------------------------------------
for i, v in pairs(positions) do
    markers[i] = createMarker(positions[i][1], positions[i][2], positions[i][3]-1, "cylinder", 1.25, 30, 144, 255, 80)
end
--------------------------------------------------------------------------------------------------------------------------------
function markerHit(playerSource)
    for i, v in pairs(markers) do
        if v == source then
            if getElementType(playerSource) == "player" and not isPedInVehicle(playerSource) then
                if isInACL(playerSource, positions[i][4]) then
                    local _, _, rot = getElementRotation(playerSource)
                    local veh = createVehicle(490, positions[i][1], positions[i][2], positions[i][3], 0, 0, rot-180)
                    warpPedIntoVehicle(playerSource, veh)
                    setElementData(veh, "Skin", "files/"..i..".png")
                end
            end
        end
    end
end
addEventHandler("onMarkerHit", root, markerHit)
--------------------------------------------------------------------------------------------------------------------------------