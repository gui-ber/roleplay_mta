--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
local timerUse = {}
local itemUse = {}
local itemArma = {}
local trunk = {}
local drugs = {}
Tradding = {}
Dropped = {}
--------------------------------------------------------------------------------------------------------------------------------
local function PlaySound3D(playerSource, som, distance)
	if distance == "all" then
        triggerClientEvent(root, "playSound", resourceRoot, som, playerSource)
	else
		for _, players in pairs(getElementsByType("player")) do
			local x, y, z = getElementPosition(playerSource)
			local ex, ey, ez = getElementPosition(players)
			if getDistanceBetweenPoints3D(x, y, z, ex, ey, ez) <= distance then
                triggerClientEvent(players, "playSound", resourceRoot, som, playerSource)
			end
		end
	end
end
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
local function test(player, command, item)
    item_use[item](player)
end
addCommandHandler("testeuse", test)
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
function use(playerSource, item)
    if not timerUse[playerSource] or (getTickCount() - timerUse[playerSource][1]) > timerUse[playerSource][2] then
        if getItem(playerSource, item) >= 1 then
            if items[item]["type"] == "food" then
                if not itemArma[playerSource] then
                    if isElement(itemUse[playerSource]) then
                        destroyElement(itemUse[playerSource])
                        itemUse[playerSource] = nil
                    end
                    local x, y, z = getElementPosition(playerSource)
                    local tempo = items[item]["parameters"]["time"]
                    itemUse[playerSource] = createObject(items[item]["parameters"]["id"], x, y, z)
                    setObjectScale(itemUse[playerSource], items[item]["parameters"]["size"])
                    timerUse[playerSource] = {}
                    timerUse[playerSource][1] = getTickCount()
                    timerUse[playerSource][2] = tempo+1000
                    takeItem(playerSource, item, 1)
                    local dim = getElementDimension(playerSource)
                    local int = getElementInterior(playerSource)
                    setElementDimension(itemUse[playerSource], dim)
                    setElementInterior(itemUse[playerSource], int)
                    toggleControl(playerSource, "crouch", false)
                    toggleControl(playerSource, "jump", false)
                    toggleControl(playerSource, "fire", false)
                    toggleControl(playerSource, "action", false)
                    toggleControl(playerSource, "sprint", false)
                    setPedAnimation(playerSource, items[item]["parameters"]["animation"][1], items[item]["parameters"]["animation"][2], 0, true, true, true)
                    PlaySound3D(playerSource, items[item]["parameters"]["sound"], 20)
                    exports.progress:showProgress(playerSource, tempo/1000, items[item]["parameters"]["message"].." "..items[item]["name"])
                    exports.pAttach:attach(itemUse[playerSource], playerSource, items[item]["parameters"]["pAttach"][1], items[item]["parameters"]["pAttach"][2], items[item]["parameters"]["pAttach"][3], items[item]["parameters"]["pAttach"][4], items[item]["parameters"]["pAttach"][5], items[item]["parameters"]["pAttach"][6], items[item]["parameters"]["pAttach"][7])
                    setTimer(function()
                        exports.pAttach:detach(itemUse[playerSource])
                        destroyElement(itemUse[playerSource])
                        itemUse[playerSource] = nil
                        setPedAnimation(playerSource, items[item]["parameters"]["animation"][1], items[item]["parameters"]["animation"][2], 0, false, true, true, false, 300)
                        toggleControl(playerSource, "crouch", true)
                        toggleControl(playerSource, "jump", true)
                        toggleControl(playerSource, "fire", true)
                        toggleControl(playerSource, "action", true)
                        toggleControl(playerSource, "sprint", true)
                        if items[item]["parameters"]["stats"]["speed"] then
                            triggerClientEvent(playerSource, "SetGameSpeed", resourceRoot)
                        end
                        local data = getElementData(playerSource, "player:stats") or {}
                        local food = data["food"] or 0
                        local drink = data["drink"] or 0
                        local energy = data["energy"] or 0
                        if items[item]["parameters"]["stats"]["food"] then
                            food = math.min(100, food + items[item]["parameters"]["stats"]["food"])
                            if food == 100 then
                                setPedStat(playerSource, 21, getPedStat(playerSource, 21) + items[item]["parameters"]["stats"]["fat"])
                            end
                        end
                        if items[item]["parameters"]["stats"]["drink"] then
                            drink = math.min(100, drink + items[item]["parameters"]["stats"]["drink"])
                        end
                        if items[item]["parameters"]["stats"]["energy"] then
                            energy = math.min(100, energy + items[item]["parameters"]["stats"]["energy"])
                        end
                        setElementData(playerSource, "player:stats", {["food"] = food, ["drink"] = drink, ["energy"] = energy})
                    end, tempo, 1)
                else
                    exports.infobox:addNotification(playerSource, "Você não pode se alimentar enquanto possui um armamento equipado", "error")
                end
            elseif items[item]["type"] == "weapon" then
                if not itemArma[playerSource] then
                    local ammo = getItem(playerSource, items[item]["parameters"]["ammo"])
                    if ammo > 0 then
                        giveWeapon(playerSource, items[item]["parameters"]["id"], ammo + 1, true)
                        takeItem(playerSource, items[item]["parameters"]["ammo"], "all")
                    else
                        giveWeapon(playerSource, items[item]["parameters"]["id"], 1, true)
                    end
                    setControlState(playerSource, "fire", false)
                    setControlState(playerSource, "action", false)
                    PlaySound3D(playerSource, "pick", 20)
                    itemArma[playerSource] = item
                    toggleControl(playerSource, "next_weapon", false)
                    toggleControl(playerSource, "previous_weapon", false)
                    if items[item]["parameters"]["animation"] == "low" then
                        setPedAnimation(playerSource, "COLT45", "colt45_reload", -1, false, true, false, false, _, true)
                        timerUse[playerSource] = {}
                        timerUse[playerSource][1] = getTickCount()
                        timerUse[playerSource][2] = 1000
                    elseif items[item]["parameters"]["animation"] == "high" then
                        setPedAnimation(playerSource, "RIFLE", "RIFLE_load", -1, false, true, false, false, _, true)
                        setPedAnimationSpeed(playerSource, RIFLE_load, 2.0)
                        setTimer(function()
                            setPedAnimation(playerSource, "COLT45", "colt45_reload", -1, false, true, false, false, _, true)
                        end, 800, 1)
                        timerUse[playerSource] = {}
                        timerUse[playerSource][1] = getTickCount()
                        timerUse[playerSource][2] = 2300
                    end
                else
                    if itemArma[playerSource] == item then
                        timerUse[playerSource] = {}
                        timerUse[playerSource][1] = getTickCount()
                        timerUse[playerSource][2] = 1000
                        local ammo = getPedTotalAmmo(playerSource, items[item]["parameters"]["slot"])
                        if ammo > 1 then
                            giveItem(playerSource, items[item]["parameters"]["ammo"], ammo - 1)
                        end
                        setPedAnimation(playerSource, "COLT45", "sawnoff_reload", 600, false, true, false, false, _, true)
                        PlaySound3D(playerSource, "put", 20)
                        takeWeapon(playerSource, items[item]["parameters"]["id"])
                        itemArma[playerSource] = nil
                        toggleControl(playerSource, "next_weapon", true)
                        toggleControl(playerSource, "previous_weapon", true)
                    else
                        exports.infobox:addNotification(playerSource, "Guarde o(a) '"..items[itemArma[playerSource]]["name"].."' caso queira pegar outro equipamento", "info")
                    end
                end
            elseif items[item]["type"] == "weapon2" then
                if not itemArma[playerSource] then
                    giveWeapon(playerSource, items[item]["parameters"]["id"], items[item]["parameters"]["qntd"], true)
                    setControlState(playerSource, "fire", false)
                    setControlState(playerSource, "action", false)
                    PlaySound3D(playerSource, "put", 20)
                    itemArma[playerSource] = item
                    toggleControl(playerSource, "next_weapon", false)
                    toggleControl(playerSource, "previous_weapon", false)
                    setPedAnimation(playerSource, "COLT45", "sawnoff_reload", 600, false, true, false, false, _, true)
                    timerUse[playerSource] = {}
                    timerUse[playerSource][1] = getTickCount()
                    timerUse[playerSource][2] = 1000
                else
                    if itemArma[playerSource] == item then
                        if getPedWeapon(playerSource, items[item]["parameters"]["slot"]) == 0 or getPedTotalAmmo(playerSource, items[item]["parameters"]["slot"]) == 0 then
                            takeItem(playerSource, item, 1)
                        end
                        timerUse[playerSource] = {}
                        timerUse[playerSource][1] = getTickCount()
                        timerUse[playerSource][2] = 1000
                        setPedAnimation(playerSource, "COLT45", "sawnoff_reload", 600, false, true, false, false, _, true)
                        PlaySound3D(playerSource, "put", 20)
                        takeWeapon(playerSource, items[item]["parameters"]["id"])
                        itemArma[playerSource] = nil
                        toggleControl(playerSource, "next_weapon", true)
                        toggleControl(playerSource, "previous_weapon", true)
                    else
                        exports.infobox:addNotification(playerSource, "Guarde o(a) '"..items[itemArma[playerSource]]["name"].."' caso queira pegar outro equipamento", "info")
                    end
                end
            elseif items[item]["type"] == "skin" then
                local item2 = items[item]["parameters"]["item"]
                if getItem(playerSource, item2) >= 1 then
                    if not itemArma[playerSource] then
                        local ammo = getItem(playerSource, items[item]["parameters"]["ammo"])
                        if ammo > 0 then
                            giveWeapon(playerSource, items[item]["parameters"]["id"], ammo + 1, true)
                            takeItem(playerSource, items[item]["parameters"]["ammo"], "all")
                        else
                            giveWeapon(playerSource, items[item]["parameters"]["id"], 1, true)
                        end
                        setControlState(playerSource, "fire", false)
                        setControlState(playerSource, "action", false)
                        PlaySound3D(playerSource, "pick", 20)
                        itemArma[playerSource] = item2
                        toggleControl(playerSource, "next_weapon", false)
                        toggleControl(playerSource, "previous_weapon", false)
                        setElementData(playerSource, "Skin", item)
                        if items[item2]["parameters"]["animation"] == "low" then
                            setPedAnimation(playerSource, "COLT45", "colt45_reload", -1, false, true, false, false, _, true)
                            timerUse[playerSource] = {}
                            timerUse[playerSource][1] = getTickCount()
                            timerUse[playerSource][2] = 1000
                        elseif items[item2]["parameters"]["animation"] == "high" then
                            setPedAnimation(playerSource, "RIFLE", "RIFLE_load", -1, false, true, false, false, _, true)
                            setPedAnimationSpeed(playerSource, RIFLE_load, 2.0)
                            setTimer(function()
                                setPedAnimation(playerSource, "COLT45", "colt45_reload", -1, false, true, false, false, _, true)
                            end, 800, 1)
                            timerUse[playerSource] = {}
                            timerUse[playerSource][1] = getTickCount()
                            timerUse[playerSource][2] = 2300
                        end
                    else
                        if itemArma[playerSource] == item2 then
                            timerUse[playerSource] = {}
                            timerUse[playerSource][1] = getTickCount()
                            timerUse[playerSource][2] = 1000
                            local ammo = getPedTotalAmmo(playerSource, items[item]["parameters"]["slot"])
                            if ammo > 1 then
                                giveItem(playerSource, items[item]["parameters"]["ammo"], ammo - 1)
                            end
                            setPedAnimation(playerSource, "COLT45", "sawnoff_reload", 600, false, true, false, false, _, true)
                            PlaySound3D(playerSource, "put", 20)
                            itemArma[playerSource] = nil
                            takeWeapon(playerSource, items[item]["parameters"]["id"])
                            toggleControl(playerSource, "next_weapon", true)
                            toggleControl(playerSource, "previous_weapon", true)
                            if getElementData(playerSource, "Skin") then
                                setElementData(playerSource, "Skin", false)
                            end
                        else
                            exports.infobox:addNotification(playerSource, "Guarde o(a) '"..items[itemArma[playerSource]]["name"].."' caso queira pegar outro equipamento", "info")
                        end
                    end
                else
                    exports.infobox:addNotification(playerSource, "Você não possui '"..items[item2]["name"].."' em seu inventário", "error")
                end
            elseif items[item]["type"] == "bag" then
                local cap = items[item]["parameters"]
                if capacity[playerSource] < cap then
                    capacity[playerSource] = cap
                    takeItem(playerSource, item, 1)
                    exports.infobox:addNotification(playerSource, "Você equipou a '"..items[item]["name"].."' e aumentou +"..(cap - 10).." sua capacidade", "success")
                    triggerClientEvent(playerSource, "Refresh", resourceRoot, "inv", inventory[playerSource], capacity[playerSource])
                else
                    exports.infobox:addNotification(playerSource, "Você já tem uma mochila maior ou igual à esta equipada", "error")
                end
            else
                item_use[item](playerSource)
            end
        else
            exports.infobox:addNotification(playerSource, "Você não possui '"..items[item]["name"].."' em seu inventario", "error")
        end
    else
        exports.infobox:addNotification(playerSource, "Você já está realizando uma ação", "error")
    end
