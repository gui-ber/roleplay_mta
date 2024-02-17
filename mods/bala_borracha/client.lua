--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
function onDamage(attacker, damage_causing)
	if damage_causing == 25 then
		setPedControlState(localPlayer, "sprint", false)
		setPedControlState(localPlayer, "walk", true)
		cancelEvent()
    end
end
addEventHandler("onClientPlayerDamage", localPlayer, onDamage)
--------------------------------------------------------------------------------------------------------------------------------