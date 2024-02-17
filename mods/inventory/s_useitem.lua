--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
local timer = {}
--------------------------------------------------------------------------------------------------------------------------------
item_use = {
    ["maconha"] = function(player)
        exports.stats:giveCalm(player)
        exports.chat:addMessage(player, "Fumando baseado")
        exports.infobox:addNotification(player, "Você consumiu 1x 'Cigarro de Maconha'", "success")
    end,
    ["energetico"] = function(player)
        exports.stats:giveEnergy(player, "energetico")
        exports.chat:addMessage(player, "Bebendo energético")
        exports.infobox:addNotification(player, "Você consumiu 1x 'Energético'", "success")
    end,
    ["cocaina"] = function(player)
        exports.stats:giveEnergy(player, "cocaina")
        exports.chat:addMessage(player, "Cheirando cocaína")
        exports.infobox:addNotification(player, "Você consumiu 1x 'Pino de Cocaína'", "success")
    end
}
--------------------------------------------------------------------------------------------------------------------------------