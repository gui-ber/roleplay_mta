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
local bold = dxCreateFont("assets/fonts/bold.ttf", screenW/65)
local regular = dxCreateFont("assets/fonts/regular.ttf", screenW/100)
local light = dxCreateFont("assets/fonts/light.ttf", screenW/115)
local title = dxCreateFont("assets/fonts/title.ttf", screenW/50)
local subtitle = dxCreateFont("assets/fonts/title.ttf", screenW/65)
local isConceVisible = false
local isBuyVisible = false
local selectedVeh = 1
local selectedColor = 1
local conceType = nil
local vehicle = nil
local sound = nil
local timer = {}
estoque = {}
--------------------------------------------------------------------------------------------------------------------------------
function render()
    if (isConceVisible) then
		dxDrawRectangle(0, 0, screenW * 0.3309, screenH, tocolor(10, 10, 10, 255), false)
		local hover_close = isCursorShowing() and isCursorOnElement(screenW * 0.2978, 0, screenW * 0.0331, screenH * 0.0482) and tocolor(255, 35, 35, 255) or tocolor(65, 65, 65, 255)
        dxDrawImage(screenW * 0.2978, 0, screenW * 0.0331, screenH * 0.0482, "assets/gfx/icons/button_close.png", 0, 0, 0, hover_close)
		
		dxDrawText(vehicles[conceType][selectedVeh]["name"], screenW * 0.0213, screenH * 0.1068, screenW * 0.3103, screenH * 0.1745, tocolor(255, 255, 255, 255), 1.00, title, "center", "center", false, false, false, false, false)
		dxDrawText("VENDIDOS: "..estoque[vehicles[conceType][selectedVeh]["id"]].." / "..vehicles[conceType][selectedVeh]["limit"], screenW * 0.0213, screenH * 0.1745, screenW * 0.3103, screenH * 0.2070, tocolor(255, 255, 255, 255), 1.00, light, "center", "center", false, false, false, false, false)
		dxDrawRectangle(screenW * 0.0213, screenH * 0.2331, screenW * 0.2890, screenH * 0.0052, tocolor(30, 30, 30, 255), false)
		
		dxDrawText("Velocidade Final", screenW * 0.0213, screenH * 0.2552, screenW * 0.3103, screenH * 0.2878, tocolor(255, 255, 255, 255), 1.00, regular, "center", "center", false, false, false, false, false)
		dxDrawRectangle(screenW * 0.0213, screenH * 0.2878, screenW * 0.2890, screenH * 0.0326, tocolor(35, 35, 35, 255), false)
		dxDrawRectangle(screenW * 0.0213, screenH * 0.2878, screenW * (vehicles[conceType][selectedVeh]["stats"]["velocity"] / 10 * 0.2890), screenH * 0.0326, tocolor(180, 180, 180, 255), false)
		dxDrawText("Aceleração", screenW * 0.0213, screenH * 0.3464, screenW * 0.1500, screenH * 0.3789, tocolor(255, 255, 255, 255), 1.00, regular, "center", "center", false, false, false, false, false)
		dxDrawRectangle(screenW * 0.0213, screenH * 0.3802, screenW * 0.1287, screenH * 0.0326, tocolor(35, 35, 35, 255), false)
		dxDrawRectangle(screenW * 0.0213, screenH * 0.3802, screenW * (vehicles[conceType][selectedVeh]["stats"]["aceleration"] / 10 * 0.1287), screenH * 0.0326, tocolor(180, 180, 180, 255), false)
		dxDrawText("Porta-Malas", screenW * 0.1816, screenH * 0.3464, screenW * 0.3103, screenH * 0.3789, tocolor(255, 255, 255, 255), 1.00, regular, "center", "center", false, false, false, false, false)
		dxDrawRectangle(screenW * 0.1816, screenH * 0.3802, screenW * 0.1287, screenH * 0.0326, tocolor(35, 35, 35, 255), false)
		dxDrawRectangle(screenW * 0.1816, screenH * 0.3802, screenW * (vehicles[conceType][selectedVeh]["stats"]["trunk"] / 4 * 0.1287), screenH * 0.0326, tocolor(180, 180, 180, 255), false)
		
		dxDrawRectangle(screenW * 0.0213, screenH * 0.4414, screenW * 0.2890, screenH * 0.0052, tocolor(30, 30, 30, 255), false)
		dxDrawRectangle(screenW * 0.0809, screenH * 0.4753, screenW * 0.0324, screenH * 0.0573, tocolor(255, 255, 255, 255), false)
		dxDrawRectangle(screenW * 0.0824, screenH * 0.4779, screenW * 0.0294, screenH * 0.0521, tocolor(15, 15, 15, 255), false)
		dxDrawRectangle(screenW * 0.1265, screenH * 0.4753, screenW * 0.0324, screenH * 0.0573, tocolor(255, 255, 255, 255), false)
		dxDrawRectangle(screenW * 0.1279, screenH * 0.4779, screenW * 0.0294, screenH * 0.0521, tocolor(131, 131, 131, 255), false)
		dxDrawRectangle(screenW * 0.1721, screenH * 0.4753, screenW * 0.0324, screenH * 0.0573, tocolor(255, 255, 255, 255), false)
		dxDrawRectangle(screenW * 0.1735, screenH * 0.4779, screenW * 0.0294, screenH * 0.0521, tocolor(225, 0, 0, 255), false)
		dxDrawRectangle(screenW * 0.2184, screenH * 0.4753, screenW * 0.0324, screenH * 0.0573, tocolor(255, 255, 255, 255), false)
		dxDrawRectangle(screenW * 0.2199, screenH * 0.4779, screenW * 0.0294, screenH * 0.0521, tocolor(52, 104, 242, 255), false)
		
		dxDrawRectangle(screenW * 0.0213, screenH * 0.5599, screenW * 0.2890, screenH * 0.0052, tocolor(30, 30, 30, 255), false)
		dxDrawText("R$ "..numberFormat(vehicles[conceType][selectedVeh]["price"]["money"]), screenW * 0.0213, screenH * 0.5911, screenW * 0.3103, screenH * 0.6589, tocolor(255, 255, 255, 255), 1.00, subtitle, "center", "center", false, false, false, false, false)
		dxDrawText("C$ "..numberFormat(vehicles[conceType][selectedVeh]["price"]["coin"]), screenW * 0.0213, screenH * 0.6589, screenW * 0.3103, screenH * 0.6914, tocolor(255, 255, 255, 255), 1.00, regular, "center", "center", false, false, false, false, false)
		
		local hover_selectL = isCursorShowing() and isCursorOnElement(screenW * 0.0213, screenH * 0.7656, screenW * 0.0441, screenH * 0.0781) and tocolor(56, 62, 91, 255) or tocolor(255, 255, 255, 255)
		dxDrawImage(screenW * 0.0213, screenH * 0.7656, screenW * 0.0441, screenH * 0.0781, "assets/gfx/icons/select.png", 180, 0, 0, hover_selectL)
		local hover_rotateL = isCursorShowing() and isCursorOnElement(screenW * 0.0831, screenH * 0.7656, screenW * 0.0441, screenH * 0.0781) and tocolor(56, 62, 91, 255) or tocolor(255, 255, 255, 255)
		dxDrawImage(screenW * 0.0831, screenH * 0.7656, screenW * 0.0441, screenH * 0.0781, "assets/gfx/icons/rotate_left.png", 0, 0, 0, hover_rotateL)
		local hover_action = isCursorShowing() and isCursorOnElement(screenW * 0.1441, screenH * 0.7656, screenW * 0.0441, screenH * 0.0781) and tocolor(56, 62, 91, 255) or tocolor(255, 255, 255, 255)
		local image_action = getVehicleType(vehicle) == "Automobile" and "action_door" or "action_light"
		dxDrawImage(screenW * 0.1441, screenH * 0.7656, screenW * 0.0441, screenH * 0.0781, "assets/gfx/icons/"..image_action..".png", 0, 0, 0, hover_action)
		local hover_rotateR = isCursorShowing() and isCursorOnElement(screenW * 0.2059, screenH * 0.7656, screenW * 0.0441, screenH * 0.0781) and tocolor(56, 62, 91, 255) or tocolor(255, 255, 255, 255)
		dxDrawImage(screenW * 0.2059, screenH * 0.7656, screenW * 0.0441, screenH * 0.0781, "assets/gfx/icons/rotate_right.png", 0, 0, 0, hover_rotateR)
		local hover_selectR = isCursorShowing() and isCursorOnElement(screenW * 0.2662, screenH * 0.7656, screenW * 0.0441, screenH * 0.0781) and tocolor(56, 62, 91, 255) or tocolor(255, 255, 255, 255)
		dxDrawImage(screenW * 0.2662, screenH * 0.7656, screenW * 0.0441, screenH * 0.0781, "assets/gfx/icons/select.png", 0, 0, 0, hover_selectR)
		
		dxDrawRectangle(screenW * 0.0213, screenH * 0.7188, screenW * 0.2890, screenH * 0.0052, tocolor(30, 30, 30, 255), false)
		local hover_buy = isCursorShowing() and isCursorOnElement(screenW * 0.0213, screenH * 0.8841, screenW * 0.1324, screenH * 0.0781) and tocolor(56, 62, 91, 255) or tocolor(20, 20, 20, 255)
		dxDrawRectangle(screenW * 0.0213, screenH * 0.8841, screenW * 0.1324, screenH * 0.0781, hover_buy, false)
		dxDrawText("COMPRAR", screenW * 0.0213, screenH * 0.8841, screenW * 0.1537, screenH * 0.9622, tocolor(255, 255, 255, 255), 1.00, bold, "center", "center", false, false, false, false, false)
		local hover_test = isCursorShowing() and isCursorOnElement(screenW * 0.1779, screenH * 0.8841, screenW * 0.1324, screenH * 0.0781) and tocolor(56, 62, 91, 255) or tocolor(20, 20, 20, 255)
		dxDrawRectangle(screenW * 0.1779, screenH * 0.8841, screenW * 0.1324, screenH * 0.0781, hover_test, false)
		dxDrawText("TEST DRIVE", screenW * 0.1779, screenH * 0.8841, screenW * 0.3103, screenH * 0.9622, tocolor(255, 255, 255, 255), 1.00, bold, "center", "center", false, false, false, false, false)

		if isConceVisible and not isBuyVisible and isCursorShowing() then
			if getKeyState("mouse1") then
				if isCursorOnElement(screenW * 0.2059, screenH * 0.7656, screenW * 0.0441, screenH * 0.0781) then
					local _, _, rot = getElementRotation(vehicle)
					setElementRotation(vehicle, _, _, rot + 2)
				elseif isCursorOnElement(screenW * 0.0831, screenH * 0.7656, screenW * 0.0441, screenH * 0.0781) then
					local _, _, rot = getElementRotation(vehicle)
					setElementRotation(vehicle, _, _, rot - 2)
				end
			end
		end
	end
