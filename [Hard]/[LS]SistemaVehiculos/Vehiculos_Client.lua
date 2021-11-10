addEventHandler("onClientRender", getRootElement(), function()
	local playerX2, playerY2, playerZ2 = getElementPosition ( localPlayer )
	for k, v in ipairs(Vehicle_Datos) do
		local playerX, playerY, playerZ = v.Pos[1], v.Pos[2], v.Pos[3]
		local sx, sy = getScreenFromWorldPosition(playerX, playerY, playerZ + 0.8)
		if sx and sy then
			local cx, cy, cz = getCameraMatrix()
			local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX, playerY, playerZ + 0.8)
			if distance < 5 then
				dxDrawBorderedText3 ( "#FFFF00"..getVehicleNameFromModel( v.ID ).."\n#DDFFDDPrecio: #004500$"..convert(v.Costo).." dólares\n#DDFFDDEspacio de Maletero: #001F4C"..v.Slots, sx, sy, sx, sy , tocolor (0, 255, 0, 255 ),1, "default-bold","center", "center" ) 
			end
		end
	end
end)

function dxDrawBorderedText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) - 1, (y) + 1, (w) - 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end

function convert ( number )  
	local formatted = number  
	while true do      
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')    
		if ( k==0 ) then      
			break   
		end  
	end  
	return formatted
end

--[[loadstring(exports["[RL]NewData"]:getMyCode())()
import('*'):init('[RL]NewData')

local w,h = guiGetScreenSize(  )
local _vehicles = {}

addEventHandler( "onClientRender", getRootElement(), 
	function()
		for i, vehicle in ipairs(Element.getAllByType('vehicle')) do
			if vehicle:getData('Owner') then
				local vehicleMatrix = vehicle.matrix
				local minX, minY, minZ, maxX, maxY, maxZ = vehicle:getBoundingBox()
				local a = vehicleMatrix:transformPosition(Vector3(minX, minY, maxZ))
				local b = vehicleMatrix:transformPosition(Vector3(maxX, minY, maxZ))
			
				local x,y = ((b.x-a.x)/2),((b.y-a.y)/2)
				if not _vehicles[vehicle] then

					_vehicles[vehicle] = createColSphere( b.x-x,b.y-y, vehicleMatrix.position.z+0.4, 1.3 )
					addEventHandler( "onClientColShapeHit", _vehicles[vehicle], 
						function()
							if player == localPlayer and not isPedInVehicle(player) and md then 
								
								print('true')
								setDato(player, 'En col del maletero', true)
							end
						end
					)
					addEventHandler( "onClientColShapeLeave", _vehicles[vehicle], 
						function(player, md)
							if player == localPlayer and not isPedInVehicle(player) and md then 
								setDato(player, 'En col del maletero', true)
							end
						end
					)
					
				else
					setElementPosition(_vehicles[vehicle], b.x-x,b.y-y, vehicleMatrix.position.z)
				end
			end
		end
	end
)]]
