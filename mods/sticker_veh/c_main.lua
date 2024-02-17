--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
function Replace(command, texture)
    if texture then
        if isPedInVehicle(localPlayer) then
            local vehicle = getPedOccupiedVehicle(localPlayer)
            if getElementModel(vehicle) == 490 then
                local theTechnique = dxCreateShader("assets/fx/shader.fx")
                local terrain = dxCreateTexture("assets/gfx/"..texture..".png")
                dxSetShaderValue(theTechnique, "gTexture", terrain)
                engineApplyShaderToWorldTexture(theTechnique, "?emap*", vehicle)
            end
        end
    end
end
addCommandHandler("replace", Replace)