function isInACL(player, acl)
    if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(player)), aclGetGroup(acl)) then
        return true
    else
        return false
    end
end

function numberFormat(value)
	local left,num,right = string.match(value,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())..right
end

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

function secondsToClock(seconds)
	local seconds = tonumber(seconds)
	local hours = string.format("%02.f", math.floor(seconds/3600))
	local mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)))
	local secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60))
	return mins..":"..secs
end

local sm = {}
sm.moov = 0
sm.object1,sm.object2 = nil,nil
local function removeCamHandler()
	if(sm.moov == 1)then
		sm.moov = 0
	end
end
local function camRender()
	if (sm.moov == 1) then
		local x1,y1,z1 = getElementPosition(sm.object1)
		local x2,y2,z2 = getElementPosition(sm.object2)
		setCameraMatrix(x1,y1,z1,x2,y2,z2)
	else
		removeEventHandler("onClientPreRender",root,camRender)
	end
end
function smoothMoveCamera(x1,y1,z1,x1t,y1t,z1t,x2,y2,z2,x2t,y2t,z2t,time)
	if(sm.moov == 1)then
		destroyElement(sm.object1)
		destroyElement(sm.object2)
		killTimer(timer1)
		killTimer(timer2)
		killTimer(timer3)
		removeEventHandler("onClientPreRender",root,camRender)
	end
	sm.object1 = createObject(1337,x1,y1,z1)
	sm.object2 = createObject(1337,x1t,y1t,z1t)
    setElementCollisionsEnabled (sm.object1,false) 
	setElementCollisionsEnabled (sm.object2,false) 
	setElementAlpha(sm.object1,0)
	setElementAlpha(sm.object2,0)
	setObjectScale(sm.object1,0.01)
	setObjectScale(sm.object2,0.01)
	moveObject(sm.object1,time,x2,y2,z2,0,0,0,"InOutQuad")
	moveObject(sm.object2,time,x2t,y2t,z2t,0,0,0,"InOutQuad")
	sm.moov = 1
	timer1 = setTimer(removeCamHandler,time,1)
	timer2 = setTimer(destroyElement,time,1,sm.object1)
	timer3 = setTimer(destroyElement,time,1,sm.object2)
	addEventHandler("onClientPreRender",root,camRender)
	return true
end