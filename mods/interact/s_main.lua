--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
local cursor = {}
--------------------------------------------------------------------------------------------------------------------------------
local function toggleCursor(playerSource)
    if cursor[playerSource] then
        showCursor(playerSource, false)
        cursor[playerSource] = false
    else
        showCursor(playerSource, true)
        cursor[playerSource] = true
    end
end
--------------------------------------------------------------------------------------------------------------------------------
local function onClicked(button, state, playerSource)
    if cursor[playerSource] then
        if not isPedInVehicle(playerSource) then
            if button == "left" and state == "down" then
                local type = getElementType(source)
                if type ~= "object" then
                    --if source ~= playerSource then
                        if options[type] then
                            local x, y, z = getElementPosition(playerSource)
                            local rx, ry, rz = getElementPosition(source)
                            if getDistanceBetweenPoints3D(x, y, z, rx, ry, rz) <= options[type]["distance"] then
                                local tabela = {}
                                for i, v in ipairs(options[type]["actions"]) do
                                    if v["permission"](playerSource, source) then
                                        table.insert(tabela, i)
                                    end
                                end
                                if (#tabela) > 0 then
                                    triggerClientEvent(playerSource, "ShowPanel", resourceRoot, source, type, tabela, options[type]["distance"])
                                end
                            end
                        end
                    --end
                else
                    local data = getElementData(source, "object:interact")
                    if data then
                        local x, y, z = getElementPosition(playerSource)
                        local rx, ry, rz = getElementPosition(source)
                        if getDistanceBetweenPoints3D(x, y, z, rx, ry, rz) <= data["distance"] then
                            local tabela = {}
                            for i, v in ipairs(data["actions"]) do
                                local permission = false
                                if data["actions"][i]["permission"] == "all" then
                                    permission = true
                                elseif data["actions"][i]["permission"][1] == "item" then
                                    if exports.inventario:getItem(playerSource, data["actions"][i]["permission"][2]) >= 1 then
                                        permission = true
                                    end
                                elseif data["actions"][i]["permission"][1] == "group" then
                                    local data2 = getElementData(playerSource, "player:infos")
                                    if data2["group"] then
                                        for _, value in pairs(data["actions"][i]["permission"][2]) do
                                            if data2["group"] == value then
                                                permission = true
                                                break
                                            end
                                        end
                                    end
                                end
                                if permission then
                                    table.insert(tabela, i)
                                end
                            end
                            if (#tabela) > 0 then
                                triggerClientEvent(playerSource, "ShowPanel", resourceRoot, source, type, tabela, data["distance"], data)
                            end
                        end
                    end
                end
            end
        end
    end
end
addEventHandler("onElementClicked", root, onClicked)
--------------------------------------------------------------------------------------------------------------------------------
function actionUse(playerSource, clicked, type, action, distance)
    local x, y, z = getElementPosition(playerSource)
    local rx, ry, rz = getElementPosition(clicked)
    if getDistanceBetweenPoints3D(x, y, z, rx, ry, rz) <= distance then
        if type ~= "object" then
            if action == "trunk" then
                showCursor(playerSource, false)
                cursor[playerSource] = false
            end
            for _, v in ipairs(options[type]["actions"]) do
                if v["name"] == action then
                    v["function"](playerSource, clicked)
                end
            end
        else
            if action == "pick_drug" then
                exports.inventario:drug(playerSource, clicked, "pick")
            elseif action == "destroy" then
                exports.inventario:drug(playerSource, clicked, "destroy")
            end
        end
    end
end
addEvent("ActionUse", true)
addEventHandler("ActionUse", resourceRoot, actionUse)
--------------------------------------------------------------------------------------------------------------------------------
local function restart()
    for _, player in pairs(getElementsByType("player")) do
        bindKey(player, "q", "down", toggleCursor)
    end
end
addEventHandler("onResourceStart", resourceRoot, restart)
--------------------------------------------------------------------------------------------------------------------------------
local function login()
    bindKey(source, "q", "down", toggleCursor)
end
addEventHandler("onPlayerLogin", getRootElement(), login)
--------------------------------------------------------------------------------------------------------------------------------