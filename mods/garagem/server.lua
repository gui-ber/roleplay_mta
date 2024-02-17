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
spawned = {}
timer1 = {}
timer2 = {}
executeSQLQuery("CREATE TABLE IF NOT EXISTS garagem_veiculos(id INTEGER PRIMARY KEY, dono INTEGER, modelo INTEGER, placa INTEGER, cor TEXT, saude INTEGER, gas INTEGER, mala TEXT, patio INTEGER, rastreador INTEGER, seguro INTEGER, debitos INTEGER, queixa INTEGER, lataria TEXT, tuning TEXT)")
--------------------------------------------------------------------------------------------------------------------------------]]
function onStart()
    setTimer(function()
        executeSQLQuery("CREATE TABLE IF NOT EXISTS garagem_veiculos(id INTEGER PRIMARY KEY, dono INTEGER, modelo INTEGER, placa INTEGER, cor TEXT, saude INTEGER, gas INTEGER, mala TEXT, patio INTEGER, rastreador INTEGER, seguro INTEGER, debitos INTEGER, queixa INTEGER, lataria TEXT, tuning TEXT)")
    end, 1000, 1)
end
addEventHandler("onResourceStart", resourceRoot, onStart)
--------------------------------------------------------------------------------------------------------------------------------]]
for i, v in pairs(garagens) do
    markers[i] = createMarker(garagens[i][1], garagens[i][2], garagens[i][3]-1, "cylinder", 2, 30, 144, 255, 100)
