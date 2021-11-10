local sx_, sy_ = guiGetScreenSize()

local sx, sy = sx_/1360, sy_/768


local bicicletas = {

[510]=true,

[481]=true,

[509]=true,

}



local CambioTable = {

[2]="1",

[50]="2",

[80]="3",

[105]="4",

[130]="5",

[160]="6",

}



addEventHandler("onClientRender", getRootElement(), function()

	if not isPlayerMapVisible( ) then

		local veh = getPedOccupiedVehicle(localPlayer)

		if veh then

			if not bicicletas[veh:getModel()] then

				local gas = veh:getData("Fuel") or 0



				if gas then

					local x, y, z = getElementPosition(localPlayer)

					dxDrawRectangle(1140*sx, 600*sy, 210*sx, 95*sy, tocolor(10, 10, 10, 15), false)

					--Ubicación: "..getZoneName(x,y,z).."\nGasolina: "..gas.."%

					local vida = veh:getHealth()

					local kmh = math.ceil(getElementSpeed(veh))

					--

					if CambioTable[kmh] then

						cambio = CambioTable[kmh]

					end

					if kmh <= 1 then

						cambio = "N"

					end

					--

					dxDrawBorderedText("#890037KM/H: #FFFFFF"..(kmh).."\n\n#890037Cambio: #FFFFFF"..(cambio or "N").."\n#BC00D6Ubicación: #FFFFFF"..getZoneName(x,y,z).."\n#BC00D6Combustible: #FFFFFF"..gas.."%\n#BC00D6Salud del "..(tipoauto or "Vehiculo")..": #FFFFFF"..math.ceil(vida/10).."%", 1140*sx, 600*sy, 210*sx + 1140*sx, 95*sy + 600*sy, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center")

				end

			end

		end

	end

	if Rentados then

		for _, rentado in ipairs(Rentados) do

			if not rentado:getData('InRenta') then

				local pos = rentado.position
				local cx,cy,cz = getCameraMatrix()
				local dist = getDistanceBetweenPoints3D( pos, cx,cy,cz )
				local maxDist = 15
				local precio = rentado:getData('Vehiculo:Rentable:Precio')
				local x,y = getScreenFromWorldPosition(pos, 0, false)
				local up = (getElementRadius( rentado ) or 1) * 30

				if dist <= maxDist then

					if x and y then

						dxDrawBourdeText(1, 'Vehiculo Rentable\n#00ff00Precio:'..precio..'\n#ffffff/rentar', x, y-up, x, y, tocolor(255,255,255), tocolor(0,0,0), 1.5-(dist/maxDist), 'default-bold', 'center','center', false, false, false,true)

					end

				end
			elseif rentado:getData('InRenta') == localPlayer then
				
				local segundos = rentado:getData('Vehiculo:Rentable:Duracion')
				local minutos = math.abs(math.floor(segundos/60))
				local tiempo = minutos..' Min ' ..(segundos-(60*minutos))..' Seg'
				local sW = sx_/1280
				dxDrawBourdeText(1, 'Vehiculo Rentado\nDuracion '..tiempo,  96*sW, 502*sy, 251*sW, 532*sy, tocolor(255,255,255), tocolor(0,0,0), 1, 'default-bold', 'center','center', false, false, false,true)

			end

		end

	end

end)

addEvent('onClienVehicleRentaText', true)
addEventHandler('onClienVehicleRentaText', root,
	function(array)

		Rentados = array

	end
)


function getElementSpeed( element )

	if isElement( element ) then

		do

			local x, y, z = getElementVelocity( element )

			return (x ^ 2 + y ^ 2 + z ^ 2) ^ 0.5 * 1.61 * 100

		end

	else

		outputDebugString("Not an element. Can't get speed")

		return false

	end

end



function dxDrawBorderedText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )

	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)

	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)

end





addEvent('SonidoEncenderVeh',true)

addEventHandler('SonidoEncenderVeh', localPlayer,

	function(type)

		local sound = playSound3D( 'http://mp3.pilo.ovh/5417baebc4f8f.mp3', source.position )

		setTimer(destroyElement, 3000, 1, sound)

	end

)



toggleControl('horn', true )



local Sirena = {}



addEvent('SirenaConfig',true)

