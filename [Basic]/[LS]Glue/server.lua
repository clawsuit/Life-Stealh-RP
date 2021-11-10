loadstring(exports["[LS]NewData"]:getMyCode())()
import('*'):init('[LS]NewData')

local offsets = {
	[407] = {left={-1,-3.7,0.23},right={1,-3.7,0.23}}, -- fire truck
	[544] = {left={-1,-3.7,0.23},right={1,-3.7,0.23}}, -- fire truck leadder
	[487] = {left={-1,1.7,-0.1},right={1,1.7,-0.1}, leftB={-1,-0.1,-0.1}, rightB={1,-0.1,-0.1}}, -- maverick
	[497] = {left={-1,1.7,-0.1},right={1,1.7,-0.1}, leftB={-1,-0.1,-0.1}, rightB={1,-0.1,-0.1}}, --  police maverick
	[408] = {left={-1.1,-3.5,-0.14},right={1.2,-3.5,-0.14}}, -- trashmaster
	[488] = {left={-1,0.7,-0.1},right={1,0.7,-0.1}}, -- new shopper
}

local aVehicles = {}


addCommandHandler('pegar',
	function(player)
		if isElement(player) then
			local Pegado = getDato(player, 'Pegado')
			print(Pegado)
			if not Pegado then
				local veh = getPlayerNearbyVehicle(player,5)
				if veh then
					if offsets[veh.model] then
						aVehicles[veh] = aVehicles[veh] or {}
						if veh.model ~= 487 and veh.model ~= 497 then
							if not aVehicles[veh].left then

								aVehicles[veh].left = player
								player:attach(veh, unpack(offsets[veh.model].left))
								setDato(player, 'Pegado', {'left',veh}, true)
							elseif not aVehicles[veh].right then

								aVehicles[veh].right = player
								player:attach(veh, unpack(offsets[veh.model].right))
								setDato(player, 'Pegado', {'right',veh, true})
							end
						elseif veh.model == 487 or veh.model == 497 then
							if not aVehicles[veh].left then

								aVehicles[veh].left = player
								player:attach(veh, unpack(offsets[veh.model].left))
								setDato(player, 'Pegado', {'left',veh}, true)
							elseif not aVehicles[veh].right then

								aVehicles[veh].right = player
								player:attach(veh, unpack(offsets[veh.model].right))
								setDato(player, 'Pegado', {'right',veh, true})
							elseif not aVehicles[veh].leftB then

								aVehicles[veh].leftB = player
								player:attach(veh, unpack(offsets[veh.model].leftB))
								setDato(player, 'Pegado', {'leftB',veh, true})
							elseif not aVehicles[veh].rightB then

								aVehicles[veh].rightB = player
								player:attach(veh, unpack(offsets[veh.model].rightB))
								setDato(player, 'Pegado', {'rightB',ve, trueh})
							end
						end
					end
				end
			else
				player:detach()
				aVehicles[Pegado[2]][Pegado[1]] = nil
				setDato(player, 'Pegado', false, true)
			end
		end
	end
)


function getPlayerNearbyVehicle(player, range)
	if isElement(player) then
		for i,veh in ipairs(Element.getAllByType('vehicle')) do
			local vx,vy,vz = getElementPosition( veh )
			local px,py,pz = getElementPosition( player )
			if getDistanceBetweenPoints3D(vx,vy,vz, px,py,pz) < range then
				return veh
			end
		end
	end
	return false
end

addEventHandler( "onResourceStop", resourceRoot, 
	function()
		for i,player in ipairs(Element.getAllByType('player')) do
			setDato(player, 'Pegado', false, true)
		end
	end
)

addEventHandler( "onResourceStart", resourceRoot, 
	function()
		for i,player in ipairs(Element.getAllByType('player')) do
			setDato(player, 'Pegado', false, true)
		end
	end
)
