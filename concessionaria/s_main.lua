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
timer = {}
executeSQLQuery("CREATE TABLE IF NOT EXISTS concessionaria_estoque(id INTEGER, qntd INTEGER)")
--------------------------------------------------------------------------------------------------------------------------------]]
local function onStart()
    setTimer(function()
        executeSQLQuery("CREATE TABLE IF NOT EXISTS concessionaria_estoque(id INTEGER, qntd INTEGER)")
        for i, v in pairs(vehicles) do
            for index, value in ipairs(vehicles[i]) do
                local id_ = vehicles[i][index]["id"]
                local data = executeSQLQuery("SELECT qntd FROM concessionaria_estoque WHERE id=?", id_)
                if (#data == 0) then
                    executeSQLQuery("INSERT INTO concessionaria_estoque(id,qntd) VALUES(?,?)", id_, 0)
                end
            end
        end
    end, 1000, 1)
end
addEventHandler("onResourceStart", resourceRoot, onStart)
--------------------------------------------------------------------------------------------------------------------------------
local function onHit(playerSource)
    if getElementType(playerSource) == "player" and not isPedInVehicle(playerSource) then
        if not timer[playerSource] or (getTickCount() - timer[playerSource]) >= 15000 then
            if not isGuestAccount(getPlayerAccount(playerSource)) then
                for i, v in ipairs(markers) do
                    if markers[i]["marker"] == source then
                        local type = markers[i]["type"]
                        local data = executeSQLQuery("SELECT * FROM concessionaria_estoque")
                        triggerClientEvent(playerSource, "RenderConce", resourceRoot, type, data)
                        timer[playerSource] = getTickCount()
                        break
                    end
                end
            end
        else
            exports.infobox:addNotification(playerSource, "Aguarde para acessar a concessionária novamente", "error")
        end
    end
end
--------------------------------------------------------------------------------------------------------------------------------]]
for i, v in pairs(positions) do
    markers[i] = {}
    markers[i]["marker"] = createMarker(positions[i]["positions"]["x"], positions[i]["positions"]["y"], positions[i]["positions"]["z"] - 1, "cylinder", 2, 30, 144, 255, 100)
    markers[i]["type"] = positions[i]["type"]
    addEventHandler("onMarkerHit", markers[i]["marker"], onHit)
