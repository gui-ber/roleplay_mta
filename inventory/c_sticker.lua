--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
local shaders = {}
local myShader_raw_data = [[
    texture tex;
    technique replace {
        pass P0 {
            Texture[0] = tex;
        }
    }
]]
---------------------------------------------------------------------------------------------------------------------------
local function dataChange(key, old, new)
    if key == "Skin" then
        if isElementStreamedIn(source) then
            if new ~= false then
                local have = false
                for i, _ in ipairs(shaders) do
                    if shaders[i]["skin"] == new then
                        engineApplyShaderToWorldTexture(shaders[i]["shader"], shaders[i]["texture"], source)
                        shaders[i]["players"] = shaders[i]["players"] + 1
                        have = true
                    end
                end
                if not have then
                    local myShader = dxCreateShader(myShader_raw_data, 0, 0, false, "ped")
                    local myTexture = dxCreateTexture("assets/gfx/skins/"..new..".png")
                    dxSetShaderValue(myShader, "tex", myTexture)
                    engineApplyShaderToWorldTexture(myShader, items[new]["parameters"]["texture"], source)
                    local tabela = { ["shader"] = myShader, ["skin"] = new, ["texture"] = items[new]["parameters"]["texture"], ["players"] = 1 }
                    table.insert(shaders, tabela)
                end
            else
                for i, _ in ipairs(shaders) do
                    if shaders[i]["skin"] == old then
                        engineRemoveShaderFromWorldTexture(shaders[i]["shader"], shaders[i]["texture"], source)
                        shaders[i]["players"] = shaders[i]["players"] - 1
                        if shaders[i]["players"] <= 0 then
                            destroyElement(shaders[i]["shader"])
                            table.remove(shaders, i)
                        end
                    end
                end
            end
        end
    end
end
addEventHandler("onClientElementDataChange", root, dataChange)
---------------------------------------------------------------------------------------------------------------------------
local function streamIn()
    if getElementType(source) == "player" then
        local skin = getElementData(source, "Skin") or false
        if skin then
            local have = false
            for i, _ in ipairs(shaders) do
                if shaders[i]["skin"] == skin then
                    engineApplyShaderToWorldTexture(shaders[i]["shader"], shaders[i]["texture"], source)
                    shaders[i]["players"] = shaders[i]["players"] + 1
                    have = true
                end
            end
            if not have then
                local myShader = dxCreateShader(myShader_raw_data, 0, 0, false, "ped")
                local myTexture = dxCreateTexture("assets/gfx/skins/"..skin..".png")
                dxSetShaderValue(myShader, "tex", myTexture)
                engineApplyShaderToWorldTexture(myShader, items[skin]["parameters"]["texture"], source)
                local tabela = { ["shader"] = myShader, ["skin"] = skin, ["texture"] = items[skin]["parameters"]["texture"], ["players"] = 1 }
                table.insert(shaders, tabela)
            end
        end
    end
end
addEventHandler("onClientElementStreamIn", root, streamIn)
---------------------------------------------------------------------------------------------------------------------------
local function streamOut()
    if getElementType(source) == "player" then
        local skin = getElementData(source, "Skin") or false
        if skin then
            for i, _ in ipairs(shaders) do
                if shaders[i]["skin"] == skin then
                    engineRemoveShaderFromWorldTexture(shaders[i]["shader"], shaders[i]["texture"], source)
                    shaders[i]["players"] = shaders[i]["players"] - 1
                    if shaders[i]["players"] <= 0 then
                        destroyElement(shaders[i]["shader"])
                        table.remove(shaders, i)
                    end
                end
            end
        end
    end
end
addEventHandler("onClientElementStreamOut", root, streamOut)
---------------------------------------------------------------------------------------------------------------------------