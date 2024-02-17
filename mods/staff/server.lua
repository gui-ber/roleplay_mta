veh = {}
skin = {}
----------------------------------------------------------------------------------------------------------------------------
function getPlayerID(id)
	for _, player in pairs (getElementsByType("player")) do
		if getElementData(player, "player:infos")["id"] == id then
			return player
		end
	end
	return false
end
----------------------------------------------------------------------------------------------------------------------------
function info(playerSource)
	if isInACL(playerSource, "Staff") then
		outputChatBox(" ", playerSource, 255, 0, 0, true)
		outputChatBox("================================================================================================", playerSource, 255, 0, 0, true)
		outputChatBox("Setar gasolina = /setgas ID --- Setar skin = /ss ID SKIN --- Desvirar veículo = /desvirar", playerSource, 255, 255, 255, true)
		outputChatBox("Destruir heli = /destroyheli --- Voar = /fly --- Consertar veículo = /fix ID --- Invisível = /v", playerSource, 255, 255, 255, true)
		outputChatBox("Destruir veículo = /dv ID --- Setar fome/sede = /setfome ID --- Setar vida/colete = /life ID", playerSource, 255, 255, 255, true)
		outputChatBox("Teleportar = /tp ID --- Puxar = /puxar ID --- Não tomar dano = /pro --- Freezar = /freeze ID  --- Curar = /curar ID", playerSource, 255, 255, 255, true)
		outputChatBox("================================================================================================", playerSource, 255, 0, 0, true)
		outputChatBox(" ", playerSource, 255, 0, 0, true)
	end
end
addCommandHandler("infostaff", info)
----------------------------------------------------------------------------------------------------------------------------
function setarGasolina(playerSource, commandName, id)
	if isInACL(playerSource, "Staff") then
    	if (id) then
        	local playerID = tonumber(id)
			local targetPlayer = getPlayerID(playerID)
			if (targetPlayer) then
				local veh = getPedOccupiedVehicle(targetPlayer)
				if (veh) then
					setElementData(veh, "vehicle:fuel", 100)
					exports.infobox:addNotification(targetPlayer, "O Staff "..getPlayerName(playerSource).." setou 100% de gasolina em seu veículo", "info")
					exports.infobox:addNotification(playerSource, "Você setou 100% de gasolina no veículo do jogador "..getPlayerName(targetPlayer), "success")
				else
					exports.infobox:addNotification(playerSource, "O jogador informado não está em um veículo", "error")
				end
			else
				exports.infobox:addNotification(playerSource, "ID informado inválido", "error")
			end
		else
			exports.infobox:addNotification(playerSource, "Insira o ID do jogador desejado", "error")
		end
	end
end
addCommandHandler("setgas", setarGasolina)
----------------------------------------------------------------------------------------------------------------------------
function setSkin(playerSource, commandName, id, skin)
	if isInACL(playerSource, "Staff") then
		if (id) and (skin) then
        	local playerID = tonumber(id)
			local targetPlayer = getPlayerID(playerID)
			if (targetPlayer) then
				if getElementModel(targetPlayer) == skin then
					exports.infobox:addNotification(playerSource, "O jogador "..getPlayerName(targetPlayer).." já possui essa skin", "error")
				else
					setElementModel(targetPlayer, skin)
					exports.infobox:addNotification(targetPlayer, "O Staff "..getPlayerName(playerSource).." alterou sua skin", "info")
					exports.infobox:addNotification(playerSource, "Você alterou a skin do jogador "..getPlayerName(targetPlayer), "success")
				end
			else
				exports.infobox:addNotification(playerSource, "ID informado inválido", "error")
			end
		else
			exports.infobox:addNotification(playerSource, "Utilize: /ss ID SKIN", "error")
		end
	end
end
addCommandHandler("ss", setSkin)
----------------------------------------------------------------------------------------------------------------------------
function fly(playerSource, commandName)
	if isInACL(playerSource, "Staff") then
		triggerClientEvent(playerSource, "onClientFlyToggle", playerSource)
	end
