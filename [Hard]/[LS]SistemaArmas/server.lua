loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

if getResourceFromName( '[LS]NewData' ):getState() ~= 'running' then 
	return outputDebugString( 'Activa el recurso [LS]NewData', 3, 255, 255, 255 )
end

loadstring(exports["[LS]NewData"]:getMyCode())()
import('*'):init('[LS]NewData')


local Pickup = Pickup(266.91845703125, 118.68565368652, 1004.6171875, 3, 348, 0)
setElementInterior(Pickup, 10)
setElementDimension(Pickup, 0)

local Marcador = Marker(266.91845703125, 118.68565368652, 1004.6171875-1, "cylinder", 1.3, 100, 100, 100, 0)
setElementInterior(Marcador, 10)
setElementDimension(Marcador, 0)

addCommandHandler("armas", function(player, cmd)
	if isElement(player) then
		if not notIsGuest(player) then
			if getPlayerFaction(player, "Policia") then
				player:triggerEvent("OpenWindow", player)
			end
		end
	end
end)