loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

if not getResourceFromName( '[LS]NewData' ) then 
	return outputDebugString( 'Activa el recurso [LS]NewData', 3, 255, 255, 255 )
end

import('*'):init('[LS]NewData')

local MarkersRepairs = {}
-- code money #00DD00
addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(getMarkerRepairs()) do
		Blip( v.Posiciones[1], v.Posiciones[2], v.Posiciones[3], 27, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
		MarkersRepairs[i] = Marker(v.Posiciones[1], v.Posiciones[2], v.Posiciones[3]-1, "cylinder", 3, 27, 100, 0, 50)
		--
		addEventHandler("onMarkerLeave", MarkersRepairs[i], function(player)
			if player and player:getType() =="player" then
				if player:isInVehicle() then
					local veh = player:getOccupiedVehicle()
					local seat = player:getOccupiedVehicleSeat()
					if veh and seat == 0 then
						if getDato(player, "PagarReparacion") == "Si" then
							setDato(player, "PagarReparacion", "No", true)
							--
							exports["[LS]Notificaciones"]:setTextNoti(player, "¡Acabas de cancelar la reparación de tu auto!", 150, 50, 50)
						end
					end
				end
			end
		end)
	end
end)

addCommandHandler("repararvehiculo", function(player, cmd)
	if not notIsGuest(player) then
		local veh = player:getOccupiedVehicle()
		local seat = player:getOccupiedVehicleSeat()
		if player:isInVehicle() then
			if veh and seat == 0 then
				for i, marker in ipairs(MarkersRepairs) do
					if player:isWithinMarker(marker) then
						local costoTotal = math.ceil(0.5*veh:getHealth())
						if veh:getHealth() <= 900 then
							if player:getMoney() >= costoTotal then
								player:outputChat("#FFFF00Reparación de coches", 255, 255, 255, true)
								--
								player:outputChat("#FFFFFFEstas a punto de reparar tu vehículo por favor usa #00FF00/rpagar", 255, 255, 255, true)
								player:outputChat("#FFFFFFCosto de la reparación: #004500$"..convertNumber(costoTotal).." dólares.", 255, 255, 255, true)
								player:outputChat("#FF0033Si te sales del marcador se cancelara el pago.", 255, 255, 255, true)
								--
								setDato(player, "PagarReparacion", "Si", true)
							else
								exports["[LS]Notificaciones"]:setTextNoti(player, "Debes tener: $"..convertNumber(costoTotal).." dólares para reparar tu vehiculo.", 150, 50, 50)
							end
						else
							exports["[LS]Notificaciones"]:setTextNoti(player, "El vehículo debe tener menos de 90% de daño.", 150, 50, 50)
						end
					end
				end
			else
				exports["[LS]Notificaciones"]:setTextNoti(player, "Solamente el conductor puede usar este comando.", 150, 50, 50)
			end
		end
	end
end)

local timerReparacion = {}

addCommandHandler("rpagar", function(player)
	if not notIsGuest(player) then
		local veh = player:getOccupiedVehicle()
		local seat = player:getOccupiedVehicleSeat()
		if player:isInVehicle() then
			if veh and seat == 0 then
				if getDato(player, "PagarReparacion") == "Si" then
					for i, marker in ipairs(MarkersRepairs) do
						if player:isWithinMarker(marker) then
							local costoTotal = math.ceil(0.5*veh:getHealth())
							if veh:getHealth() <= 900 then
								if player:getMoney() >= costoTotal then
									veh:setEngineState(false)
									veh:setLightState(0, 1)
									veh:setLightState(1, 1)
									veh:setData('Motor','apagado')
									veh:setFrozen(true)
									--
									player:outputChat("¡Si te bajas del vehículo se cancelara la reparación!", 150, 50, 50)
									--
									player:triggerEvent("callCinematic", player, "Reparando vehículo..", 5000, "No")

									timerReparacion[player] = setTimer(function(p, veh, cost)
											if isElement(p) and isElement(veh) then
												veh:setFrozen(false)
												veh:setEngineState(true)
												veh:setData('Motor','encendido')
												--
												p:outputChat("¡Tu vehículo: #FFDD80"..veh:getName().." #FFFFFF ha sido reparado satisfatoriamente!", 255, 255, 255, true)
												p:outputChat("Por el costo de: #004500$"..convertNumber(costoTotal).." dólares.", 255, 255, 255, true)
												--
												playSoundFrontEnd(p, 46)
												--
												veh:fix()
												p:takeMoney(tonumber(cost))
												--
												setDato(p, "ReparandoVehiculo", "No", true)
												--
											end
										end, 5000, 1, player, veh, costoTotal)
									--
									setDato(player, "ReparandoVehiculo", "Si", true)
									--
									setDato(player, "PagarReparacion", "No", true)
								else
									exports["[LS]Notificaciones"]:setTextNoti(player, "Debes tener: $"..convertNumber(costoTotal).." dólares para reparar tu vehiculo.", 150, 50, 50)
								end
							else
								exports["[LS]Notificaciones"]:setTextNoti(player, "El vehículo debe tener menos de 90% de daño.", 150, 50, 50)
							end
						end
					end
				end
			end
		end
	end
end)

addEventHandler("onVehicleExit", getRootElement(), function(player, seat, jacked)
	if getDato(player, "ReparandoVehiculo") == "Si" or getDato(player, "PagarReparacion") == "Si" then
		if isTimer(timerReparacion[player]) then
			killTimer(timerReparacion[player])
		end
		--
		exports["[LS]Notificaciones"]:setTextNoti(player, "¡Acabas de cancelar la reparación de tu auto!", 150, 50, 50)
		--
		setDato(player, "ReparandoVehiculo", "No", true)
		setDato(player, "PagarReparacion", "No", true)
	end
end)
