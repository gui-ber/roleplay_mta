--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
local function onDamage(attacker, weapon, bodypart, loss)
	if attacker and weapon and bodypart == 9 then
		if weapons[weapon] and weapon ~= 25 then
			local armor = getPedArmor(localPlayer)
			if armor > 0 then
				cancelEvent()
				local health = getElementHealth(localPlayer)
				if health - loss > 0 then
					setElementHealth(localPlayer, health - loss)
				else
					--exports.samu:killPlayer(localPlayer)
				end
			end
		end
	end
end
addEventHandler("onClientPlayerDamage", localPlayer, onDamage)
--------------------------------------------------------------------------------------------------------------------------------