--  ____    ______   _____  
-- |  _ \  |  ____| |  __ \ 
-- | |_) | | |__    | |__) |
-- |  _ <  |  __|   |  _  / 
-- | |_) | | |____  | | \ \ 
-- |____/  |______| |_|  \_\
-----------------------------------------------------------------------------------------------------------------------------------------------
weapon = {}
ammo = {}
-----------------------------------------------------------------------------------------------------------------------------------------
local function removeDamage()
	setWeaponProperty(32, "pro", "weapon_range", 0)
	setWeaponProperty(32, "std", "weapon_range", 0)
	setWeaponProperty(32, "poor", "weapon_range", 0)
	setWeaponProperty(32, "pro", "target_range", 0)
	setWeaponProperty(32, "std", "target_range", 0)
	setWeaponProperty(32, "poor", "target_range", 0)
	setWeaponProperty(32, "pro", "accuracy", 0)
	setWeaponProperty(32, "std", "accuracy", 0)
	setWeaponProperty(32, "poor", "accuracy", 0)
	setWeaponProperty(32, "pro", "damage", 0)
	setWeaponProperty(32, "std", "damage", 0)
	setWeaponProperty(32, "poor", "damage", 0)
end
addEventHandler("onResourceStart", resourceRoot, removeDamage)
-----------------------------------------------------------------------------------------------------------------------------------------------
function ToggleApontar(playerSource, state)
	if (state) == "true" then
		toggleControl(playerSource, "fire", false)
		toggleControl(playerSource, "action", false)
		setControlState(playerSource, "fire", false)
		setControlState(playerSource, "action", false)
		if getPedWeapon(playerSource, 4) then
			weapon[playerSource] = getPedWeapon(playerSource, 4)
			ammo[playerSource] = getPedTotalAmmo(playerSource, 4)
		end
		giveWeapon(playerSource, 32, 1, true)
	elseif (state) == "false" then
		takeWeapon(playerSource, 32)
		if weapon[playerSource] then
			giveWeapon(playerSource, weapon[playerSource], ammo[playerSource])
		end
		weapon[playerSource] = nil
		ammo[playerSource] = nil
		toggleControl(playerSource, "fire", true)
		toggleControl(playerSource, "action", true)
	end
end
addEvent("toggleApontar", true)
addEventHandler("toggleApontar", resourceRoot, ToggleApontar)
-----------------------------------------------------------------------------------------------------------------------------------------