addEventHandler('SirenaConfig', root,

	function(owner)

		if not Sirena[owner] then

			Sirena[owner] = playSound3D( 'http://mp3.pilo.ovh/0715803ae71fa.mp3', owner.position,true )

			Sirena[owner]:attach(owner)

			setSoundMaxDistance(Sirena[owner], 42 )

			setSoundVolume(Sirena[owner], 0)

		else

			Sirena[owner]:destroy()

			Sirena[owner] = nil

		end
		
	end

)



local bikes = {

[581]=true,

[462]=true,

[521]=true,

[463]=true,

[522]=true,

[461]=true,

[448]=true,

[468]=true,

[586]=true,

[523]=true,

[471]=true,

}



local bicicletas = {

[510]=true,

[481]=true,

[509]=true,

}



addEventHandler("onClientVehicleStartEnter", getRootElement(), function(player,seat,door)

	if seat == 0 then

		if player:getData('Roleplay:faccion') == source:getData("VehiculoPublico") or player:getData("Roleplay:trabajo") == source:getData("VehiculoPublico") or player:getData("Roleplay:Mision") == source:getData("VehiculoPublico") then

			if bikes[source:getModel()] then

				if source:getData("LockedVeh") then

					cancelEvent()

				end

				if source:getData("Locked") == "Cerrado" then

					cancelEvent(  )

					outputChatBox("¡Este vehiculo esta cerrado!", 200, 0, 0)

				end

			end

			if bicicletas[source:getModel()] then

				if source:getData("LockedVeh") then

					cancelEvent()

				end

				if source:getData("CandadoBicicleta") == true then

					setElementFrozen(source, false)

				else

					setElementFrozen(source, true)

				end

			end

		else

			if bikes[source:getModel()] then

				if source:getData("LockedVeh") then

					cancelEvent()
				end

				if source:getData("Locked") == "Cerrado" then

					cancelEvent(  )

					outputChatBox("¡Este vehiculo esta cerrado!", 200, 0, 0)

				end

			end

			if bicicletas[source:getModel()] then

				if source:getData("LockedVeh") then

					cancelEvent()

				end

				if source:getData("CandadoBicicleta") == true then

					setElementFrozen(source, true)

				else

					setElementFrozen(source, false)

				end

			end

		end

	else

		if bikes[source:getModel()] then

			if source:getData("LockedVeh") then

				cancelEvent()
			end

			if source:getData("Locked") == "Cerrado" then

				cancelEvent(  )

				outputChatBox("¡Este vehiculo esta cerrado!", 200, 0, 0)

			end

		end

		if bicicletas[source:getModel()] then

			if source:getData("LockedVeh") then

				cancelEvent()

			end

			if source:getData("CandadoBicicleta") == true then

				setElementFrozen(source, true)

			else

				setElementFrozen(source, false)

			end

		end
	end
end)



addEventHandler("onClientVehicleEnter", getRootElement(), function(player, seat)

	if bicicletas[source:getModel()] then

		if source:getData("CandadoBicicleta") == true then

			setElementFrozen(source, false)

		else

			setElementFrozen(source, true)

		end

	end

end)



addEventHandler( "onClientVehicleExplode", getRootElement(), 

	function()

		if Sirena[source] then

			Sirena[source]:destroy()

		end

	end

)



addEventHandler( "onClientPlayerVehicleEnter", getRootElement(), 

	function(car,seat)

		if seat == 0 then

			if Sirena[car] then

				setSoundVolume(Sirena[car], 0)

			end

		end

	end

)



addEventHandler( "onClientPlayerVehicleExit", getRootElement(), 

	function(car,seat)

		if seat == 0 then

			if Sirena[car] then

				setSoundVolume(Sirena[car], 0.15)

			end

		end

	end

)



Timer(

	function()

		for k,veh in pairs(Element.getAllByType('vehicle')) do

			if veh:getHealth() < 280 then

				veh:setHealth(280)

				veh:setEngineState(false)

				veh:setData('Motor','apagado')

			end

		end

	end

,50,0)

function dxDrawBourdeText(lines, text, x, y, sx, sy, color, color2, size, font, alignX, alignY,clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
	local lines = lines or 2

	for i= -lines, lines, lines do
		for j= -lines, lines, lines do
			dxDrawText( text:gsub('#%x%x%x%x%x%x',''), x + i, y + j, sx + i, sy + j, color2, size, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
		
		end
	end
	dxDrawText( text, x, y, sx, sy, color, size, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
end