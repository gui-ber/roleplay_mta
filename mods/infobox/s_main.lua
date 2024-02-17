--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
function addNotification(playerSource, msg, type)
	if getElementType(playerSource) == "player" then
		triggerClientEvent(playerSource, "renderNotification", resourceRoot, msg, type)
	end
end
--------------------------------------------------------------------------------------------------------------------------------
function Anuncio(playerSource, commandName, ...)
	if isInACL(playerSource, "Admin") then
		for i, v in pairs(getElementsByType("player")) do
			local msg = table.concat ( { ... }, " " )
			msg = string.gsub(msg, "#%x%x%x%x%x%x", "")
			msg = ("[STAFF]: "..msg)
			triggerClientEvent(v, "renderNotification", resourceRoot, msg, "admin")
		end
	end
end
addCommandHandler("anunciar", Anuncio)
--------------------------------------------------------------------------------------------------------------------------------