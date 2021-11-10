local inCol = false

addEventHandler( "onClientColShapeHit", root, 
	function(element)
		if element and element.type == 'player' then
			if source:getData('weapon_data') then	
				inCol = source
			end
		end
	end
)

addEventHandler( "onClientColShapeLeave", root, 
	function(element)
		if element and element.type == 'player' then
			if source:getData('weapon_data') then
				inCol = false
			end
		end
	end
)

addEventHandler( "onClientRender", getRootElement(), 
	function()
		if inCol and inCol ~= nil and inCol ~= false then
			if isElement(inCol) then
				if localPlayer:isWithinColShape(inCol) then
					local sx,sy = getScreenFromWorldPosition(inCol.position.x,inCol.position.y,inCol.position.z+.6)
					local w = dxGetTextWidth( 'Pulsa K para recoger esta arma', 1, 'default-bold')
					dxDrawText('Pulsa K para recoger esta arma',sx-w/2,sy,sx,sy,tocolor(255,255,255,255),1,'default-bold')
				end
			end
		end
	end
)
--setElementRotation(inCol:getData('weapon_data')[1], 90,y,z)
addEventHandler( "onClientKey", getRootElement(), 
	function(key,press)
		if inCol and inCol ~= nil and inCol ~= false then
			if isElement(inCol) then
				if inCol and localPlayer:isWithinColShape(inCol) then
					if #getElementsWithinColShape(inCol,'player') == 1 then
						if (key == 'k') and (press) then
							triggerLatentServerEvent('onGiveWeapon',5000,false,resourceRoot,inCol:getData('weapon_data'))
							inCol = false
						end
					end
				end
			end
		end
	end
)

Timer(function()
	for k,v in pairs(getElementsByType('player')) do
		if v.health <=30 then
			setPedFootBloodEnabled(v, true)
		else
			setPedFootBloodEnabled(v, false)
		end
	end
end,100,0)