end
--------------------------------------------------------------------------------------------------------------------------------
function renderConce(type, data)
	if not isConceVisible then
		for i, v in ipairs(data) do
			estoque[data[i]["id"]] = data[i]["qntd"]
		end
		conceType = type
		isConceVisible = true
		isBuyPanelVisible = false
		selectedVeh = 1
		selectedColor = 1
		showCursor(true)
		setElementAlpha(localPlayer, 254)
		setElementFrozen(localPlayer, true)
		toggleAllControls(false)
		vehicle = createVehicle(vehicles[conceType][selectedVeh]["id"], 1544.336, -1353.167, 329.475, 0, 0, 90)
		setVehicleColor(vehicle, colors[selectedColor][1], colors[selectedColor][2], colors[selectedColor][3], colors[selectedColor][1], colors[selectedColor][2], colors[selectedColor][3])
		setVehicleDamageProof(vehicle, true)
		setVehicleLocked(vehicle, true)
		addEventHandler("onClientRender", root, render)
		setCameraMatrix(1538.429, -1358.899, 331, 1544.336, -1350.600, 329.475)
	end
end
addEvent("RenderConce", true)
addEventHandler("RenderConce", resourceRoot, renderConce)
--------------------------------------------------------------------------------------------------------------------------------
local function onClick(button, state)
	if isConceVisible then
		if state == "down" then
			if button == "left" then
				if isCursorOnElement(screenW * 0.2978, 0, screenW * 0.0331, screenH * 0.0482) then --FECHAR
					showPanel("close")
					isConceVisible = false
					showCursor(false)
					destroyElement(vehicle)
					vehicle = nil
					setElementAlpha(localPlayer, 255)
					setElementFrozen(localPlayer, false)
					toggleAllControls(true)
					setTimer(function() setCameraTarget(localPlayer) end, 100, 3)
					removeEventHandler("onClientRender", root, render)
				elseif isCursorOnElement(screenW * 0.2662, screenH * 0.7656, screenW * 0.0441, screenH * 0.0781) then --NEXT VEH
					if not isBuyVisible then
						if selectedVeh < (#vehicles[conceType]) then
							selectedVeh = selectedVeh + 1
						else
							selectedVeh = 1
						end
						setElementModel(vehicle, vehicles[conceType][selectedVeh]["id"])
						playSound("assets/sfx/select.mp3")
					end
				elseif isCursorOnElement(screenW * 0.0213, screenH * 0.7656, screenW * 0.0441, screenH * 0.0781) then --PREVIOUS VEH
					if not isBuyVisible then
						if selectedVeh > 1 then
							selectedVeh = selectedVeh - 1
						else
							selectedVeh = #vehicles[conceType]
						end
						setElementModel(vehicle, vehicles[conceType][selectedVeh]["id"])
						playSound("assets/sfx/select.mp3")
					end
				elseif isCursorOnElement(screenW * 0.1441, screenH * 0.7656, screenW * 0.0441, screenH * 0.0781) then --ACTION
					if not isBuyVisible then
						if getVehicleType(vehicle) == "Automobile" then
							for i = 0, 5 do 
								setVehicleDoorOpenRatio(vehicle, i, 1 - getVehicleDoorOpenRatio(vehicle, i), 1000)
							end
						elseif getVehicleType(vehicle) == "Bike" then
							if getVehicleOverrideLights(vehicle) ~= 2 then
								setVehicleOverrideLights(vehicle, 2)
							else
								setVehicleOverrideLights(vehicle, 1)
							end
						end
						playSound("assets/sfx/select.mp3")
					end
				elseif isCursorOnElement(screenW * 0.0824, screenH * 0.4779, screenW * 0.0294, screenH * 0.0521) then --COR PRETO
					if not isBuyVisible then
						if not isElement(sound) then
							selectedColor = 1
							sound = playSound("assets/sfx/spray.mp3")
							setVehicleColor(vehicle, colors[selectedColor][1], colors[selectedColor][2], colors[selectedColor][3], colors[selectedColor][1], colors[selectedColor][2], colors[selectedColor][3])
						end
					end
				elseif isCursorOnElement(screenW * 0.1279, screenH * 0.4779, screenW * 0.0294, screenH * 0.0521) then --COR BRANCO
					if not isBuyVisible then
						if not isElement(sound) then
							selectedColor = 2
							sound = playSound("assets/sfx/spray.mp3")
							setVehicleColor(vehicle, colors[selectedColor][1], colors[selectedColor][2], colors[selectedColor][3], colors[selectedColor][1], colors[selectedColor][2], colors[selectedColor][3])
						end
					end
				elseif isCursorOnElement(screenW * 0.1735, screenH * 0.4779, screenW * 0.0294, screenH * 0.0521) then --COR VERMELHO
					if not isBuyVisible then
						if not isElement(sound) then
							selectedColor = 3
							sound = playSound("assets/sfx/spray.mp3")
							setVehicleColor(vehicle, colors[selectedColor][1], colors[selectedColor][2], colors[selectedColor][3], colors[selectedColor][1], colors[selectedColor][2], colors[selectedColor][3])
						end
					end
				elseif isCursorOnElement(screenW * 0.2199, screenH * 0.4779, screenW * 0.0294, screenH * 0.0521) then --COR AZUL
					if not isBuyVisible then
						if not isElement(sound) then
							selectedColor = 4
							sound = playSound("assets/sfx/spray.mp3")
							setVehicleColor(vehicle, colors[selectedColor][1], colors[selectedColor][2], colors[selectedColor][3], colors[selectedColor][1], colors[selectedColor][2], colors[selectedColor][3])
						end
					end
				elseif isCursorOnElement(screenW * 0.1779, screenH * 0.8841, screenW * 0.1324, screenH * 0.0781) then --TEST DRIVE
					if not isBuyVisible then
						if not timer["testdrive"] or (getTickCount() - timer["testdrive"]) > 120000 then
							isConceVisible = false
							showCursor(false)
							destroyElement(vehicle)
							vehicle = nil
							setElementAlpha(localPlayer, 255)
							setElementFrozen(localPlayer, false)
							toggleAllControls(true)
							removeEventHandler("onClientRender", root, render)
							triggerServerEvent("TestDrive", resourceRoot, localPlayer, conceType, selectedVeh, selectedColor)
							timer["testdrive"] = getTickCount()
						else
							exports.infobox:addNotification("Aguarde para realizar um novo test-drive", "error")
						end
					end
				elseif isCursorOnElement(screenW * 0.0213, screenH * 0.8841, screenW * 0.1324, screenH * 0.0781) then --COMPRAR
					if not isBuyVisible then
						isBuyVisible = true
						showPanel("show", "Selecione a forma de pagamento desejada\n\nDinheiro: "..numberFormat(vehicles[conceType][selectedVeh]["price"]["money"]).."\nCoins: "..numberFormat(vehicles[conceType][selectedVeh]["price"]["coin"]), {[1] = "Dinheiro", [2] = "Coins"})
					end
				end
			end
		end
	end
end
addEventHandler("onClientClick", root, onClick)
--------------------------------------------------------------------------------------------------------------------------------
function optionClicked(option)
	showPanel("close")
	local moeda = option == 1 and "money" or "coin"
	triggerServerEvent("BuyVehicle", resourceRoot, localPlayer, selectedVeh, conceType, moeda, colors[selectedColor][1], colors[selectedColor][2], colors[selectedColor][3])
end
--------------------------------------------------------------------------------------------------------------------------------
function closeBuy()
	isBuyVisible = false
end
--------------------------------------------------------------------------------------------------------------------------------