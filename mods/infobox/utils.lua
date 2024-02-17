function isInACL(player, acl)
    if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(player)), aclGetGroup(acl)) then
        return true
    else
        return false
    end
end
--------------------------------------------------------------------------------------------------------------------------------
function numberFormat(value)
	local left,num,right = string.match(value,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())..right
end
--------------------------------------------------------------------------------------------------------------------------------
function isCursorOnElement(x, y, w, h)
	if isCursorShowing() then
    	local mx, my = getCursorPosition ()
    	local fullx, fully = guiGetScreenSize ()
    	local cursorx, cursory = mx*fullx, my*fully
    	if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
    	    return true
    	else
    	    return false
    	end
	end
end
--------------------------------------------------------------------------------------------------------------------------------
function secondsToClock(seconds)
	local seconds = tonumber(seconds)
	local hours = string.format("%02.f", math.floor(seconds/3600))
	local mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)))
	local secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60))
	return mins..":"..secs
end
--------------------------------------------------------------------------------------------------------------------------------
function lerp(a, b, t)
    return a + (b - a) * t
end