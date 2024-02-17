--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
function giveExp(playerSource, qntd, show)
	local data = getElementData(playerSource, "player:experience") or {}
	local exp = data and data["exp"] or 0
	local level = data and data["level"] or 1
	local expMax = experience[level]
	if level < 30 then
		if (exp + tonumber(qntd)) >= expMax then
			setElementData(playerSource, "player:experience", {["exp"] = exp + tonumber(qntd), ["level"] = level + 1})
			exports.infobox:addNotification(playerSource, "Parabéns, você avançou para o nível: "..(level + 1), "info")
		else
			setElementData(playerSource, "player:experience", {["exp"] = exp + tonumber(qntd), ["level"] = level})
		end
		if show then
			exports.infobox:addNotification(playerSource, "Você recebeu '"..qntd.."' pontos de experiência", "info")
		end
	end
end
addEvent("GiveExp", true)
addEventHandler("GiveExp", resourceRoot, giveExp)
-----------------------------------------------------------------------------------------------------------------------------------------
local function onStart()
	setTimer(function() experience = exports.global:getExperience() end, 1000, 1)
end
addEventHandler("onResourceStart", resourceRoot, onStart)
-----------------------------------------------------------------------------------------------------------------------------------------