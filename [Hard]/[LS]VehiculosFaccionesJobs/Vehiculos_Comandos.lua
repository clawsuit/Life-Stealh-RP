local bicicletas = {

[510]=true,

[481]=true,

[509]=true,

}



addEventHandler("onVehicleEnter", getRootElement(), function( player, seat, jacked, door )

	if source:getHealth() <= 280 then

		source:setEngineState (false)

		source:setFrozen(false)

		source:setLightState(0, 1)

		source:setLightState(1, 1)

		source:setData('Motor', 'apagado')

	end

	if seat == 0 then

		if not bicicletas[source:getModel()] then

			if source:getHealth() >= 281 then

				if source:getData('Motor') == 'apagado' then

					local gas = getElementData(source, "Fuel") or 0

					if gas >= 1 then 

						source:setEngineState (false)

						source:setLightState(0, 1)

						source:setLightState(1, 1)

						exports['[LS]Notificaciones']:setTextNoti(player, "Usa el comando #00FF00/motor #FFFFFFpara encender/apagar el vehículo.")

					end

					source:setFrozen(false)

				end	

			else

				source:setEngineState (false)

				source:setFrozen(false)

				source:setLightState(0, 1)

				source:setLightState(1, 1)

				source:setData('Motor', 'apagado')

				player:outputChat("¡El motor esta malogrado, necesita reparación el vehículo!", 150, 50, 50, true)

			end

		end

	end

end) 



addCommandHandler("motor", function(player)

	if not notIsGuest(player) then

		if player:isInVehicle() then

			local veh = player:getOccupiedVehicle()

			local seat = player:getOccupiedVehicleSeat()

			if not bicicletas[veh:getModel()] then

				if veh and seat == 0 then

					local gas = getElementData(veh, "Fuel") or 0

					if gas >= 1 then 

						if not player:getData("EnGasolinera") then

							if veh:getHealth() >= 281 then

								if veh:getData('Motor') == 'apagado' then

									MensajeRol(player, " esta encendiendo el motor del vehículo")

									--

									setTimer(function(player, veh)

										MensajeRol(player, "El motor del vehículo de ".._getPlayerNameR(player).." fue encendido (".._getPlayerNameR(player)..")", 1)

										veh:setEngineState(true)

										veh:setData('Motor','encendido',false)

										veh:setFrozen(false)

									end, 1500, 1, player, veh)

									for i,v in ipairs(getPlayersOverArea(player,10)) do

										v:triggerEvent('SonidoEncenderVeh',v,'auto')

									end

								else

									MensajeRol(player, " apago el motor del vehículo")

									--

									setTimer(function(player, veh)

										MensajeRol(player, "El motor del vehículo de ".._getPlayerNameR(player).." fue apagado (".._getPlayerNameR(player)..")", 1)

										veh:setEngineState(false)

										veh:setData('Motor','apagado')

									end, 500, 1, player, veh)

								end

							end

						end

					end

				end

			end

		end;

	end

end)



function getPlayersOverArea(player,range)

	local new = {}

	local x, y, z = getElementPosition( player )

	local chatCol = ColShape.Sphere(x, y, z, range)

	new = chatCol:getElementsWithin("player") or {}

	chatCol:destroy()

	return new

end



local veh_sirens = {}

local sirensOffs = {

	[596] = {{0.5, -0.5, 1},{-0.5, -0.5, 1},{0, -0.5, 1},{255,0,0},{0,0,255}},

	[597] = {{0.5, -0.5, 1},{-0.5, -0.5, 1},{0, -0.5, 1},{255,0,0},{0,0,255}},

	[598] = {{0.5, -0.5, 1},{-0.5, -0.5, 1},{0, -0.5, 1},{255,0,0},{0,0,255}},

	[599] = {{0.5, 0.5, 1.2},{-0.5, 0.5, 1.2},{0, 0.5, 1.2},{255,0,0},{0,0,255}},

	[490] = {{0.5, 0.5, 1.2},{-0.5, 0.5, 1.2},{0, 0.5, 1.2},{255,0,0},{0,0,255}},

	[528] = {{0.5, 0.5, 1.1},{-0.5, 0.5, 1.1},{0, 0.5, 1.1},{255,0,0},{0,0,255}},

	[427] = {{0.3, 0.8, 1.2},{-0.3, 0.8, 1.2},{0, 0.8, 1.2},{255,0,0},{0,0,255}},

	[523] = {{0.3, -1, 0.5},{-0.3, -1, 0.5},{0, -1, 0.5},{255,0,0},{0,0,255}},

	[416] = {{0.3, 1.2, 1.2},{-0.3, 1.2, 1.2},{0, 1.2, 1.2},{255,0,0},{0,0,255}},

	[407] = {{0.7, 3.2, 1.3},{-0.7, 3.2, 1.3},{0, 3.2, 1.3},{255,255,0},{255,255,0}},

	[544] = {{0.6, 3.2, 1.3},{-0.6, 3.2, 1.3},{0, 3.2, 1.3},{255,255,0},{255,255,0}},

	[433] = {{0.4, 1, 1.8},{-0.4, 1, 1.8},{0, 1, 1.8},{73,41,3},{73,41,3}},



}