end
--------------------------------------------------------------------------------------------------------------------------------
function onMarker(playerSource)
    for i, v in pairs(markers) do
        if v == source then
            if getElementType(playerSource) == "player" and not isPedInVehicle(playerSource) then
                if not isGuestAccount(getPlayerAccount(playerSource)) then
                    if not timer1[playerSource] or (getTickCount() - timer1[playerSource]) >= 15000 then
                        local id = getElementData(playerSource, "player:infos")["id"]
                        local data = getVehicles(id)
                        if (#data) > 0 then
                            triggerClientEvent(playerSource, "RenderGaragem", resourceRoot, data)
                        else
                            exports.infobox:addNotification(playerSource, "Você não possui nenhum veículo", "error")
                        end
                        timer1[playerSource] = getTickCount()
                        break
                    else
                        exports.infobox:addNotification(playerSource, "Aguarde para acessar a garagem novamente", "error")
                    end
                end
            elseif getElementType(playerSource) == "vehicle" then
                for index, _ in pairs(spawned) do
                    if spawned[index] == playerSource then
                        local player = getVehicleController(playerSource)
                        if not timer2[player] or (getTickCount() - timer2[player]) >= 3000 then
                            exports.infobox:addNotification(player, "Você guardou o veículo na garagem", "success")
                            destroyElement(playerSource)
                            spawned[index] = nil
                        end
                    end
                end
            end
        end
    end
end 
addEventHandler("onMarkerHit", root, onMarker)
--------------------------------------------------------------------------------------------------------------------------------
function pickVehicle(playerSource, selected)
    local id_ = getElementData(playerSource, "player:infos")["id"]
    local veiculos = getVehicles(id_)
    if not isElement(spawned[veiculos[selected]["id"]]) then
        local x, y, z = getElementPosition(playerSource)
        local _, _, rot = getElementRotation(playerSource)
        local placa_ = veiculos[selected]["placa"]
        timer2[playerSource] = getTickCount()
        spawned[veiculos[selected]["id"]] = createVehicle(veiculos[selected]["modelo"], x, y, z+1, 0, 0, rot-180)
		setElementHealth(spawned[veiculos[selected]["id"]], veiculos[selected]["saude"])
        setVehiclePlateText(spawned[veiculos[selected]["id"]], placa_)
        setElementData(spawned[veiculos[selected]["id"]], "vehicle:fuel", veiculos[selected]["gas"])
        setElementData(spawned[veiculos[selected]["id"]], "vehicle:infos", {["plate"] = placa_, ["owner"] = id_})
        local cores = fromJSON(veiculos[selected]["cor"])
        setVehicleColor(spawned[veiculos[selected]["id"]], cores[1], cores[2], cores[3], cores[1], cores[2], cores[3])
        if getVehicleType(spawned[veiculos[selected]["id"]]) == "Automobile" then
            exports.inventario:updateTrunk(spawned[veiculos[selected]["id"]], fromJSON(veiculos[selected]["mala"]))
        end
        local danos = fromJSON(veiculos[selected]["lataria"])
        setVehicleWheelStates(spawned[veiculos[selected]["id"]], danos["roda"][1], danos["roda"][2], danos["roda"][3], danos["roda"][4])
        for i = 0, 5, 1 do
            setVehicleDoorState(spawned[veiculos[selected]["id"]], i, danos["portas"][i+1])
        end
        for i = 5, 6, 1 do
            setVehiclePanelState(spawned[veiculos[selected]["id"]], i, danos["parachoque"][i-4])
        end
        for i = 0, 3, 1 do
            setVehicleLightState(spawned[veiculos[selected]["id"]], i, danos["farol"][i+1])
        end
        warpPedIntoVehicle(playerSource, spawned[veiculos[selected]["id"]])
    else
        exports.infobox:addNotification(playerSource, "Este veículo não está na garagem", "error")
    end
end
addEvent("PickVehicle", true)
addEventHandler("PickVehicle", resourceRoot, pickVehicle)
--------------------------------------------------------------------------------------------------------------------------------
function refreshVehicle()
    if getElementType(source) == "vehicle" then
        for index, v in pairs(spawned) do
            if v == source then
                local r, g, b = getVehicleColor(source, true)
                local cor_ = {r, g, b}
                local saude_ = getElementHealth(source)
                local gas_ = getElementData(source, "vehicle:fuel") or 0
                local mala_ = exports.inventario:getTrunk(source)
                local lataria_ = {}
                lataria_["roda"] = {}
                lataria_["portas"] = {}
                lataria_["parachoque"] = {}
                lataria_["farol"] = {}
                local r1, r2, r3, r4 = getVehicleWheelStates(source)
                lataria_["roda"][1] = r1
                lataria_["roda"][2] = r2
                lataria_["roda"][3] = r3
                lataria_["roda"][4] = r4
                for i = 0, 5, 1 do
                    lataria_["portas"][i+1] = getVehicleDoorState(source, i)
                end
                for i = 5, 6, 1 do
                    lataria_["parachoque"][i-4] = getVehiclePanelState(source, i)
                end
                for i = 0, 3, 1 do
                    lataria_["farol"][i+1] = getVehicleLightState(source, i)
                end
                exports.inventario:updateTrunk(source, "remove")
                executeSQLQuery("UPDATE garagem_veiculos SET cor=?,saude=?,gas=?,mala=?,lataria=? WHERE id=?", toJSON(cor_), saude_, gas_, toJSON(mala_), toJSON(lataria_), index)
                spawned[index] = nil
            end
        end
    end
end
addEventHandler("onElementDestroy", root, refreshVehicle)
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
function addVehicle(player, modelo_, r, g, b)
    local dono_ = getElementData(player, "player:infos")["id"]
    local placa_ = getNewPlate()
    local cor_ = {r, g, b}
    local gas_ = math.random(20, 50)
    local mala_ = {}
    local lataria_ = {["portas"] = {0, 0, 0, 0, 0, 0}, ["roda"] = {0, 0, 0, 0}, ["farol"] = {0, 0, 0, 0}, ["parachoque"] = {0, 0}}
    local tuning_ = {0, 0, 0, 0, 0, 0}
    executeSQLQuery("INSERT INTO garagem_veiculos(dono, modelo, placa, cor, saude, gas, mala, patio, rastreador, seguro, debitos, queixa, lataria, tuning) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)", dono_, modelo_, placa_, toJSON(cor_), 1000, gas_, toJSON(mala_), 0, 0, 0, 0, 0, toJSON(lataria_), toJSON(tuning_))
end
--------------------------------------------------------------------------------------------------------------------------------
function removeVehicle(id_)
    executeSQLQuery("DELETE FROM garagem_veiculos WHERE id=?", id_)
end
--------------------------------------------------------------------------------------------------------------------------------
function transferVehicle(id_, new)
    executeSQLQuery("UPDATE garagem_veiculos SET dono=? WHERE id=?", new, id_)
end
--------------------------------------------------------------------------------------------------------------------------------
function getVehicles(id_)
    local dados = executeSQLQuery("SELECT * FROM garagem_veiculos WHERE dono=?", id_) or 0
    return dados
end
--------------------------------------------------------------------------------------------------------------------------------
function getNewPlate()
    local letters = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"}
    for i = 1, 99 do
        local random1, random2, random3 = math.random(1, 26), math.random(1, 26), math.random(1, 26)
        local random4 = math.random(1000, 9999)
        local placa_ = tostring(letters[random1]..letters[random2]..letters[random3].." "..random4)
        local dados = executeSQLQuery("SELECT * FROM garagem_veiculos WHERE placa=?", placa_)
        if (#dados) == 0 then
            return placa_
        end
    end
end
--------------------------------------------------------------------------------------------------------------------------------