end
--------------------------------------------------------------------------------------------------------------------------------
function buyVehicle(playerSource, veh, conce, moeda, r, g, b)
    if moeda == "money" then
        if getPlayerMoney(playerSource) >= vehicles[conce][veh]["price"]["money"] then
            local data_player = getElementData(playerSource, "player:infos") or {}
            local id = data_player and data_player["id"] or false
            local vip = data_player and data_player["tag"] == "premium" or false
            local data = exports.garagem:getVehicles(id)
            if (#data) < 3 or vip then
                if (#data) < 6 then
                    if getLimit(veh, conce) < vehicles[conce][veh]["limit"] then
                        changeLimit(veh, conce, "add")
                        takePlayerMoney(playerSource, vehicles[conce][veh]["price"]["money"])
                        exports.garagem:addVehicle(playerSource, vehicles[conce][veh]["id"], r, g, b)
                        exports.infobox:addNotification(playerSource, "Você adquiriu o veículo '"..vehicles[conce][veh]["name"].."' por '$"..vehicles[conce][veh]["price"]["money"].."'", "success")
                        exports.infobox:addNotification(playerSource, "O veículo já está disponível na sua garagem para uso", "info")
                    else
                        exports.infobox:addNotification(playerSource, "O estoque deste veículo acabou", "error")
                    end
                else
                    exports.infobox:addNotification(playerSource, "Você alcançou o limite máximo de veículos", "error")
                end
            else
                exports.infobox:addNotification(playerSource, "Você alcançou o limite máximo de veículos", "error")
            end
        else
            exports.infobox:addNotification(playerSource, "Você não possui dinheiro suficiente", "error")
        end
    elseif moeda == "coin" then
        local data_money = getElementData(playerSource, "player:money") or {}
        local coins = data_money and data_money["coins"] or 0
        local bank = data_money and data_money["bank"] or 0
        if coins >= vehicles[conce][veh][4] then
            local data_player = getElementData(playerSource, "player:infos") or {}
            local id = data_player and data_player["id"] or false
            local vip = data_player and data_player["tag"] == "premium" or false
            local data = exports.garagem:getVehicles(id)
            if (#data) < 3 or vip then
                if (#data) < 6 then
                    if getLimit(veh, conce) < vehicles[conce][veh]["limit"] then
                        changeLimit(veh, conce, "add")
                    end
                    coins = coins - vehicles[conce][veh]["price"]["coin"]
                    setElementData(playerSource, "player:money", {["coins"] = coins, ["bank"] = bank})
                    exports.garagem:addVehicle(playerSource, vehicles[conce][veh]["id"], r, g, b)
                    exports.infobox:addNotification(playerSource, "Você adquiriu o veículo '"..vehicles[conce][veh]["name"].."' por '"..vehicles[conce][veh]["price"]["coin"].."' Coins", "success")
                    exports.infobox:addNotification(playerSource, "O veículo já está disponível na sua garagem para uso", "info")
                else
                    exports.infobox:addNotification(playerSource, "Você alcançou o limite máximo de veículos", "error")
                end
            else
                exports.infobox:addNotification(playerSource, "Você alcançou o limite máximo de veículos", "error")
            end
        else
            exports.infobox:addNotification(playerSource, "Você não possui Coins suficientes", "error")
        end
    end
end 
addEvent("BuyVehicle", true)
addEventHandler("BuyVehicle", resourceRoot, buyVehicle)
--------------------------------------------------------------------------------------------------------------------------------
function testDrive(playerSource, conce_id, veh_id, color_id)
    toggleControl(playerSource, "enter_exit", false)
    local x, y, z = getElementPosition(playerSource)
    local dimension = math.random(1, 9999)
    local vehicle = createVehicle(vehicles[conce_id][veh_id]["id"], 1403.816, -2601.114, 13.547, 0, 0, 270)
    setVehicleColor(vehicle, colors[color_id][1], colors[color_id][2], colors[color_id][3])
    setVehicleDamageProof(vehicle, true)
    setElementDimension(vehicle, dimension)
    setElementDimension(playerSource, dimension)
    warpPedIntoVehicle(playerSource, vehicle)
    setVehicleEngineState(vehicle, true)
    setCameraTarget(playerSource, playerSource)
    exports.infobox:addNotification(playerSource, "Seu test-drive acaba em 30 segundos", "info")
    setTimer(function()
        toggleAllControls(playerSource, true)
        removePedFromVehicle(playerSource)
        setElementDimension(playerSource, 0)
        setElementPosition(playerSource, x, y, z)
        destroyElement(vehicle)
        exports.infobox:addNotification(playerSource, "Seu test-drive chegou ao fim", "info")
    end, 30000, 1)
end
addEvent("TestDrive", true)
addEventHandler("TestDrive", resourceRoot, testDrive)
--------------------------------------------------------------------------------------------------------------------------------
function getLimit(selected, conce)
    local result = executeSQLQuery("SELECT qntd FROM concessionaria_estoque WHERE id=?", vehicles[conce][selected]["id"])
    return result[1]["qntd"]
end
--------------------------------------------------------------------------------------------------------------------------------
function changeLimit(selected, conce, type)
    if type == "add" then
        executeSQLQuery("UPDATE concessionaria_estoque SET qntd=? WHERE id=?", getLimit(selected, conce) + 1, vehicles[conce][selected]["id"])
    elseif type == "take" then
        executeSQLQuery("UPDATE concessionaria_estoque SET qntd=? WHERE id=?", getLimit(selected, conce) - 1, vehicles[conce][selected]["id"])
    end
end
--------------------------------------------------------------------------------------------------------------------------------