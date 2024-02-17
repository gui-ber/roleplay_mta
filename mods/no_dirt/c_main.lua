--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
local fx = [[
    texture tex;
    technique replace {
        pass P0 {
            Texture[0] = tex;
        }
    }
]]
--------------------------------------------------------------------------------------------------------------------------------
local function onStart()
    local shader = dxCreateShader(fx)
    local texture = dxCreateTexture("assets/gfx/nogrunge.png")
    dxSetShaderValue(shader, "tex", texture)
    engineApplyShaderToWorldTexture(shader, "vehiclegrunge256")
end
addEventHandler("onClientResourceStart", resourceRoot, onStart)
--------------------------------------------------------------------------------------------------------------------------------