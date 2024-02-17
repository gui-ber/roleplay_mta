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
    local shader1 = dxCreateShader(fx)
    local texture1 = dxCreateTexture("assets/gfx/plate1.png")
    dxSetShaderValue(shader1, "tex", texture1)
    engineApplyShaderToWorldTexture(shader1, "plateback*")
    local shader2 = dxCreateShader(fx)
    local texture2 = dxCreateTexture("assets/gfx/plate2.png")
    dxSetShaderValue(shader2, "tex", texture2)
    engineApplyShaderToWorldTexture(shader2, "vehiclegeneric256")
end
addEventHandler("onClientResourceStart", resourceRoot, onStart)
--------------------------------------------------------------------------------------------------------------------------------