end
addEvent("UseItem", true)
addEventHandler("UseItem", resourceRoot, use)
--------------------------------------------------------------------------------------------------------------------------------
function trade(playerSource, data, tipo)
    if not timerUse[playerSource] or (getTickCount() - timerUse[playerSource][1]) > timerUse[playerSource][2] then
        if tipo == "send" then
            local player2 = data["subtitle"]
            local item = data["item"]
            local amount = data["amount"]
            local value = data["value"]
            if getItem(playerSource, item) >= amount then
                if items[item]["type"] ~= "skin" or items[item]["parameters"]["item"] ~= itemArma[playerSource] then
                    if not itemArma[playerSource] or itemArma[playerSource] ~= item then
                        if allowTrade[player2] then
                            if Tradding[player2] then
                                return exports.infobox:addNotification(playerSource, "Esta pessoa já está recebendo uma proposta", "error")
                            end
                            Tradding[player2] = {}
                            Tradding[player2]["player"] = playerSource
                            Tradding[player2]["item"] = item
                            Tradding[player2]["amount"] = amount
                            Tradding[player2]["value"] = value
                            exports.infobox:addNotification(player2, "Você recebeu uma proposta, abra seu inventário para conferir", "info")
                            exports.infobox:addNotification(playerSource, "Você enviou a proposta. Fique próximo da pessoa para que a troca seja efetuada com sucesso", "success")
                        else
                            exports.infobox:addNotification(playerSource, "Esta pessoa não está aceitando propostas", "error")
                        end
                    else
                        exports.infobox:addNotification(playerSource, "Você não pode propor a troca de um item que está em sua mão", "error")
                    end
                else
                    exports.infobox:addNotification(playerSource, "Você não pode propor esta troca com uma arma em mãos", "error")
                end
            else
                exports.infobox:addNotification(playerSource, "Você não possui "..amount.."x '"..items[item]["name"].."'", "error")
            end
        elseif tipo == "accept" then
            local player2 = Tradding[playerSource]["player"]
            local item = Tradding[playerSource]["item"]
            local amount = Tradding[playerSource]["amount"]
            local value = Tradding[playerSource]["value"]
            local x, y, z = getElementPosition(player2)
            local x2, y2, z2 = getElementPosition(playerSource)
            if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) <= 3 then
                if getItem(player2, item) >= amount then
                    if getPlayerMoney(playerSource) >= value then
                        if giveItem(playerSource, item, amount) then
                            takeItem(player2, item, amount)
                            takePlayerMoney(playerSource, value)
                            givePlayerMoney(player2, value)
                            exports.infobox:addNotification(player2, "A proposta foi aceita. O dinheiro já está disponível em sua carteira", "success")
                            exports.infobox:addNotification(playerSource, "Você aceitou a proposta de "..amount.."x '"..items[item]["name"].."' por $"..value, "success")
                            Tradding[playerSource] = nil
                        else
                            exports.infobox:addNotification(player2, "A proposta foi recusada pois o comprador não possuia espaço suficiente na mochila", "error")
                            exports.infobox:addNotification(playerSource, "Você não possui espaço suficiente na sua mochila", "error")
                            Tradding[playerSource] = nil
                        end
                    else
                        exports.infobox:addNotification(player2, "A proposta foi recusada pois o comprador não possuia dinheiro suficiente", "error")
                        exports.infobox:addNotification(playerSource, "Você não possui dinheiro suficiente", "error")
                        Tradding[playerSource] = nil
                    end
                else
                    exports.infobox:addNotification(player2, "Você não possui "..amount.."x '"..items[item]["name"].."'", "error")
                    exports.infobox:addNotification(playerSource, "A pessoa que enviou a proposta não possui mais o item", "error")
                    Tradding[playerSource] = nil
                end
            else
                exports.infobox:addNotification(player2, "Vocês estão muito distantes um do outro", "error")
                exports.infobox:addNotification(playerSource, "Vocês estão muito distantes um do outro", "error")
                Tradding[playerSource] = nil
            end
        elseif tipo == "recuse" then
            local player2 = Tradding[playerSource]["player"]
            exports.infobox:addNotification(player2, "A pessoa recusou a proposta", "warning")
            exports.infobox:addNotification(playerSource, "Você recusou a proposta", "success")
            Tradding[playerSource] = nil
        end
    else
        if tipo ~= "recuse" then
            exports.infobox:addNotification(playerSource, "Aguarde para poder realizar outra ação novamente", "error")
        else
            local player2 = Tradding[playerSource]["player"]
            exports.infobox:addNotification(player2, "A pessoa recusou a proposta", "warning")
            exports.infobox:addNotification(playerSource, "Você recusou a proposta", "success")
            Tradding[playerSource] = nil
        end
    end
