print(exports.MySQL:getMyCode())--loadstring()()
--import('*'):init('MySQL')
--import('*'):init('[LS]Notificaciones')
--import('*'):init('[LS]NewData')


local sx_, sy_ = guiGetScreenSize()
local sx, sy = sx_/1280, sy_/768

local timeToVehicle = false
local timerVehicle = false
local inMision = false
local inMision2 = false
local blip = false
local marker = false
local aReload = false

local pagaBase = 20
local bonoDistancia = 0
local bonoDmg = 0
local client = getLocalPlayer(  )
local _camion = false



addEventHandler("onClientTrailerAttach", getRootElement(),
	function(vehicle)

		if vehicle == _camion and getDato(vehicle,'Trailer') == source then

			if vehicle:getController() == client then

				if inMision then

					setDato(vehicle, 'Atachado',  true)
					setTextNoti('¡Trailer atachado con exito!', 0, 255, 0)

					if source:isDamageProof() == true then

						triggerServerEvent('onCamionero', resourceRoot, {'proof', source})

					end

					if not inMision2 then

						inMision2 = true
						endMisionCamionero()

					end

				end

			end

		end

	end
)

addEventHandler("onClientTrailerDetach", getRootElement(),
	function(vehicle)

		if vehicle == _camion and getDato(vehicle,'Trailer') == source then

			if vehicle:getController() == client then

				if inMision then

					setDato(vehicle, 'Atachado',  false)

					setTextNoti('Tu cargamento se ha soltado, sin el no podras finalizar la entrega!', 255, 0, 0)

				end

			end

		end

	end
)



addEventHandler( "onClientPlayerVehicleEnter", client,
	function(vehicle,seat)

		if source == client and client:getData('Roleplay:trabajo') == 'Camionero' then

			if vehicle:getData('VehiculoPublico') == 'Camionero' and seat == 0 then

				if not inMision then

					inMision = true
					_camion = vehicle
					startMisionCamionero()

				else
					if aReload then

						resetTimer( reloadMision )

					end

					if isTimer(timerVehicle) then
						killTimer(timerVehicle)
						timeToVehicle = false
					end

				end

			end

		end

	end
)

addEventHandler( "onClientPlayerVehicleExit", client,
	function(vehicle,seat)

		if source == client and client:getData('Roleplay:trabajo') == 'Camionero' then

			if vehicle:getData('VehiculoPublico') == 'Camionero' and seat == 0 then

				if inMision then

					timeToVehicle = 60
					timerVehicle = Timer(cancelMisionCamionero, 1000, 0)
						
					if aReload then

						killTimer( reloadMision )

					end

				end

			end

		end

	end
)

function startMisionCamionero()

	local v = table.random(Camionero.LugaresCarga, 'v')

	if v then

		local x,y,z = v[1],v[2],v[3]
		bonoDistancia = {x,y,z}
		clearPuntos()

		blip =  Blip(x, y, z, 0, 3, 91, 54, 15)
		triggerServerEvent('onCamionero', resourceRoot, {'crear', _camion, x, y, z})
		outputChatBox('Central de pedidos -> Se a Ubicado una Nueva Carga en '..getZoneName( x,y,z ), 255,255, 0)

	end

end

