options = {
    ["player"] = {
        ["distance"] = 1.5,
        ["actions"] = {
            [1] =  {
                ["name"] = "mute",
                ["title"] = "Silenciar",
                ["permission"] = function()
                    return true
                end,
                ["function"] = function(playerSource, target)
                    local infos = getElementData(target, "player:infos") or {}
                    local name = infos and infos["name"] or getPlayerName(target)
                    local id = infos and infos["id"] or "N/A"
                    exports.infobox:addNotification(playerSource, "Você silenciou o(a) player '"..name.." #"..id.."' por 1 minuto", "success")
                    setPlayerVoiceIgnoreFrom(playerSource, target)
                    setTimer(function() setPlayerVoiceIgnoreFrom(playerSource, nil) end, 60000, 1)
                end,
            },
            [2] =  {
                ["name"] = "money",
                ["title"] = "Dar Dinheiro",
                ["permission"] = function()
                    return true
                end,
                ["function"] = function(playerSource, target)
                    
                end,
            },
            [3] =  {
                ["name"] = "kiss",
                ["title"] = "Beijar",
                ["permission"] = function()
                    return true
                end,
                ["function"] = function(playerSource, target)
                    
                end,
            },
            [4] =  {
                ["name"] = "carry",
                ["title"] = "Carregar",
                ["permission"] = function(playerSource, target)
                    exports.samu:isPlayerDead(target)
                end,
                ["function"] = function(playerSource, target)
                    
                end,
            },
            [5] =  {
                ["name"] = "handcuff",
                ["title"] = "Algemar",
                ["permission"] = function(playerSource, target)
                    local groups = {"GIT", "Bloods", "Staff"}
                    local data = getElementData(playerSource, "player:infos")
                    if data["group"] then
                        for _, v in pairs(groups) do
                            if data["group"] == v then
                                return true
                            end
                        end
                    end
                    return false
                end,
                ["function"] = function(playerSource, target)
                    
                end,
            },
            [6] =  {
                ["name"] = "search",
                ["title"] = "Revistar",
                ["permission"] = function(playerSource, target)
                    local groups = {"GIT", "Bloods", "Staff"}
                    local data = getElementData(playerSource, "player:infos")
                    if data["group"] then
                        for _, v in pairs(groups) do
                            if data["group"] == v then
                                return true
                            end
                        end
                    end
                    return false
                end,
                ["function"] = function(playerSource, target)
                    
                end,
            },
            [7] =  {
                ["name"] = "rescue",
                ["title"] = "Re-Animar",
                ["permission"] = function(playerSource, target)
                    local groups = {"SUS", "Staff"}
                    local data = getElementData(playerSource, "player:infos")
                    if data["group"] then
                        for _, v in pairs(groups) do
                            if data["group"] == v then
                                return true
                            end
                        end
                    end
                    return false
                end,
                ["function"] = function(playerSource, target)
                    
                end,
            },
            [8] = {
                ["name"] = "cartaosd",
                ["title"] = "Desbloquear Cel.",
                ["permission"] = function(playerSource, target)
                    if exports.inventario:getItem(playerSource, "cartaosd_malicioso") >= 1 then
                        if exports.inventario:getItem(target, "celular") >= 1 then
                            local data = getElementData(playerSource, "player:infos")
                            if data["group"] and data["group"] == "Anon" then
                                return true
                            end
                        end
                    end
                    return false
                end,
                ["function"] = function(playerSource, target)
                    if exports.inventario:getItem(playerSource, "cartaosd_malicioso") >= 1 then
                        if exports.inventario:getItem(target, "celular") >= 1 then
                            exports.inventario:takeItem(playerSource, "cartaosd_malicioso", 1)
                            exports.inventario:takeItem(target, "celular", 1)
                            exports.inventario:giveItem(target, "celular_desbloqueado", 1)
                            exports.infobox:addNotification(playerSource, "Você instalou o JailBreak", "success")
                            exports.infobox:addNotification(target, "Foi instalado o JailBreak no seu celular, agora sua navegação está criptografada e segura", "success")
                        end
                    end
                end,
            },
        },
    },
    ["vehicle"] = {
        ["distance"] = 4.25,
        ["actions"] = {
            [1] =  {
                ["name"] = "lock",
                ["title"] = "Trancar",
                ["permission"] = function(playerSource, target)
                    if not getElementData(target, "vehicle:locked") then
                        local data_veh = getElementData(target, "vehicle:infos")
                        local data_player = getElementData(playerSource, "player:infos")
                        local owner = data_veh and data_veh["owner"] or false
                        local id = data_player and data_player["id"] or false
                        if owner == id then
                            return true
                        end
                    end
                    return false
                end,
                ["function"] = function(playerSource, target)
                    exports.control_veh:triggerLock(playerSource, target, "lock")
                end,
            },
            [2] =  {
                ["name"] = "unlock",
                ["title"] = "Destrancar",
                ["permission"] = function(playerSource, target)
                    if getElementData(target, "vehicle:locked") then
                        local data_veh = getElementData(target, "vehicle:infos")
                        local data_player = getElementData(playerSource, "player:infos")
                        local owner = data_veh and data_veh["owner"] or false
                        local id = data_player and data_player["id"] or false
                        if owner == id then
                            return true
                        end
                    end
                    return false
                end,
                ["function"] = function(playerSource, target)
                    exports.control_veh:triggerLock(playerSource, target, "unlock")
                end,
            },
            [3] =  {
                ["name"] = "trunk",
                ["title"] = "Porta-Malas",
                ["permission"] = function(playerSource, target)
                    if not getElementData(target, "vehicle:locked") then
                        return true
                    else
                        local data_veh = getElementData(target, "vehicle:infos")
                        local data_player = getElementData(playerSource, "player:infos")
                        local owner = data_veh and data_veh["owner"] or false
                        local id = data_player and data_player["id"] or false
                        if owner == id then
                            return true
                        end
                    end
                    return false
                end,
                ["function"] = function(playerSource, target)
                    exports.inventario:showTrunk(playerSource, target)
                end,
            },
            [4] =  {
                ["name"] = "fuel",
                ["title"] = "Abastecer",
                ["permission"] = function(playerSource, target)
                    if exports.inventario:getItem(playerSource, "gasolina") >= 1 then
                        return true
                    end
                    return false
                end,
                ["function"] = function(playerSource, target)
                    
                end,
            },
            [5] =  {
                ["name"] = "repair",
                ["title"] = "Consertar",
                ["permission"] = function(playerSource, target)
                    if exports.inventario:getItem(playerSource, "kit_reparo") >= 1 then
                        return true
                    end
                    return false
                end,
                ["function"] = function(playerSource, target)
                    
                end,
            },
            [6] =  {
                ["name"] = "lockpick",
                ["title"] = "Usar Lock-Pick",
                ["permission"] = function(playerSource, target)
                    if exports.inventario:getItem(playerSource, "lockpick") >= 1 then
                        return true
                    end
                    return false
                end,
                ["function"] = function(playerSource, target)
                    
                end,
            },
            [7] =  {
                ["name"] = "bodywork",
                ["title"] = "Reparar Funilaria",
                ["permission"] = function(playerSource, target)
                    if exports.inventario:getItem(playerSource, "reparo_funilaria") >= 1 then
                        local data = getElementData(playerSource, "player:infos")
                        if data and data["group"] and data["group"] == "LSC" then
                            return true
                        end
                    end
                    return false
                end,
                ["function"] = function(playerSource, target)
                    
                end,
            },
            [8] =  {
                ["name"] = "tire",
                ["title"] = "Reparar Pneus",
                ["permission"] = function(playerSource, target)
                    if exports.inventario:getItem(playerSource, "reparo_pneu") >= 1 then
                        local data = getElementData(playerSource, "player:infos")
                        if data["group"] and data["group"] == "LSC" then
                            return true
                        end
                    end
                    return false
                end,
                ["function"] = function(playerSource, target)
                    
                end,
            },
            [9] =  {
                ["name"] = "engine",
                ["title"] = "Reparar Motor",
                ["permission"] = function(playerSource, target)
                    if exports.inventario:getItem(playerSource, "reparo_motor") >= 1 then
                        local data = getElementData(playerSource, "player:infos")
                        if data["group"] and data["group"] == "LSC" then
                            return true
                        end
                    end
                    return false
                end,
                ["function"] = function(playerSource, target)
                    
                end,
            },
            [10] =  {
                ["name"] = "remove",
                ["title"] = "Guinchar",
                ["permission"] = function(playerSource, target)
                    local groups = {"EFT", "Staff"}
                    local data = getElementData(playerSource, "player:infos")
                    if data["group"] then
                        for _, v in pairs(groups) do
                            if data["group"] == v then
                                return true
                            end
                        end
                    end
                    return false
                end,
                ["function"] = function(playerSource, target)
                    
                end,
            },
            [11] = {
                ["name"] = "amerce",
                ["title"] = "Multar",
                ["permission"] = function(playerSource, target)
                    local groups = {"EFT", "Staff"}
                    local data = getElementData(playerSource, "player:infos")
                    if data["group"] then
                        for _, v in pairs(groups) do
                            if data["group"] == v then
                                return true
                            end
                        end
                    end
                    return false
                end,
                ["function"] = function(playerSource, target)
                    
                end,
            },
        },
    },
    ["ped"] = {
        ["distance"] = 1.5,
        ["actions"] = {
            [1] =  {
                ["name"] = "weed",
                ["title"] = "Vender Verde",
                ["permission"] = function(playerSource, target)
                    if exports.inventario:getItem(playerSource, "maconha") >= 1 then
                        local data = getElementData(target, "ped:interact") or false
                        if data and data == "sell_drugs" then
                            return true
                        end
                    end
                    return false
                end,
                ["function"] = function(playerSource, target)
                    
                end,
            },
            [2] =  {
                ["name"] = "cocaine",
                ["title"] = "Vender Branca",
                ["permission"] = function(playerSource, target)
                    if exports.inventario:getItem(playerSource, "cocaina") >= 1 then
                        local data = getElementData(target, "ped:interact") or false
                        if data and data == "sell_drugs" then
                            return true
                        end
                    end
                    return false
                end,
                ["function"] = function(playerSource, target)
                    
                end,
            },
            [3] =  {
                ["name"] = "bully",
                ["title"] = "Ameaçar",
                ["permission"] = function(playerSource, target)
                    local data = getElementData(target, "ped:interact") or false
                    if data and data == "sell_drugs" then
                        return true
                    end
                end,
                ["function"] = function(playerSource, target)
                    
                end,
            },
        },
    },
}
positions = {
    [1] = {0.4125, 0.4542},
    [2] = {0.4569, 0.4986},
    [3] = {0.5014, 0.5431},
    [4] = {0.5458, 0.5875},
    [5] = {0.5903, 0.6319},
}