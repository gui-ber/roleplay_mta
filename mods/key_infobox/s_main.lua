--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
function showKeyInfobox(player, state, msg)
	if player and isElement(player) then
		if state == true then
			if msg then
				triggerClientEvent(player, "ShowKeyInfobox", resourceRoot, state, msg)
			end
		elseif state == false then
			triggerClientEvent(player, "ShowKeyInfobox", resourceRoot, state)
		end
	end
end
--------------------------------------------------------------------------------------------------------------------------------