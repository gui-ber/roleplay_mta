--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
local screenW, screenH = guiGetScreenSize()
local bold = dxCreateFont("fonts/bold.ttf", screenW/65)
local regular = dxCreateFont("fonts/regular.ttf", screenW/120)
local regular2 = dxCreateFont("fonts/regular.ttf", screenW/90)
local isGaragemVisible = false
local selectedVeh = 1
local vehicle = nil
veiculos = {}
--------------------------------------------------------------------------------------------------------------------------------
function render()
    if (isGaragemVisible) then
		dxDrawRectangle(screenW * 0.0000, screenH * 0.0000, screenW * 1.0000, screenH * 0.1198, tocolor(22, 22, 22, 255), false)
    	dxDrawRectangle(screenW * 0.3785, screenH * 0.0000, screenW * 0.2430, screenH * 0.1198, tocolor(44, 44, 44, 255), false)
    	dxDrawLine(screenW * -0.1, screenH * 0.123, screenW * 1.1, screenH * 0.123, tocolor(235, 135, 35, 255), 5, false)
    	dxDrawText(nomes[veiculos[selectedVeh]["modelo"]], screenW * 0.3785, screenH * 0.0000, screenW * 0.6215, screenH * 0.1198, tocolor(255, 255, 255, 255), 1.00, bold, "center", "center", false, false, false, false, false)
        dxDrawText("[A D] Selecionar veículos\n[W S] Rotacionar\n[ENTER] Retirar\n[BACKSPACE] Sair", screenW * 0.0146, screenH * 0.0000, screenW * 0.3785, screenH * 0.1198, tocolor(255, 255, 255, 255), 1.00, regular, "left", "center", false, false, false, false, false)
		dxDrawRectangle(screenW * 0.765, screenH * 0.02, screenW * 0.2211, screenH * 0.0312, tocolor(44, 44, 44, 255), false)
		dxDrawRectangle(screenW * 0.765, screenH * 0.02, screenW * (veiculos[selectedVeh]["saude"] / 1000 * 0.2211), screenH * 0.0312, tocolor(255, 255, 255, 255), false)
    	dxDrawRectangle(screenW * 0.765, screenH * 0.07, screenW * 0.2211, screenH * 0.0312, tocolor(44, 44, 44, 255), false)
    	dxDrawRectangle(screenW * 0.765, screenH * 0.07, screenW * (veiculos[selectedVeh]["gas"] / 100 * 0.2211), screenH * 0.0312, tocolor(255, 255, 255, 255), false)
    	dxDrawText("Estado do Motor", screenW * 0.6215, screenH * 0.02, screenW * 0.7592, screenH * 0.05, tocolor(255, 255, 255, 255), 1.00, regular, "right", "center", false, false, false, false, false)
    	dxDrawText("Combustível", screenW * 0.6215, screenH * 0.07, screenW * 0.7592, screenH * 0.104, tocolor(255, 255, 255, 255), 1.00, regular, "right", "center", false, false, false, false, false)
		if isGaragemVisible then
			if getKeyState("s") then
				local _, _, rot = getElementRotation(vehicle)
				setElementRotation(vehicle, _, _, rot + 2)
			elseif getKeyState("w") then
				local _, _, rot = getElementRotation(vehicle)
				setElementRotation(vehicle, _, _, rot - 2)
			end
		end
	end
end
--------------------------------------------------------------------------------------------------------------------------------
function renderGaragem(data)
	if not (isGaragemVisible) then
		isGaragemVisible = true
		selectedVeh = 1
		veiculos = {}
		for i, v in ipairs(data) do
			table.insert(veiculos, v)
		end
		setElementAlpha(localPlayer, 254)
		setElementFrozen(localPlayer, true)
		toggleAllControls(false)
		vehicle = createVehicle(veiculos[selectedVeh]["modelo"], 1544.336, -1353.167, 329.475, 0, 0, 90)
		setElementHealth(vehicle, veiculos[selectedVeh]["saude"])
		local cores = fromJSON(veiculos[selectedVeh]["cor"])
		setVehicleColor(vehicle, cores[1], cores[2], cores[3], cores[1], cores[2], cores[3])
		local danos = fromJSON(veiculos[selectedVeh]["lataria"])
		setVehicleWheelStates(vehicle, danos["roda"][1], danos["roda"][2], danos["roda"][3], danos["roda"][4])
		for i = 0, 5, 1 do
			setVehicleDoorState(vehicle, i, danos["portas"][i+1])
		end
		for i = 5, 6, 1 do
			setVehiclePanelState(vehicle, i, danos["parachoque"][i-4])
		end
		for i = 0, 3, 1 do
			setVehicleLightState(vehicle, i, danos["farol"][i+1])
		end
		setVehicleDamageProof(vehicle, true)
		setVehicleLocked(vehicle, true)
		addEventHandler("onClientRender", root, render)
		if getVehicleType(vehicle) == "Automobile" then
			setCameraMatrix(1539.429, -1357.899, 331, 1544.336, -1353.167, 329.475)
		elseif getVehicleType(vehicle) == "Bike" then
			setCameraMatrix(1541.429, -1355.899, 330.5, 1544.336, -1353.167, 329.475)
		end
	end
