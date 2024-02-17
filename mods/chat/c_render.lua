--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
local table_messages = {}
--------------------------------------------------------------------------------------------------------------------------------
function showMessage(player, message, type)
    if type ~= "say" or player ~= localPlayer then
        local have = false
        if not table_messages[player] then
            table_messages[player] = {}
        else
            for i, v in pairs(table_messages[player]) do
                if v[4] == message then
                    have = true
                    break
                end
            end
        end
        if not have then
            local tick = getTickCount()
            local time = nil
            if type == "trigger" then
                time = math.max(10000, math.min(25000, (#message) * (speed * 2)))
            elseif type == "action" then
                time = math.max(6000, math.min(15000, (#message) * (speed * 1.5)))
            elseif type == "say" then
                time = math.max(3500, math.min(10000, (#message) * speed))
            end
            table.insert(table_messages[player], {type, tick, time, message})
        end
    end
end
addEvent("triggerMessage", true)
addEventHandler("triggerMessage", resourceRoot, showMessage)
--------------------------------------------------------------------------------------------------------------------------------
addEventHandler("onClientRender", root, function()
    if getElementAlpha(localPlayer) ~= 254 then
        local camX, camY, camZ = getCameraMatrix()
        for i, v in pairs(table_messages) do
            local posX, posY, posZ = getElementPosition(i)
            local screenX, screenY = getScreenFromWorldPosition(posX, posY, posZ, 0.1)
            local dist = getDistanceBetweenPoints3D(posX, posY, posZ, camX, camY, camZ)
            if screenX and dist < 20 and isLineOfSightClear(posX, posY, posZ, camX, camY, camZ, true, false, false, true, false) then
                local offset = 0
                for index, value in pairs(table_messages[i]) do
                    local type = value[1]
                    local tick = value[2]
                    local time = value[3]
                    local message = value[4]
                    local width = dxGetTextWidth(message, 1, "default-bold")
                    local size = math.min(1.00, (15 / dist) * 0.6)
                    dxDrawRectangle(screenX - 5 - (width/2) * size, screenY - 10 * size + offset * size, (width + 10) * size, 20 * size, tocolor(20, 20, 20, 255), false)
                    dxDrawText(message, screenX, screenY + offset * size, screenX, screenY + offset * size, types[type]["color"], size, "default-bold", "center", "center", false, false, false, false, false)
                    offset = offset - 25
                    if (getTickCount() - tick) >= time then
                        table.remove(table_messages[i], index)
                    end
                end
            end
            if (#table_messages[i]) < 1 then
                table_messages[i] = nil
            end
        end
    end
end)
--------------------------------------------------------------------------------------------------------------------------------