end
addCommandHandler("fly", fly)
----------------------------------------------------------------------------------------------------------------------------
function fixVeh(playerSource, commandName, id)
	if isInACL(playerSource, "Staff") then
    	if (id) then
        	local playerID = tonumber(id)
			local targetPlayer = getPlayerID(playerID)
			if (targetPlayer) then
                local veh = getPedOccupiedVehicle(targetPlayer)
				if veh then
					fixVehicle(veh)
       				setVehicleDamageProof(veh, false)
       				exports.infobox:addNotification(targetPlayer, "O Staff "..getPlayerName(playerSource).." reparou seu veículo", "info")
       				exports.infobox:addNotification(playerSource, "Você reparou o veículo do jogador "..getPlayerName(targetPlayer), "success")
				else
					exports.infobox:addNotification(playerSource, "O jogador não está em um veículo", "error")
			    end
			else
				exports.infobox:addNotification(playerSource, "ID informado inválido", "error")
			end
		else
			exports.infobox:addNotification(playerSource, "Insira o ID do jogador desejado", "error")
		end
	end
end
addCommandHandler("fix", fixVeh)
----------------------------------------------------------------------------------------------------------------------------
function destroyVeh(playerSource, commandName, id)
	if isInACL(playerSource, "Staff") then
    	if (id) then
        	local playerID = tonumber(id)
			local targetPlayer = getPlayerID(playerID)
			if (targetPlayer) then
            	local veh = getPedOccupiedVehicle(targetPlayer)
				if (veh) then
					destroyElement(veh)
       				exports.infobox:addNotification(targetPlayer, "O Staff "..getPlayerName(playerSource).." destruiu seu veículo", "info")
       				exports.infobox:addNotification(playerSource, "Você destruiu o veículo do jogador "..getPlayerName(targetPlayer), "success")
				else
					exports.infobox:addNotification(playerSource, "O jogador não está em um veículo", "error")
				end
			else
				exports.infobox:addNotification(playerSource, "ID informado inválido", "error")
			end
		else
			exports.infobox:addNotification(playerSource, "Insira o ID do jogador desejado", "error")
		end
	end
end
addCommandHandler("dv", destroyVeh)
----------------------------------------------------------------------------------------------------------------------------
function setarFome(playerSource, commandName, id)
	if isInACL(playerSource, "Staff") then
    	if (id) then
        	local playerID = tonumber(id)
			local targetPlayer = getPlayerID(playerID)
			if (targetPlayer) then
				setElementData(targetPlayer, "player:stats", {["food"] = 100, ["drink"] = 100, ["energy"] = 100})
				exports.infobox:addNotification(targetPlayer, "O Staff "..getPlayerName(playerSource).." setou sua fome, sede e energia em 100%", "info")
				exports.infobox:addNotification(playerSource, "Você setou 100% de fome, sede e energia ao jogador "..getPlayerName(targetPlayer), "success")
			else
				exports.infobox:addNotification(playerSource, "ID informado inválido", "error")
			end
		else
			exports.infobox:addNotification(playerSource, "Insira o ID do jogador desejado", "error")
		end
	end
end
addCommandHandler("setfome", setarFome)
----------------------------------------------------------------------------------------------------------------------------
function teleport(playerSource, commandName, id)
	if isInACL(playerSource, "Staff") then
    	if (id) then
        	local playerID = tonumber(id)
			local targetPlayer = getPlayerID(playerID)
			if (targetPlayer) then
				if not isPedInVehicle(playerSource) then
					local x, y, z = getElementPosition(targetPlayer)
					local interior = getElementInterior(targetPlayer)
					local dimension = getElementDimension(targetPlayer)
					setCameraInterior(playerSource, interior)
					setCameraTarget(playerSource, playerSource)
					setElementInterior(playerSource, interior)
					setElementDimension(playerSource, dimension)
					setElementPosition(playerSource, x, y, z+2)
					exports.infobox:addNotification(playerSource, "Você foi teleportado ao jogador "..getPlayerName(targetPlayer), "success")
				else
					exports.infobox:addNotification(playerSource, "Você precisa sair do veículo", "error")
				end
			else
				exports.infobox:addNotification(playerSource, "ID informado inválido", "error")
			end
		else
			exports.infobox:addNotification(playerSource, "Insira o ID do jogador desejado", "error")
		end
	end
