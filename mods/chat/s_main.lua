--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
local function onChat()
    cancelEvent()
    showChat(source, false)
end
addEventHandler("onPlayerChat", root, onChat)
--------------------------------------------------------------------------------------------------------------------------------
function addMessage(player, message, type)
    if type then
        if type == "action" then
                local arguments = {}
                for v in string.gmatch(message, "[^%s]+") do
                    table.insert(arguments, v)
                end
                local command = arguments[1]:gsub("/", "")
                table.remove(arguments, 1)
                if not executeCommandHandler(command, player, table.concat(arguments, " ")) then
                    message = "*"..string.lower(message:gsub("*", "")).."*"
                    local x, y, z = getElementPosition(player)
                    local players = getElementsWithinRange(x, y, z, 60, "player")
                    triggerClientEvent(players, "triggerMessage", resourceRoot, player, message, type)
                end
        elseif type == "say" then
            message = message:gsub("#%x%x%x%x%x%x", "")
            local x, y, z = getElementPosition(player)
            local players = getElementsWithinRange(x, y, z, 30, "player")
            triggerClientEvent(players, "triggerMessage", resourceRoot, player, message, type)
        end
    else
        message = "*"..message.."*"
        local x, y, z = getElementPosition(player)
        local players = getElementsWithinRange(x, y, z, 100, "player")
        triggerClientEvent(players, "triggerMessage", resourceRoot, player, message, "trigger")
    end
end
addEvent("AddMessage", true)
addEventHandler("AddMessage", resourceRoot, addMessage)
--------------------------------------------------------------------------------------------------------------------------------