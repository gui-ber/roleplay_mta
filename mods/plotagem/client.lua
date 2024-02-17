--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
function dataChange(key, old, new)
    if key == "Skin" then
        if isElementStreamedIn(source) then
            theTechnique = dxCreateShader("shader.fx")
            local terrain = dxCreateTexture(new)
            dxSetShaderValue(theTechnique, "gTexture", terrain)
            engineApplyShaderToWorldTexture(theTechnique, "?emap*", source)
        end
    end
end
addEventHandler("onClientElementDataChange", root, dataChange)

function streamIn()
    if getElementType(source) == "vehicle" then
        if getElementModel(source) == 490 then
            local skin = getElementData(source, "Skin")
            if skin then
                theTechnique = dxCreateShader("shader.fx")
                local terrain = dxCreateTexture(skin)
                dxSetShaderValue(theTechnique, "gTexture", terrain)
                engineApplyShaderToWorldTexture(theTechnique, "?emap*", source)
            end
        end
    end
end
addEventHandler("onClientElementStreamIn", root, streamIn)

function streamOut()
    if getElementType(source) == "vehicle" then
        local skin = getElementData(source, "Skin")
        if skin then
            engineRemoveShaderFromWorldTexture(theTechnique, "?emap*", source)
        end
    end
end
addEventHandler("onClientElementStreamOut", root, streamOut)