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
local font = dxCreateFont("fonts/bold.ttf", screenW/75)
local isPointing = false
local mX = 0
local mY = 0
local mZ = 0
--------------------------------------------------------------------------------------------------------------------------------
function renderPointing()
	if getElementAlpha(localPlayer) ~= 254 then
		local pX, pY, pZ = getElementPosition(localPlayer)
		local distance = (getDistanceBetweenPoints3D(pX, pY, pZ, mX, mY, mZ)/1.5)
		local x, y = getScreenFromWorldPosition(mX, mY, mZ, 1, true)
		if distance <= 20 then
			removeEventHandler("onClientRender", root, renderPointing)
			isPointing = false
		end
		if x and y then
			dxDrawText(numberFormat(string.format("%d", (distance))).."m\n▼", x + 1, y + 1, _, _, tocolor(0, 0, 0, 255), 1.00, font, "center", "center", false, false, false, true)
			dxDrawText(numberFormat(string.format("%d", (distance))).."m\n#FF0000▼", x, y, _, _, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, true)
		end
	end
end
--------------------------------------------------------------------------------------------------------------------------------
function addPoint(posX, posY, posZ)
	if (posX) and (posY) and (posZ) then
		if isPointing then
			removeEventHandler("onClientRender", root, renderPointing)
			isPointing = false
			mX = 0
			mY = 0
			mZ = 0
		end
		mX = tonumber(posX)
		mY = tonumber(posY)
		mZ = tonumber(posZ)
		addEventHandler("onClientRender", root, renderPointing)
		isPointing = true
	end
end
addEvent("togglePoint", true)
addEventHandler("togglePoint", resourceRoot, addPoint)
--------------------------------------------------------------------------------------------------------------------------------