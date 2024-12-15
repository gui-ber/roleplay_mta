--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
timerOpen = {}
allowTrade = {}
shopMarkers = {}
shopItems = {}
inventory = {}
capacity = {}
executeSQLQuery("CREATE TABLE IF NOT EXISTS inventario_players (id INTEGER, items TEXT, capacity INTEGER)")
--------------------------------------------------------------------------------------------------------------------------------
local function toggleInventory(playerSource)
    if not timerOpen[playerSource] or (getTickCount() - timerOpen[playerSource][1]) > timerOpen[playerSource][2] then
        if Tradding[playerSource] then
            triggerClientEvent(playerSource, "RenderInventory", resourceRoot, inventory[playerSource], "trade", Tradding[playerSource])
        else
            local have = false
            for i, v in pairs(Dropped) do
                local int = getElementInterior(Dropped[i]["objeto"])
                local dim = getElementDimension(Dropped[i]["objeto"])
                if (getElementInterior(playerSource) == int and getElementDimension(playerSource) == dim) then
                    local x, y, z = getElementPosition(playerSource)
                    if getDistanceBetweenPoints3D(x, y, z, Dropped[i]["posição"][1], Dropped[i]["posição"][2], Dropped[i]["posição"][3]) <= 1 then
                        triggerClientEvent(playerSource, "RenderInventory", resourceRoot, inventory[playerSource], "trash", {Dropped[i]["itens"], i})
                        have = true
                    end
                end
            end
            for i, v in ipairs(shopMarkers) do
                if isElementWithinMarker(playerSource, v) then
                    local int = getElementInterior(v)
                    local dim = getElementDimension(v)
                    if (getElementInterior(playerSource) == int and getElementDimension(playerSource) == dim) then
                        have = true
                        triggerClientEvent(playerSource, "RenderInventory", resourceRoot, inventory[playerSource], "shop", {shopItems[i], i, shops[i]["name"]})
                    end
                end
            end
            if not have then
                triggerClientEvent(playerSource, "RenderInventory", resourceRoot, inventory[playerSource])
            end
        end
        timerOpen[playerSource] = {}
        timerOpen[playerSource][1] = getTickCount()
        timerOpen[playerSource][2] = 1000
    end
end
--------------------------------------------------------------------------------------------------------------------------------
local function onQuit()
    if not isGuestAccount(getPlayerAccount(source)) then
        local id_ = getElementData(source, "player:infos")["id"] or false
        local data = executeSQLQuery("SELECT items FROM inventario_players WHERE id=?", id_)
        local inv_ = inventory[source]
        local cap_ = capacity[source]
        if (#data) > 0 then
            executeSQLQuery("UPDATE inventario_players SET items=?, capacity=? WHERE id=?", toJSON(inv_), cap_, id_)
        else
            executeSQLQuery("INSERT INTO inventario_players(id, items, capacity) VALUES(?,?,?)", id_, toJSON(inv_), cap_)
        end
    end
end
addEventHandler("onPlayerQuit", root, onQuit)
--------------------------------------------------------------------------------------------------------------------------------
local function onLogin()
    setTimer(function(playerSource)
        allowTrade[playerSource] = true
        local id_ = getElementData(playerSource, "player:infos")["id"] or false
        local data = executeSQLQuery("SELECT items, capacity FROM inventario_players WHERE id=?", id_)
        if (#data) > 0 then
            inventory[playerSource] = fromJSON(data[1]["items"])
            capacity[playerSource] = data[1]["capacity"]
        else
            inventory[playerSource] = {}
            capacity[playerSource] = 10
        end
        bindKey(playerSource, "i", "down", toggleInventory)
        triggerClientEvent(playerSource, "Refresh", resourceRoot, "inv", inventory[playerSource], capacity[playerSource])
    end, 1000, 1, source)
end
addEventHandler("onPlayerLogin", root, onLogin)
--------------------------------------------------------------------------------------------------------------------------------
local function onStop()
    for _, players in pairs(getElementsByType("player")) do
        if not isGuestAccount(getPlayerAccount(players)) then
            local id_ = getElementData(players, "player:infos")["id"] or false
            local data = executeSQLQuery("SELECT * FROM inventario_players")
            local inv_ = inventory[players]
            local cap_ = capacity[players]
            if (#data) > 0 then
                for i, v in pairs(data) do
                    if data[i]["id"] == id_ then
                        if (#data[i]["items"]) > 0 then
                            executeSQLQuery("UPDATE inventario_players SET items=?, capacity=? WHERE id=?", toJSON(inv_), cap_, id_)
                        else
                            executeSQLQuery("INSERT INTO inventario_players(id, items, capacity) VALUES(?,?,?)", id_, toJSON(inv_), cap_)
                        end
                    end
                end
            else
                executeSQLQuery("INSERT INTO inventario_players(id, items, capacity) VALUES(?,?,?)", id_, toJSON(inv_), cap_)
            end
        end
    end
end
--addEventHandler("onResourceStop", resourceRoot, onStop)
--------------------------------------------------------------------------------------------------------------------------------
local function onStart()
    setTimer(function()
        executeSQLQuery("CREATE TABLE IF NOT EXISTS inventario_players (id INTEGER, items TEXT, capacity INTEGER)")
        local data = executeSQLQuery("SELECT * FROM inventario_players")
        for _, players in pairs(getElementsByType("player")) do
            if not isGuestAccount(getPlayerAccount(players)) then
                allowTrade[players] = true
                local have = false
                local data_ = getElementData(players, "player:infos") or {}
                local id_ = data_["id"] or false
                for i, v in pairs(data) do
                    if data[i]["id"] == id_ then
                        inventory[players] = fromJSON(data[i]["items"])
                        capacity[players] = data[i]["capacity"]
                        have = true
                    end
                end
                if not have then
                    inventory[players] = {}
                    capacity[players] = 10
                end
                if data_["premium"] then
                    capacity[players] = 50
                end
                bindKey(players, "i", "down", toggleInventory)
                triggerClientEvent(players, "Refresh", resourceRoot, "inv", inventory[players], capacity[players])
            end
        end
        for i, v in ipairs(shops) do
            shopMarkers[i] = createMarker(shops[i]["position"][1], shops[i]["position"][2], shops[i]["position"][3], "corona", 1.5, 30, 144, 255, 150)
            setElementInterior(shopMarkers[i], shops[i]["position"][4])
            setElementDimension(shopMarkers[i], shops[i]["position"][5])
            if shops[i]["blip"] then
                createBlipAttachedTo(shopMarkers[i], shops[i]["blip"])
            end
            shopItems[i] = shops[i]["items"]
        end
    end, 1000, 1)
end
--addEventHandler("onResourceStart", resourceRoot, onStart)
--------------------------------------------------------------------------------------------------------------------------------
local function refreshTrade(playerSource, state)
    allowTrade[playerSource] = data
end
addEvent("RefreshTrade", true)
addEventHandler("RefreshTrade", resourceRoot, refreshTrade)
--------------------------------------------------------------------------------------------------------------------------------