function endMisionCamionero(  )
	
	local v = table.random(Camionero.LugaresDescarga, 'v')

	if v then
		local x,y,z = v[1],v[2],v[3]
		bonoDistancia = 0.05 * getDistanceBetweenPoints3D(bonoDistancia[1], bonoDistancia[2], bonoDistancia[3], x, y, z)
		clearPuntos()

		blip =  Blip(x, y, z, 0, 3, 91, 54, 15)
		marker = Marker( x,y,z, 'cylinder', 2, 91, 54, 15, 150)

		addEventHandler('onClientMarkerHit', marker, 
			function(hit)

				if hit == client then

					if hit.vehicle and hit.vehicle == _camion then

						if getDato(_camion, 'Atachado') then

							if inMision and inMision2 then

								inMision2 = false
								bonoDmg = _camion:getHealth()/10 < 91 and -math.random(4,6) or math.random(4,6)
								local paga = (pagaBase + bonoDmg) + bonoDistancia

								outputChatBox('Carga Entregada con Exito!', 0,255, 0)
								setTextNoti('Bono -> '..(bonoDmg < 0 and ('-'..math.abs(bonoDmg)..'$ por carga en mal estado') or ('+'..bonoDmg..'$ por carga en buen estado') ))
								setTextNoti('Bono -> extra por distancia '..bonoDistancia)
								setTextNoti('Total -> '..paga..'$')

								triggerServerEvent('onCamionero', resourceRoot, {'clear', _camion, tonumber(paga)})
								outputChatBox('Central de pedidos -> Enseguida se le asignara otra entrega', 255,255, 0)

								bonoDmg = 0
								bonoDistancia = 0
								aReload = true

								reloadMision = Timer(
									function()
										
										aReload = false
										startMisionCamionero()

									end
								,10000,1)

								clearPuntos()

							end

						else

							setTextNoti('Haz perdido el cargamento, regresa por el', 255, 0, 0)

						end

					end

				end

			end

		)


	end

end

function cancelMisionCamionero()

	if timeToVehicle > 0 then

		timeToVehicle = timeToVehicle - 1

	else

		clearPuntos()
		timeToVehicle = false
		timerVehicle = false
		aReload = false
		inMision = false
		inMision2 = false
		blip = false
		marker = false

		triggerServerEvent('onCamionero', resourceRoot, {'clear', _camion})
		triggerServerEvent('Roleplay:respawnVehPub',getResourceRootElement( getResourceFromName( '[LS]VehiculosFaccionesJobs' ) ), _camion)

		bonoDistancia = 0
		bonoDmg = 0
		_camion = false

		if isTimer(reloadMision) then

			killTimer( reloadMision )

		end

		if isTimer(timerVehicle) then

			killTimer( timerVehicle )

		end
	end
end



function clearPuntos()

	if isElement( blip ) then
		blip:destroy()
	end

	if isElement( marker ) then
		marker:destroy()
	end

end




local X,Y,Z = 2130.515625, -2146.7553710938, 13.546875


addEventHandler("onClientRender", getRootElement(), 
	function()

	--

		if localPlayer:getData("Roleplay:trabajo") == "Camionero" then

			--if timeToVehicle then

			--	local segundos = timeToVehicle or 0

			--	dxDrawBourdeText(1, "#FF0033"..segundos.."#FFFFFF segundos\npara volver a subir a tu camion.", 96*sx, 502*sy, 251*sx, 532*sy, tocolor(255, 255, 255, 255),tocolor(0,0,0), 1, "default-bold", "center", "center")
				dxDrawBourdeText(1, "distance: "..math.floor(getDistanceBetweenPoints3D(localPlayer.position, X,Y,Z)), 96*sx, 502*sy, 251*sx, 532*sy, tocolor(255, 255, 255, 255),tocolor(0,0,0), 1, "default-bold", "center", "center")

			--end

		end
	 
	--

		local playerX2, playerY2, playerZ2 = getElementPosition ( localPlayer )

		for k, v in pairs(Camionero.LugaresDeTrabajo) do

			local playerX, playerY, playerZ = v[1], v[2], v[3]

			local sx, sy = getScreenFromWorldPosition(playerX, playerY, playerZ + 0.5)

			if sx and sy then

				local cx, cy, cz = getCameraMatrix()

				local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX, playerY, playerZ + 0.5)
				local scale = 1.1-((distance/20)/1.5)

				if distance < 20 then

					dxDrawBourdeText (1, v[4], sx, sy, sx, sy , tocolor (0, 255, 0, 255 ),tocolor(0,0,0), scale, "default-bold","center", "center", false,false,false,true) 

				end

			end

		end

	--

	end
)

