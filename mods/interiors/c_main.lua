--[[
██████╗ ███████╗██████╗ 
██╔══██╗██╔════╝██╔══██╗
██████╔╝█████╗  ██████╔╝
██╔══██╗██╔══╝  ██╔══██╗
██████╔╝███████╗██║  ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝
DISCORD: ber#8813
--------------------------------------------------------------------------------------------------------------------------------]]
function doorSound(marker)
    local x, y, z = getElementPosition(marker)
    local int = getElementInterior(marker)
    local dim = getElementDimension(marker)
    local sound = playSound3D("assets/sfx/door.mp3", x, y, z)
    setElementInterior(sound, int)
    setElementDimension(sound, dim)
    setSoundVolume(sound, 1.5)
end
addEvent("playDoorSound", true)
addEventHandler("playDoorSound", resourceRoot, doorSound)
-----------------------------------------------------------------------------------------------------------------------------------------