function toggleHordVehicle(player)

	local veh = player.vehicle;

	local seat = player:getOccupiedVehicleSeat()

	if veh and seat == 0 or seat == 1 then

		local id = veh.model;

		if id == 596 or id == 597 or id == 598 or id == 599 or id == 490 or id == 528 or id == 427 or id == 523 or id == 416 or id == 407 or id == 544 or id == 433 then
			
			if not veh_sirens[veh] then

				veh_sirens[veh] = true
				setVehicleSirensOn( veh, true )

				triggerClientEvent('SirenaConfig',root, veh)
				addVehicleSirens(veh,3,2,false,false,true)

				local fr,fg,fb = unpack(sirensOffs[id][1]) 

				local r,g,b = unpack(sirensOffs[id][4])

				setVehicleSirens(veh, 1, fr,fg,fb, (r or 255), (g or 0), (b or 0), 255, 255 )

				local fr,fg,fb = unpack(sirensOffs[id][2])

				local r,g,b = unpack(sirensOffs[id][5])

				setVehicleSirens(veh, 2, fr,fg,fb, (r or 0), (g or 0), (b or 255), 255, 255 )

				local fr,fg,fb = unpack(sirensOffs[id][3])

				setVehicleSirens(veh, 3, fr,fg,fb, 255, 255, 255, 255, 255 )
			
			else

				removeVehicleSirens(veh)
				triggerClientEvent('SirenaConfig',root, veh)
			
				veh_sirens[veh] = nil
				setVehicleSirensOn( veh, false)

			end
		end

	end

end


function startJoin()

	if eventName == 'onPlayerJoin' then

		bindKey(source,"horn","down", toggleHordVehicle )

	else

		for i,v in ipairs(Element.getAllByType('player')) do
			bindKey(v,"horn","down", toggleHordVehicle )
		end

	end
end
addEventHandler( "onPlayerJoin", getRootElement(), startJoin )
addEventHandler( "onResourceStart", getResourceRootElement(  ), startJoin )

addCommandHandler("luces", function(player)

	if not notIsGuest(player) then

		local veh = player:getOccupiedVehicle()

		local seat = player:getOccupiedVehicleSeat()

		if player:isInVehicle() and veh and seat == 0 then

			if not bicicletas[veh:getModel()] then

				if veh:getLightState(0) == 1 and veh:getLightState(1) == 1 then

					player:outputChat("Luces encendidas", 0, 255, 0, true)

					veh:setLightState(0, 0)

					veh:setLightState(1, 0)

					player:setData("TextInfo", {"> encendio las luces de su ".. getVehicleNameFromModel(veh:getModel()), 255, 0, 216})

					setTimer(function(p)

						if isElement(p) then

						p:setData("TextInfo", {"", 255, 0, 216})

					end

					end, 2000, 1, player)

				else

					player:outputChat("Luces apagadas", 150, 50, 50, true)

					veh:setLightState(0, 1)

					veh:setLightState(1, 1)

					player:setData("TextInfo", {"> apago las luces de su ".. getVehicleNameFromModel(veh:getModel()), 255, 0, 216})

					setTimer(function(p)

						if isElement(p) then

						p:setData("TextInfo", {"", 255, 0, 216})

					end

					end, 2000, 1, player)

				end

			end

		end

	end

end)







setTimer(

	function()

		for i,v in ipairs(Element.getAllByType('vehicle')) do

			if v and isElement(v) then

				if v:getData('Motor') ~= 'apagado' and v:getData('Motor') ~= 'encendido' then

					v:setData('Motor','apagado')

					v:setFrozen(true)

				end

			end

		end

	end

,100,0)