end
addCommandHandler("tp", teleport)
----------------------------------------------------------------------------------------------------------------------------
function warp(playerSource, commandName, id)
	if isInACL(playerSource, "Staff") then
    	if (id) then
			local playerID = tonumber(id)
			local targetPlayer = getPlayerID(playerID)
			if (targetPlayer) then
				if not isPedInVehicle(targetPlayer) then
					local x, y, z = getElementPosition(playerSource)
					local interior = getElementInterior(playerSource)
					local dimension = getElementDimension(playerSource)
					setCameraInterior(targetPlayer, interior)
					setCameraTarget(targetPlayer, targetPlayer)
					setElementPosition(targetPlayer, x, y, z+2)
					setElementInterior(targetPlayer, interior)
					setElementDimension(targetPlayer, dimension)
					exports.infobox:addNotification(playerSource, "Você teleportou o jogador "..getPlayerName(targetPlayer).." até você", "success")
				else
					exports.infobox:addNotification(playerSource, "O jogador está em um veículo", "error")
				end
			else
				exports.infobox:addNotification(playerSource, "ID informado inválido", "error")
			end
		else
			exports.infobox:addNotification(playerSource, "Insira o ID do jogador desejado", "error")
		end
	end
end
addCommandHandler("puxar", warp)
----------------------------------------------------------------------------------------------------------------------------
function toggleInvisibility(playerSource)
	if isInACL(playerSource, "Staff") then
		local visible = getElementAlpha(playerSource)
		if (visible == 0) then
			if not getElementData(playerSource, "pro") then
				setElementAlpha(playerSource, 255)
			else
				setElementAlpha(playerSource, 150)
			end
			exports.infobox:addNotification(playerSource, "Você desativou sua invisibilidade", "success")
		elseif (visible == 255) or (visible == 150) then
			setElementAlpha(playerSource, 0)
			exports.infobox:addNotification(playerSource, "Você ativou sua invisibilidade", "success")
		end
	end
end
addCommandHandler("v", toggleInvisibility)
----------------------------------------------------------------------------------------------------------------------------
function setFreeze(playerSource, commandName, id)
	if isInACL(playerSource, "Staff") then
    	if (id) then
			local playerID = tonumber(id)
			local targetPlayer = getPlayerID(playerID)
			if (targetPlayer) then
				if isElementFrozen(targetPlayer) then
					setElementFrozen(targetPlayer, false)
					toggleAllControls(targetPlayer, true)
					exports.infobox:addNotification(targetPlayer, "O Staff "..getPlayerName(playerSource).." te descongelou", "info")
					exports.infobox:addNotification(playerSource, "Você descongelou o jogador "..getPlayerName(targetPlayer), "success")
				else
					setElementFrozen(targetPlayer, true)
					toggleAllControls(targetPlayer, false)
					exports.infobox:addNotification(targetPlayer, "O Staff "..getPlayerName(playerSource).." te congelou", "info")
					exports.infobox:addNotification(playerSource, "Você congelou o jogador "..getPlayerName(targetPlayer), "success")
				end
			else
				exports.infobox:addNotification(playerSource, "ID informado inválido", "error")
			end
		else
			exports.infobox:addNotification(playerSource, "Insira o ID do jogador desejado", "error")
		end
	end
end
addCommandHandler("freeze", setFreeze)
----------------------------------------------------------------------------------------------------------------------------
function setPro(playerSource)
	if isInACL(playerSource, "Staff") then
		if not getElementData(playerSource, "pro") then
			setElementData(playerSource, "pro", true)
			setElementAlpha(playerSource, 150)
			exports.infobox:addNotification(playerSource, "Você ativou sua invencibilidade", "success")
		else
			removeElementData(playerSource, "pro")
			setElementAlpha(playerSource, 255)
			exports.infobox:addNotification(playerSource, "Você desativou sua invencibilidade", "success")
		end
	end
end
addCommandHandler("pro", setPro)
----------------------------------------------------------------------------------------------------------------------------
function unlockVeh(playerSource)
	if isInACL(playerSource, "Admin") then
		if not isPedInVehicle(playerSource) then
			for _, vehicles in pairs(getElementsByType("vehicle")) do
				local x, y, z = getElementPosition(playerSource)
				local ex, ey, ez = getElementPosition(vehicles)
				if getDistanceBetweenPoints3D(x, y, z, ex, ey, ez) <= 3 then
					setElementData(vehicles, "vehicle:locked", false)
					setVehicleLocked(vehicles, false)
					exports.infobox:addNotification(playerSource, "Veículo destrancado", "success")
					break
				end
			end
		end
	end
