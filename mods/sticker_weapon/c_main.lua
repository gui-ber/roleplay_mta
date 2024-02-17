--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
local shaderCode = [[
    texture tex;
    technique replace {
        pass P0 {
            Texture[0] = tex;
        }
    }
]]
--------------------------------------------------------------------------------------------------------------------------------
local posX, posY, posZ = 1525.808, -1358.678, 329.508
local amount = 7
local weaponID = 23
local skinID = 347
local textureName = "TexturasTurga"
local aim = true
local distance = 1.3
--------------------------------------------------------------------------------------------------------------------------------
local function onResourceStart()
	local txd = engineLoadTXD("assets/txd/"..skinID..".txd")
	engineImportTXD(txd, skinID)
	local dff = engineLoadDFF("assets/txd/"..skinID..".dff", skinID)
	engineReplaceModel(dff, skinID)
end
addEventHandler("onClientResourceStart", resourceRoot, onResourceStart)
--------------------------------------------------------------------------------------------------------------------------------
local function teste()
    for i = 1, amount do
        local ped = createPed(0, posX + (i * distance), posY, posZ)
        givePedWeapon(ped, weaponID, 1, true)
        local shader = dxCreateShader(shaderCode, 0, 0, false, "ped")
        local texture = dxCreateTexture("assets/gfx/"..i..".png")
        dxSetShaderValue(shader, "tex", texture)
        engineApplyShaderToWorldTexture(shader, textureName, ped)
        if aim then
            setPedControlState(ped, "aim_weapon", true)
        end
    end
end
addCommandHandler("teste", teste)
--------------------------------------------------------------------------------------------------------------------------------