bikes = {
[509] = true,
[481] = true,
[510] = true,
[449] = true,
[537] = true,
[538] = true,
[569] = true,
[590] = true
}

MenosGastTimers = setTimer(function()
	for i, v in ipairs(Element.getAllByType("vehicle")) do
		if v:getEngineState() == true then
			local gas = (v:getData("Fuel") or 0)
			if gas >= 1 then
				if not (v:getData("RecargandoGasolina") or false) == true then
					v:setData("Fuel", gas - 1)
				end
			else
				v.frozen = true
				v:setEngineState(false)
				v:setLightState(0, 1)
				v:setLightState(1, 1)
				v:setData('Motor','apagado')
			end
		end
	end
end, 30*1000, 0)

function killCar(player, vehicle)
	setVehicleEngineState(vehicle, false)
	toggleControl(player, "accelerate", false)
	toggleControl(player, "brake_reverse", false)
	player:outputChat("Este vehiculo se quedo sin Gasolina!", 255, 0, 0)
end

addEventHandler("onVehicleEnter", getRootElement(), function(thePlayer, seat, jacked )
	local gas = source:getData( "Fuel")
	if gas then
		if seat == 0 then
			local veh = source
			if not bicicletas[veh:getModel()] then
				setTimer(function ( veh, thePlayer )
					if gas then
						if gas >= 1 then
							toggleControl(thePlayer, "accelerate", true)
							toggleControl(thePlayer, "brake_reverse", true)
							if getElementHealth(veh) <= 280 then
								killCar(thePlayer, veh)
							end
						else
							killCar(thePlayer, veh)
						end
					end
				end, 500, 1, veh, thePlayer)
			end
		end
	end
end)

local Gasolineras = {}

addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(getGasolinerasPickups()) do
		Pickup(v[1], v[2], v[3]+0.5, 3, 1650, 0)
		Gasolineras[i] = Marker(v[1], v[2], v[3]-1, "cylinder", 1.5, 255, 255, 255, 0)
		Gasolineras[i]:setInterior(v.int)
		Gasolineras[i]:setDimension(v.dim)
	end
end)

addCommandHandler("llenarbidon", function(p, cmd)
	if not notIsGuest(p) then
		for i, v in ipairs(Gasolineras) do
			if p:isWithinMarker(v) then
				local money = p:getMoney()
				if money >= 500 then
					if exports["[LS]Tiendas"]:getPlayerItem(p, "Bidon Vacio") >= 1 then
						exports["[LS]Tiendas"]:setPlayerItem(p, "Bidon de Gasolina", exports["[LS]Tiendas"]:getPlayerItem(p, "Bidon de Gasolina")+1)
						exports["[LS]Tiendas"]:setPlayerItem(p, "Bidon Vacio", exports["[LS]Tiendas"]:getPlayerItem(p, "Bidon Vacio")-1)
						exports["[LS]Notificaciones"]:setTextNoti(p, "* Tu bidon vacío acaba de ser llenado de gasolina", 50, 150, 50)
						exports["[LS]Notificaciones"]:setTextNoti(p, "El precio es de: #FF0033$500", 50, 150, 50)
						p:takeMoney(500)
					else
						exports["[LS]Notificaciones"]:setTextNoti(p, "No tienes ningún bidon vacío, por favor compra en el mini market", 150, 50, 50)
					end
				end
			end
		end
	end
end)
local timerVeh = {}
--
addCommandHandler("llenarvehiculo", function(player, cmd)
	if not notIsGuest(player) then
		local veh = player:getOccupiedVehicle()
		local seat = player:getOccupiedVehicleSeat()
		if player:isInVehicle() then
			if veh and seat == 0 then
				for i, v in ipairs(Gasolineras) do
					if player:isWithinMarker(v) then
						--
						player:outputChat("#FF0033[#FFFF00ADVERTENCIA#FF0033]#FFFFFF Si te bajas del vehículo, se cancelara.", 255, 255, 255, true)
						--
						player:outputChat("/cancelar", 150, 50, 50, true)
						--
						player:setData("EnGasolinera", true)
						veh:setEngineState(false)
						veh:setData('Motor','apagado')
						--
						timerVeh[player] = setTimer(function(player, veh)
							if isElement(player) then
								if isElement(veh) then
									if veh:getData("Fuel") <= 100 then
										player:takeMoney(25)
										veh:setData("Fuel", veh:getData("Fuel") + 1)
									else
										if isTimer(timerVeh[player]) then
											killTimer(timerVeh[player])
											timerVeh[player] = nil
											player:setData("EnGasolinera", false)
											--
											player:outputChat("Tu vehículo acaba de ser llenado de gasolina.", 50, 150, 50, true)
										end
									end
								end
							end
						end, 1000, 0, player, veh)
					end
				end
			end
		end
	end
end)

addCommandHandler( "cancelar", function(player, cmd)
	if not notIsGuest(player) then
		local veh = player:getOccupiedVehicle()
		local seat = player:getOccupiedVehicleSeat()
		if player:isInVehicle() then
			if veh and seat == 0 then
				if player:getData("EnGasolinera") == true then
					print("xd")
					for i, v in ipairs(Gasolineras) do
						if player:isWithinMarker(v) then
			        		if isTimer(timerVeh[player]) then
			        			killTimer(timerVeh[player])
			        			timerVeh[player] = nil
			        			player:setData("EnGasolinera", false)
			        			player:outputChat("¡Se cancelo la compra de gasolina!", 150, 50, 50, true)
			        		end
						end
					end
				end
			end
		end
	end
end)

addEventHandler("onVehicleExit", getRootElement(),
	function(thePlayer, seat)
        if seat == 0 then
        	if thePlayer:getData("EnGasolinera") == true then
        		if isTimer(timerVeh[thePlayer]) then
        			killTimer(timerVeh[thePlayer])
        			timerVeh[thePlayer] = nil
        			thePlayer:setData("EnGasolinera", false)
        			thePlayer:outputChat("¡Se cancelo la compra de gasolina!", 150, 50, 50, true)
        		end
        	end
        end
	end
)