end
addEvent("Trade", true)
addEventHandler("Trade", resourceRoot, trade)
--------------------------------------------------------------------------------------------------------------------------------
function drop(playerSource, data, tipo, id)
    if not timerUse[playerSource] or (getTickCount() - timerUse[playerSource][1]) > timerUse[playerSource][2] then
        if not isPedInVehicle(playerSource) then
            if tipo == "put" then
                if getItem(playerSource, data["item"]) >= data["amount"] then
                    if items[data["item"]]["type"] ~= "skin" or items[data["item"]]["parameters"]["item"] ~= itemArma[playerSource] then
                        if not itemArma[playerSource] or itemArma[playerSource] ~= data["item"] then
                            takeItem(playerSource, data["item"], data["amount"])
                            setPedAnimation(playerSource, "BSKTBALL", "BBALL_pickup", 1000, false, true, false, false, _, true)
                            exports.infobox:addNotification(playerSource, "Você jogou no chão "..data["amount"].."x '"..items[data["item"]]["name"].."'", "success")
                            local x, y, z = getElementPosition(playerSource)
                            local have = false
                            if id then
                                if Dropped[id] and isElement(Dropped[id]["objeto"]) then
                                    local int = getElementInterior(Dropped[id]["objeto"])
                                    local dim = getElementDimension(Dropped[id]["objeto"])
                                    if (getElementInterior(playerSource) == int and getElementDimension(playerSource) == dim) then
                                        local x2, y2, z2 = Dropped[id]["posição"][1], Dropped[id]["posição"][2], Dropped[id]["posição"][3]
                                        if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) <= 1 then
                                            local qntd = (#Dropped[id]["itens"] + 1)
                                            if qntd <= 60 then
                                                local have2 = false
                                                for i, _ in pairs(Dropped[id]["itens"]) do
                                                    if Dropped[id]["itens"][i][1] == data["item"] then
                                                        have = true
                                                        have2 = true
                                                        Dropped[id]["itens"][i][2] = Dropped[id]["itens"][i][2] + data["amount"]
                                                        resetTimer(Dropped[id]["timer"])
                                                        triggerClientEvent(playerSource, "Refresh", resourceRoot, "trash", Dropped[id]["itens"], id)
                                                        break
                                                    end
                                                end
                                                if not have2 then
                                                    have = true
                                                    table.insert(Dropped[id]["itens"], {data["item"], data["amount"]})
                                                    resetTimer(Dropped[id]["timer"])
                                                    triggerClientEvent(playerSource, "Refresh", resourceRoot, "trash", Dropped[id]["itens"], id)
                                                end
                                            end
                                        end
                                    end
                                    for _, players in pairs(getElementsWithinRange(Dropped[id]["posição"][1], Dropped[id]["posição"][2], Dropped[id]["posição"][3], 15, "player")) do
                                        if players ~= playerSource then
                                            exports.infobox:addNotification(players, getPlayerName(playerSource).." ("..(getElementData(playerSource, "ID") or "N/A")..") dropou "..data["amount"].."x '"..data["item"].."' próximo a você", "info")
                                        end
                                    end
                                end
                            end
                            if not have then
                                local total = (#Dropped) + 1
                                Dropped[total] = {}
                                Dropped[total]["posição"] = {}
                                Dropped[total]["itens"] = {}
                                Dropped[total]["objeto"] = {}
                                Dropped[total]["timer"] = {}
                                Dropped[total]["posição"][1], Dropped[total]["posição"][2], Dropped[total]["posição"][3] = x, y, z
                                table.insert(Dropped[total]["itens"], {data["item"], data["amount"]})
                                Dropped[total]["objeto"] = createObject(1264, x, y, z-0.8, 0, 0, 0)
                                local int = getElementInterior(playerSource)
                                local dim = getElementDimension(playerSource)
                                setElementInterior(Dropped[total]["objeto"], int)
                                setElementDimension(Dropped[total]["objeto"], dim)
                                setElementCollisionsEnabled(Dropped[total]["objeto"], false)
                                setObjectScale(Dropped[total]["objeto"], 0.375)
                                triggerClientEvent(playerSource, "Refresh", resourceRoot, "trash", Dropped[total]["itens"], total)
                                for _, players in pairs(getElementsWithinRange(Dropped[total]["posição"][1], Dropped[total]["posição"][2], Dropped[total]["posição"][3], 15, "player")) do
                                    if players ~= playerSource then
                                        exports.infobox:addNotification(players, getPlayerName(playerSource).." ("..(getElementData(playerSource, "ID") or "N/A")..") dropou "..data["amount"].."x '"..data["item"].."' próximo a você", "info")
                                    end
                                end
                                Dropped[total]["timer"] = setTimer(function()
                                    destroyElement(Dropped[total]["objeto"])
                                    Dropped[total] = nil
                                end, 30000, 1)
                            end
                        else
                            exports.infobox:addNotification(playerSource, "Você não pode dropar enquanto o item está em sua mão", "error")
                        end
                    else
                        exports.infobox:addNotification(playerSource, "Você não pode dropar este item com uma arma em mãos", "error")
                    end
                else
                    exports.infobox:addNotification(playerSource, "Você não possui "..data["amount"].."x '"..items[data["item"]]["name"].."'", "error")
                end
            elseif tipo == "pick" then
                local have = false
                if Dropped[id] and isElement(Dropped[id]["objeto"]) then
                    local int = getElementInterior(Dropped[id]["objeto"])
                    local dim = getElementDimension(Dropped[id]["objeto"])
                    if (getElementInterior(playerSource) == int and getElementDimension(playerSource) == dim) then
                        local x, y, z = getElementPosition(playerSource)
                        if getDistanceBetweenPoints3D(x, y, z, Dropped[id]["posição"][1], Dropped[id]["posição"][2], Dropped[id]["posição"][3]) <= 1 then
                            for index, value in pairs(Dropped[id]["itens"]) do
                                if value[1] == data["item"] then
                                    if value[2] >= data["amount"] then
                                        if giveItem(playerSource, data["item"], data["amount"]) then
                                            for _, players in pairs(getElementsWithinRange(Dropped[id]["posição"][1], Dropped[id]["posição"][2], Dropped[id]["posição"][3], 10, "player")) do
                                                if players ~= playerSource then
                                                    exports.infobox:addNotification(players, getPlayerName(playerSource).." ("..(getElementData(playerSource, "ID") or "N/A")..") coletou "..data["amount"].."x '"..items[data["item"]]["name"].."' do chão próximo a você", "info")
                                                end
                                            end
                                            exports.infobox:addNotification(playerSource, "Você coletou "..data["amount"].."x '"..items[data["item"]]["name"].."' do chão", "success")
                                            setPedAnimation(playerSource, "BSKTBALL", "BBALL_pickup", 1000, false, true, false, false, _, true)
                                            value[2] = value[2] - data["amount"]
                                            if value[2] <= 0 then
                                                table.remove(Dropped[id]["itens"], index)
                                                if (#Dropped[id]["itens"]) <= 0 then
                                                    killTimer(Dropped[id]["timer"])
                                                    destroyElement(Dropped[id]["objeto"])
                                                    Dropped[id] = nil
                                                    triggerClientEvent(playerSource, "Refresh", resourceRoot, "trash")
                                                else
                                                    triggerClientEvent(playerSource, "Refresh", resourceRoot, "trash", Dropped[id]["itens"], id)
                                                end
                                            else
                                                triggerClientEvent(playerSource, "Refresh", resourceRoot, "trash", Dropped[id]["itens"], id)
                                            end
                                        else
                                            exports.infobox:addNotification(playerSource, "Você não possui espaço suficiente na mochila", "error")
                                        end
                                    else
                                        exports.infobox:addNotification(playerSource, "Não há "..data["amount"].."x unidades deste item no chão", "error")
                                        if (#Dropped[id]["itens"]) > 0 then
                                            triggerClientEvent(playerSource, "Refresh", resourceRoot, "trash", Dropped[id]["itens"], id)
                                        else
                                            triggerClientEvent(playerSource, "Refresh", resourceRoot, "trash")
                                        end
                                    end
                                    have = true
                                end
                            end
                        end
                    end
                end
                if not have then
                    exports.infobox:addNotification(playerSource, "Este item não foi localizado no chão", "error")
                    if Dropped[id] and isElement(Dropped[id]["objeto"]) then
                        if (#Dropped[id]["itens"]) > 0 then
                            triggerClientEvent(playerSource, "Refresh", resourceRoot, "trash", Dropped[id]["itens"], id)
                        else
                            triggerClientEvent(playerSource, "Refresh", resourceRoot, "trash")
                        end
                    else
                        triggerClientEvent(playerSource, "Refresh", resourceRoot, "trash")
                    end
                end
            end
        end
    else
        exports.infobox:addNotification(playerSource, "Aguarde para poder realizar outra ação novamente", "error")
    end
end
addEvent("Drop", true)
addEventHandler("Drop", resourceRoot, drop)
--------------------------------------------------------------------------------------------------------------------------------
function shopBuy(playerSource, data, id)
    if not timerUse[playerSource] or (getTickCount() - timerUse[playerSource][1]) > timerUse[playerSource][2] then
        if not isPedInVehicle(playerSource) then
            for i, v in ipairs(shopItems[id]) do
                if v[1] == data["item"] then
                    if v[3] >= data["amount"] then
                        local price = v[2] * data["amount"]
                        if getPlayerMoney(playerSource) >= price then
                            if giveItem(playerSource, data["item"], data["amount"]) then
                                v[3] = v[3] - data["amount"]
                                takePlayerMoney(playerSource, price)
                                exports.infobox:addNotification(playerSource, "Você comprou "..data["amount"].."x '"..items[data["item"]]["name"].."' por $"..price, "success")
                                triggerClientEvent(playerSource, "Refresh", resourceRoot, "shop", shopItems[id])
                            else
                                exports.infobox:addNotification(playerSource, "Você não possui espaço suficiente na mochila", "error")
                            end
                        else
                            exports.infobox:addNotification(playerSource, "Você não possui dinheiro suficiente", "error")
                        end
                    else
                        exports.infobox:addNotification(playerSource, "A quantidade desejada não tem disponível em estoque", "error")
                    end
                    break
                end
            end
            timerUse[playerSource] = {}
            timerUse[playerSource][1] = getTickCount()
            timerUse[playerSource][2] = 1000
        end
    end           
end
addEvent("ShopBuy", true)
addEventHandler("ShopBuy", resourceRoot, shopBuy)
--------------------------------------------------------------------------------------------------------------------------------
function drug(playerSource, element, type)
    if type == "maconha" then
        exports.infobox:addNotification(playerSource, "Você realizou o plantio. Aguarde o crescimento da planta para colher", "success")
        local x, y, z = getElementPosition(playerSource)
        setElementPosition(playerSource, x, y, z + 1.5)
        local tabela = {
            ["pot"] = {},
            ["plant"] = {},
            ["type"] = {},
            ["tick"] = {},
        }
        tabela["type"] = "maconha"
        tabela["tick"] = getTickCount()
        tabela["pot"] = createObject(741, x, y + 1.65, z - 0.7, 0, 0, 0)
        local data = {
            ["distance"] = 2.5,
            ["name"] = "Plant. Verde",
            ["actions"] = {
                [1] = {["name"] = "pick_drug", ["title"] = "Colher", ["permission"] = {"group", {"Grove"}}},
                [2] = {["name"] = "destroy", ["title"] = "Destruir", ["permission"] = "all"},
            },
        }
        setElementData(tabela["pot"], "object:interact", data)
        tabela["plant"] = createObject(646, x - 0.1, y + 0.125, z - 0.75, 0, 0, 0)
        setElementCollisionsEnabled(tabela["plant"], false)
        local x1, y1, z1 = getElementPosition(tabela["plant"])
        moveObject(tabela["plant"], (drugTime*1000), x1, y1, z1 + 1.175)
        table.insert(drugs, tabela)
    elseif type == "cocaina" then
        exports.infobox:addNotification(playerSource, "Você realizou o plantio. Aguarde o crescimento da planta para colher", "success")
        local x, y, z = getElementPosition(playerSource)
        setElementPosition(playerSource, x, y, z + 1.5)
        local tabela = {
            ["pot"] = {},
            ["plant"] = {},
            ["type"] = {},
            ["tick"] = {},
        }
        tabela["type"] = "cocaina"
        tabela["tick"] = getTickCount()
        tabela["pot"] = createObject(741, x, y + 1.65, z - 0.7, 0, 0, 0)
        local data = {
            ["distance"] = 2.5,
            ["name"] = "Plant. Branca",
            ["actions"] = {
                [1] = {["name"] = "pick_drug", ["title"] = "Colher", ["permission"] = {"group", {"Bloods"}}},
                [2] = {["name"] = "destroy", ["title"] = "Destruir", ["permission"] = "all"},
            },
        }
        setElementData(tabela["pot"], "object:interact", data)
        tabela["plant"] = createObject(630, x + 0.04, y + 0.05, z - 0.75, 0, 0, 0)
        setElementCollisionsEnabled(tabela["plant"], false)
        setObjectScale(tabela["plant"], 0.7)
        local x1, y1, z1 = getElementPosition(tabela["plant"])
        moveObject(tabela["plant"], (drugTime*1000), x1, y1, z1 + 0.725)
        table.insert(drugs, tabela)
    elseif type == "pick" then
        for i, v in ipairs(drugs) do
            if drugs[i]["pot"] == element then
                if (getTickCount() - drugs[i]["tick"]) >= (drugTime*1000) then
                    local msg = nil
                    local item = nil
                    local qntd = nil
                    if drugs[i]["type"] == "maconha" then
                        qntd = craft["maconha_pe"]["give"]
                        msg = "Você colheu "..qntd.."x 'Pé de Maconha'"
                        item = "maconha_pe"
                    elseif drugs[i]["type"] == "cocaina" then
                        qntd = craft["cocaina_folha"]["give"]
                        msg = "Você colheu "..qntd.."x 'Folha de Coca'"
                        item = "cocaina_folha"
                    end
                    setPedAnimation(playerSource, "BOMBER", "BOM_Plant_Loop", 1000, false, false, false, false, _, true)
                    setTimer(function()
                        exports.infobox:addNotification(playerSource, msg, "success")
                        giveItem(playerSource, item, qntd)
                        destroyElement(drugs[i]["plant"])
                        destroyElement(drugs[i]["pot"])
                        table.remove(drugs, i)
                    end, 1000, 1)
                else
                    exports.infobox:addNotification(playerSource, "Aguarde o crescimento total da planta para realizar a colheita", "error")
                end
                break
            end
        end
    elseif type == "destroy" then
        for i, v in ipairs(drugs) do
            if drugs[i]["pot"] == element then
                setPedAnimation(playerSource, "ped", "FightA_G", 1500, true, false, false, false, _, true)
                setTimer(function()
                    exports.infobox:addNotification(playerSource, "Você destruiu a plantação de "..drugs[i]["type"], "success")
                    destroyElement(drugs[i]["plant"])
                    destroyElement(drugs[i]["pot"])
                    table.remove(drugs, i)
                end, 1500, 1)
            end
        end
    end
end
--------------------------------------------------------------------------------------------------------------------------------
function craft(playerSource, item, data)
    if not timerUse[playerSource] or (getTickCount() - timerUse[playerSource][1]) > timerUse[playerSource][2] then
        if not isPedInVehicle(playerSource) then
            local tabela = {}
            for i = 1, 9, 1 do
                if data["item"][i] ~= 0 then
                    table.insert(tabela, {data["item"][i], data["quantidade"][i]})
                end
            end
            local total = #tabela
            local qntd = 0
            for i, v in ipairs(tabela) do
                if getItem(playerSource, tabela[i][1]) >= tabela[i][2] then
                    qntd = qntd + 1
                end
            end
            if qntd == total then
                for i, v in ipairs(tabela) do
                    if craft[item]["take"][i] then
                        takeItem(playerSource, tabela[i][1], tabela[i][2])
                    else
                        local random = math.random(craft[item]["parameters"]["chance"][1], craft[item]["parameters"]["chance"][2])
                        if random == 1 then
                            takeItem(playerSource, tabela[i][1], tabela[i][2])
                            exports.infobox:addNotification(playerSource, craft[item]["parameters"]["msg"], "warning")
                        end
                    end
                end
                timerUse[playerSource] = {}
                timerUse[playerSource][1] = getTickCount()
                timerUse[playerSource][2] = craft[item]["tempo"]*1000
                setElementFrozen(playerSource, true)
                toggleAllControls(playerSource, false)
                setPedAnimation(playerSource, "BD_FIRE", "wash_up", craft[item]["tempo"]*1000, true, false, false, false, _, true)
                exports.progress:showProgress(playerSource, craft[item]["tempo"], "Craftando "..items[item]["name"])
                setTimer(function()
                    if not craft[item]["trigger"] then
                        giveItem(playerSource, item, craft[item]["give"])
                        exports.infobox:addNotification(playerSource, "Você craftou "..craft[item]["give"].."x '"..items[item]["name"].."'", "success")
                    else
                        drug(playerSource, _, craft[item]["trigger"])
                    end
                    setElementFrozen(playerSource, false)
                    toggleAllControls(playerSource, true)
                end, craft[item]["tempo"]*1000, 1)
            else
                exports.infobox:addNotification(playerSource, "Você não possui os itens ou quantidades suficientes para craftar", "error")
            end
        end
    else
        exports.infobox:addNotification(playerSource, "Aguarde para poder realizar outra ação novamente", "error")
    end
end
addEvent("StartCraft", true)
addEventHandler("StartCraft", resourceRoot, craft)
--------------------------------------------------------------------------------------------------------------------------------
function givetakeTrunk(playerSource, vehicle, type, item, qntd)
    if type == "put" then
        if getItem(playerSource, item) >= qntd then
            local peso = 0
            for i, v in ipairs(trunk[vehicle]) do
                if trunk[vehicle][i] then
                    local item_ = trunk[vehicle][i][1]
                    local qntd_ = trunk[vehicle][i][2]
                    peso = peso + (items[item_]["weight"] * qntd_)
                end
            end
            if peso + (items[item]["weight"] * qntd) <= 75 then
                local have = false
                for i, v in ipairs(trunk[vehicle]) do
                    if v[1] == item then
                        exports.infobox:addNotification(playerSource, "Você guardou "..qntd.."x '"..items[item]["name"].."' no porta-malas do veículo", "success")
                        v[2] = v[2] + qntd
                        takeItem(playerSource, item, qntd)
                        have = true
                        setVehicleDoorOpenRatio(vehicle, 1, 1, 300)
                        setTimer(function() setVehicleDoorOpenRatio(vehicle, 1, 0, 300) end, 600, 1)
                        triggerClientEvent(playerSource, "Refresh", resourceRoot, "trunk", trunk[vehicle], vehicle)
                    end
                end
                if not have then
                    if (#trunk[vehicle]) < 60 then
                        exports.infobox:addNotification(playerSource, "Você guardou "..qntd.."x '"..items[item]["name"].."' no porta-malas do veículo", "success")
                        table.insert(trunk[vehicle], {item, qntd})
                        takeItem(playerSource, item, qntd)
                        setVehicleDoorOpenRatio(vehicle, 1, 1, 300)
                        setTimer(function() setVehicleDoorOpenRatio(vehicle, 1, 0, 300) end, 600, 1)
                        triggerClientEvent(playerSource, "Refresh", resourceRoot, "trunk", trunk[vehicle], vehicle)
                    else
                        exports.infobox:addNotification(playerSource, "O porta-malas do veículo está cheio", "error")
                    end
                end
            else
                exports.infobox:addNotification(playerSource, "O porta-malas do veículo está cheio", "error")
            end
        else
            exports.infobox:addNotification(playerSource, "Você não possui "..qntd.."x '"..items[item]["name"].."' em sua mochila", "error")
        end
    elseif type == "pick" then
        local have = false
        for i, v in ipairs(trunk[vehicle]) do
            if v[1] == item then
                if v[2] >= qntd then
                    if giveItem(playerSource, item, qntd) then
                        exports.infobox:addNotification(playerSource, "Você pegou "..qntd.."x '"..items[item]["name"].."' do porta-malas do veículo", "success")
                        v[2] = v[2] - qntd
                        if v[2] <= 0 then
                            table.remove(trunk[vehicle], i)
                        end
                        local x, y, z = getElementPosition(vehicle)
                        for _, players in pairs(getElementsWithinRange(x, y, z, 10, "player")) do
                            if players ~= playerSource then
                                exports.infobox:addNotification(players, getPlayerName(playerSource).." ("..(getElementData(playerSource, "ID") or "N/A")..") coletou "..qntd.."x '"..items[item]["name"].."' de um porta-malas próximo a você", "info")
                            end
                        end
                        setVehicleDoorOpenRatio(vehicle, 1, 1, 300)
                        setTimer(function() setVehicleDoorOpenRatio(vehicle, 1, 0, 300) end, 600, 1)
                        triggerClientEvent(playerSource, "Refresh", resourceRoot, "trunk", trunk[vehicle], vehicle)
                    else
                        exports.infobox:addNotification(playerSource, "Você não possui espaço suficiente na mochila", "error")
                    end
                else
                    exports.infobox:addNotification(playerSource, "Não há "..qntd.."x unidades deste item no porta-malas", "error")
                    triggerClientEvent(playerSource, "Refresh", resourceRoot, "trunk", trunk[vehicle], vehicle)
                end
                have = true
            end
        end
        if not have then
            exports.infobox:addNotification(playerSource, "Este item não foi localizado no porta-malas", "error")
            triggerClientEvent(playerSource, "Refresh", resourceRoot, "trunk", trunk[vehicle], vehicle)
        end
    end
end
addEvent("Trunk", true)
addEventHandler("Trunk", resourceRoot, givetakeTrunk)
--------------------------------------------------------------------------------------------------------------------------------
function updateTrunk(vehicle, data)
    if data ~= "remove" then
        trunk[vehicle] = data
    else
        if trunk[vehicle] then
            trunk[vehicle] = nil
        end
    end
end
--------------------------------------------------------------------------------------------------------------------------------
function getTrunk(vehicle)
    if trunk[vehicle] then
        return trunk[vehicle]
    else
        return {}
    end
end
--------------------------------------------------------------------------------------------------------------------------------
function showTrunk(playerSource, vehicle)
    if trunk[vehicle] then
        if not getElementData(vehicle, "vehicle:locked") then
            triggerClientEvent(playerSource, "RenderInventory", resourceRoot, inventory[playerSource], "trunk", {trunk[vehicle], vehicle})
        else
            local infos = getElementData(vehicle, "vehicle:infos")
            local infos2 = getElementData(playerSource, "player:infos")
            if infos and infos2 and infos["owner"] == infos2["id"] then
                triggerClientEvent(playerSource, "RenderInventory", resourceRoot, inventory[playerSource], "trunk", {trunk[vehicle], vehicle})
            end
        end
    else
        exports.infobox:addNotification(playerSource, "Apenas veículos '4 rodas' adquiridos na concessionária possuem porta-malas", "error")
    end
end
--------------------------------------------------------------------------------------------------------------------------------
function getItem(playerSource, item)
    for i, _ in ipairs(inventory[playerSource]) do
        if inventory[playerSource][i][1] == tostring(item) then
            return inventory[playerSource][i][2]
        end
    end
    return 0
end
--------------------------------------------------------------------------------------------------------------------------------
function takeItem(playerSource, item, qntd)
    for i, _ in ipairs(inventory[playerSource]) do
        if inventory[playerSource][i][1] == tostring(item) then
            if qntd ~= "all" then
                inventory[playerSource][i][2] = inventory[playerSource][i][2] - tonumber(qntd)
                if inventory[playerSource][i][2] <= 0 then
                    table.remove(inventory[playerSource], i)
                end
                triggerClientEvent(playerSource, "Refresh", resourceRoot, "inv", inventory[playerSource])
                return true
            else
                table.remove(inventory[playerSource], i)
                triggerClientEvent(playerSource, "Refresh", resourceRoot, "inv", inventory[playerSource])
                return true
            end
        end
    end
    return false
end
--------------------------------------------------------------------------------------------------------------------------------
function giveItem(playerSource, item, qntd)
    item = tostring(item)
    qntd = tonumber(qntd)
    local peso = 0
    for i, _ in ipairs(inventory[playerSource]) do
        local item_ = inventory[playerSource][i][1]
        local qntd_ = inventory[playerSource][i][2]
        local peso_ = items[item_]["weight"]
        peso = peso + (peso_ * qntd_)
    end
    if peso + (items[item]["weight"] * qntd) <= capacity[playerSource] then
        for i, _ in ipairs(inventory[playerSource]) do
            if inventory[playerSource][i][1] == item then
                inventory[playerSource][i][2] = inventory[playerSource][i][2] + qntd
                triggerClientEvent(playerSource, "Refresh", resourceRoot, "inv", inventory[playerSource])
                return true
            end
        end
        if (#inventory[playerSource]) < 60 then
            table.insert(inventory[playerSource], {tostring(item), tonumber(qntd)})
            triggerClientEvent(playerSource, "Refresh", resourceRoot, "inv", inventory[playerSource])
            return true
        end
    end
    return false
end
--------------------------------------------------------------------------------------------------------------------------------
function setAnimation(playerSource, block, anim, time, loop)
    setPedAnimation(playerSource, block, anim, time, loop, false, false, false, _, true)
end
--------------------------------------------------------------------------------------------------------------------------------
local function giveItemAdmin(playerSource, command, item, qntd)
    if isInACL(playerSource, "Admin") then
        if item then
            if items[item] then
                if not qntd or tonumber(qntd) <= 0 then
                    qntd = 1
                end
                local qntd = tonumber(qntd)
                if giveItem(playerSource, item, qntd) then
                    exports.infobox:addNotification(playerSource, "Você pegou "..qntd.."x '"..items[item]["name"].."'", "success")
                else
                    exports.infobox:addNotification(playerSource, "Você não possui espaço no inventário", "error")
                end
            else
                exports.infobox:addNotification(playerSource, "O item informado não existe", "error")
            end
        else
            exports.infobox:addNotification(playerSource, "Utilize: /giveitem 'ITEM' 'QUANTIDADE'", "error")
        end
    end
end
addCommandHandler("giveitem", giveItemAdmin)
--------------------------------------------------------------------------------------------------------------------------------
local function resetInv(playerSource, command, id)
    if isInACL(playerSource, "Admin") then
        if id then
            for _, players in pairs(getElementsByType("player")) do
                if not isGuestAccount(getPlayerAccount(players)) then
                    if getElementData(players, "player:infos")["id"] == tonumber(id) then
                        inventory[playerSource] = {}
                        capacity[playerSource] = 10
                        triggerClientEvent(playerSource, "Refresh", resourceRoot, "inv", inventory[playerSource], capacity[playerSource])
                        exports.infobox:addNotification(playerSource, "Você resetou o inventário do jogador "..getPlayerName(players), "success")
                        exports.infobox:addNotification(players, "O seu inventário foi resetado pelo Anjo "..getPlayerName(playerSource), "warning")
                        return
                    end
                end
            end
            exports.infobox:addNotification(playerSource, "Nenhum player foi localizado com este ID", "error")
        else
            exports.infobox:addNotification(playerSource, "Utilize: /resetinv 'ID PLAYER'", "error")
        end
    end
end
addCommandHandler("resetinv", resetInv)
--------------------------------------------------------------------------------------------------------------------------------