end
addCommandHandler("abrir", unlockVeh)
----------------------------------------------------------------------------------------------------------------------------
function turnVeh(playerSource)
	if isInACL(playerSource, "Staff") then
		if isPedInVehicle(playerSource) then
			local veiculo = getPedOccupiedVehicle(playerSource)
			local x, y, z = getElementPosition(veiculo)
			local _, _, rz = getElementRotation(veiculo)
			setElementPosition(veiculo, x, y, z + 3)
			setElementRotation(veiculo, 0, 0, rz)
		else
			exports.infobox:addNotification(playerSource, "Você precisa estar dentro de um veículo", "error")
		end
	end
end
addCommandHandler("desvirar", turnVeh)
----------------------------------------------------------------------------------------------------------------------------
function Unbug(playerSource, commandName, id)
	if isInACL(playerSource, "Admin") then
		if id and tonumber(id) then
			for _, players in pairs(getElementsByType("player")) do
				if getElementData(players, "ID") == tonumber(id) then
					local x, y, z = getElementPosition(players)
					setElementPosition(players, x + 1, y + 1, z + 3)
					setElementFrozen(players, false)
					toggleAllControls(players, true)
					setPlayerHudComponentVisible(players, "crosshair", true)
					setPedAnimation(players, nil)
					setElementCollisionsEnabled(players, true)
					setElementAlpha(players, 255)
					exports.infobox:addNotification(playerSource, "Você desbugou o jogador "..getPlayerName(players), "success")
					exports.infobox:addNotification(players, "Você foi desbugado pelo Staff "..getPlayerName(playerSource), "info")
				end
			end
		end
	end
end
addCommandHandler("unbug", Unbug)
----------------------------------------------------------------------------------------------------------------------------
function Curar(playerSource, commandName, id)
	if isInACL(playerSource, "Admin") then
		if id and tonumber(id) then
			for _, player in pairs(getElementsByType("player")) do
				if getElementData(player, "ID") == tonumber(id) then
					if getElementData(player, "Desmaiado") then
						triggerEvent("Desmaiado", root, player, false)
						setElementHealth(player, 100)
						exports.infobox:addNotification(playerSource, "Você curou o jogador "..getPlayerName(player), "success")
						exports.infobox:addNotification(player, "Você foi curado pelo Staff "..getPlayerName(playerSource), "info")
					else
						exports.infobox:addNotification(playerSource, "O jogador informado não está caído", "error")
					end
				end
			end
		else
			exports.infobox:addNotification(playerSource, "Insira um ID", "error")
		end
	end
end
addCommandHandler("curar", Curar)
----------------------------------------------------------------------------------------------------------------------------
function SetarVida(playerSource, commandName, id)
	if isInACL(playerSource, "Admin") then
		if id and tonumber(id) then
			for _, player in pairs(getElementsByType("player")) do
				if getElementData(player, "ID") == tonumber(id) then
					setElementHealth(player, 100)
					setPedArmor(player, 100)
					exports.infobox:addNotification(playerSource, "Você setou 100% de vida e colete para o jogador "..getPlayerName(player), "success")
					exports.infobox:addNotification(player, "O Staff "..getPlayerName(playerSource).." te setou 100% de vida e colete", "info")
				end
			end
		else
			exports.infobox:addNotification(playerSource, "Insira um ID", "error")
		end
	end
end
addCommandHandler("life", SetarVida)
----------------------------------------------------------------------------------------------------------------------------
function DestruirAll(playerSource)
	if isInACL(playerSource, "Admin") then
		for _, vehicles in pairs(getElementsByType("vehicle")) do
			if not getVehicleOccupant(vehicles, 0) then
				if getElementDimension(vehicles) == 0 and getElementInterior(vehicles) == 0 then
					destroyElement(vehicles)
				end
			end
		end
		exports.infobox:addNotification(playerSource, "Você removeu todos os veículos inutilizados do servidor", "success")
	end
end
addCommandHandler("dvall", DestruirAll)
----------------------------------------------------------------------------------------------------------------------------