end
addEvent("RenderGaragem", true)
addEventHandler("RenderGaragem", resourceRoot, renderGaragem)
--------------------------------------------------------------------------------------------------------------------------------
function onKey(key, press)
	if (isGaragemVisible) then
		if (press) then
			if key == "a" then
				if selectedVeh > 1 then
					selectedVeh = selectedVeh - 1
				else
					selectedVeh = #veiculos
				end
				setElementModel(vehicle, veiculos[selectedVeh]["modelo"])
				setElementHealth(vehicle, veiculos[selectedVeh]["saude"])
				local cores = fromJSON(veiculos[selectedVeh]["cor"])
				setVehicleColor(vehicle, cores[1], cores[2], cores[3], cores[1], cores[2], cores[3])
				local danos = fromJSON(veiculos[selectedVeh]["lataria"])
				setVehicleWheelStates(vehicle, danos["roda"][1], danos["roda"][2], danos["roda"][3], danos["roda"][4])
				for i = 0, 5, 1 do
					setVehicleDoorState(vehicle, i, danos["portas"][i+1])
				end
				for i = 5, 6, 1 do
					setVehiclePanelState(vehicle, i, danos["parachoque"][i-4])
				end
				for i = 0, 3, 1 do
					setVehicleLightState(vehicle, i, danos["farol"][i+1])
				end
				local camX, camY, camZ = getCameraMatrix()
				if getVehicleType(vehicle) == "Automobile" then
					if camX ~= 1539.429 and camY ~= -1357.899 and camZ ~= 331 then
						smoothMoveCamera(camX, camY, camZ, 1544.336, -1353.167, 329.475, 1539.429, -1357.899, 331, 1544.336, -1353.167, 329.475, 500)
					end
				elseif getVehicleType(vehicle) == "Bike" then
					if camX ~= 1541.429 and camY ~= -1355.899 and camZ ~= 330.5 then
						smoothMoveCamera(camX, camY, camZ, 1544.336, -1353.167, 329.475, 1541.429, -1355.899, 330.5, 1544.336, -1353.167, 329.475, 500)
					end
				end
			elseif key == "d" then
				if selectedVeh < #veiculos then 
					selectedVeh = selectedVeh + 1
				else
					selectedVeh = 1
				end
				setElementModel(vehicle, veiculos[selectedVeh]["modelo"])
				setElementHealth(vehicle, veiculos[selectedVeh]["saude"])
				local cores = fromJSON(veiculos[selectedVeh]["cor"])
				setVehicleColor(vehicle, cores[1], cores[2], cores[3], cores[1], cores[2], cores[3])
				local danos = fromJSON(veiculos[selectedVeh]["lataria"])
				setVehicleWheelStates(vehicle, danos["roda"][1], danos["roda"][2], danos["roda"][3], danos["roda"][4])
				for i = 0, 5, 1 do
					setVehicleDoorState(vehicle, i, danos["portas"][i+1])
				end
				for i = 5, 6, 1 do
					setVehiclePanelState(vehicle, i, danos["parachoque"][i-4])
				end
				for i = 0, 3, 1 do
					setVehicleLightState(vehicle, i, danos["farol"][i+1])
				end
				local camX, camY, camZ = getCameraMatrix()
				if getVehicleType(vehicle) == "Automobile" then
					if camX ~= 1539.429 and camY ~= -1357.899 and camZ ~= 331 then
						smoothMoveCamera(camX, camY, camZ, 1544.336, -1353.167, 329.475, 1539.429, -1357.899, 331, 1544.336, -1353.167, 329.475, 500)
					end
				elseif getVehicleType(vehicle) == "Bike" then
					if camX ~= 1541.429 and camY ~= -1355.899 and camZ ~= 330.5 then
						smoothMoveCamera(camX, camY, camZ, 1544.336, -1353.167, 329.475, 1541.429, -1355.899, 330.5, 1544.336, -1353.167, 329.475, 500)
					end
				end
			elseif key == "enter" then
				setElementAlpha(localPlayer, 255)
				setElementFrozen(localPlayer, false)
				toggleAllControls(true)
				destroyElement(vehicle)
				vehicle = nil
				veiculos = {}
				isGaragemVisible = false
				setTimer(function() setCameraTarget(localPlayer) end, 100, 3)
				removeEventHandler("onClientRender", root, render)
				triggerServerEvent("PickVehicle", resourceRoot, localPlayer, selectedVeh)
			elseif key == "backspace" then
				setElementAlpha(localPlayer, 255)
				setElementFrozen(localPlayer, false)
				toggleAllControls(true)
				destroyElement(vehicle)
				vehicle = nil
				veiculos = {}
				isGaragemVisible = false
				setTimer(function() setCameraTarget(localPlayer) end, 100, 3)
				removeEventHandler("onClientRender", root, render)
			end
		end
	end
end
addEventHandler("onClientKey", root, onKey)
--------------------------------------------------------------------------------------------------------------------------------