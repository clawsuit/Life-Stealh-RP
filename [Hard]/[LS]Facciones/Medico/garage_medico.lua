local marcadorSalida = Marker(1414.2526855469, -11.995247840881, 1000.9251708984-1, "cylinder", 3, 100, 100, 100, 0)

marcadorSalida:setInterior(1)

marcadorSalida:setDimension(0)





local marcadorEntrada = Marker(2035.0579833984, -1437.3642578125, 17.301803588867-1, "cylinder", 3, 100, 100, 100, 0)

marcadorEntrada:setInterior(0)

marcadorEntrada:setDimension(0)



addEventHandler("onResourceStart", resourceRoot, function()

	for i, v in ipairs(Element.getAllByType("player")) do

		bindKey(v, "mouse1", "down", function(player)

			if not notIsGuest(player) then

				if getPlayerFaction(player, "Medico") then

					if player:isWithinMarker(marcadorSalida) then

						if getElementDimension( player ) == 0 and getElementInterior( player ) == 1 then

							local veh = player:getOccupiedVehicle()

							local seat = player:getOccupiedVehicleSeat()

							if player:isInVehicle() and veh and seat == 0 then

								veh:setPosition(2035.0579833984, -1437.3642578125, 17.301803588867)

								veh:setRotation(-0, 0, 174.97160339355)

								veh:setInterior(0)

								veh:setDimension(0)

								player:setDimension(0)

								player:setInterior(0)

							else

								player:setPosition(2035.0579833984, -1437.3642578125, 17.301803588867)

								player:setDimension(0)

								player:setInterior(0)

							end

						end

					elseif player:isWithinMarker(marcadorEntrada) then

						

						local veh = player:getOccupiedVehicle()

						local seat = player:getOccupiedVehicleSeat()

						if player:isInVehicle() and veh and seat == 0 then

							veh:setPosition(1414.2526855469, -11.995247840881, 1000.9251708984)

							veh:setDimension(0)

							veh:setRotation(-0, 0, 173.85733032227)

							veh:setInterior(1)

							player:setDimension(0)

							player:setInterior(1)

						else

							player:setPosition(1414.2526855469, -11.995247840881, 1000.9251708984)

							player:setDimension(0)

							player:setInterior(1)

						end

					end
				else

					exports['[LS]Notificaciones']:setTextNoti(player, "Necesitas ser LSRD para poder entrar.", 150, 50, 50)

				end

			end

		end)

	end

end)



addEventHandler("onPlayerLogin", getRootElement(), function()

	bindKey(v, "mouse1", "down", function(player)

			if not notIsGuest(player) then

				if getPlayerFaction(player, "Medico") then

					if player:isWithinMarker(marcadorSalida) then

						if getElementDimension( player ) == 0 and getElementInterior( player ) == 1 then

							local veh = player:getOccupiedVehicle()

							local seat = player:getOccupiedVehicleSeat()

							if player:isInVehicle() and veh and seat == 0 then

								veh:setPosition(2035.0579833984, -1437.3642578125, 17.301803588867)

								veh:setRotation(-0, 0, 174.97160339355)

								veh:setInterior(0)

								veh:setDimension(0)

								player:setDimension(0)

								player:setInterior(0)

							else

								player:setPosition(2035.0579833984, -1437.3642578125, 17.301803588867)

								player:setDimension(0)

								player:setInterior(0)

							end

						end

					elseif player:isWithinMarker(marcadorEntrada) then

						

						local veh = player:getOccupiedVehicle()

						local seat = player:getOccupiedVehicleSeat()

						if player:isInVehicle() and veh and seat == 0 then

							veh:setPosition(1414.2526855469, -11.995247840881, 1000.9251708984)

							veh:setDimension(0)

							veh:setRotation(-0, 0, 173.85733032227)

							veh:setInterior(1)

							player:setDimension(0)

							player:setInterior(1)

						else

							player:setPosition(1414.2526855469, -11.995247840881, 1000.9251708984)

							player:setDimension(0)

							player:setInterior(1)

						end

					end
				else

					exports['[LS]Notificaciones']:setTextNoti(player, "Necesitas ser LSRD para poder entrar.", 150, 50, 50)

				end

			end

		end)

end)





