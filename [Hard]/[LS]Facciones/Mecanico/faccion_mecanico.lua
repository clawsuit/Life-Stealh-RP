addCommandHandler("lidermecanico", function(player, cmd, who)

	if not notIsGuest( player ) then

		if permisos[getACLFromPlayer(player)] == true then

			if tonumber(who) then

				local thePlayer = getPlayerFromPartialNameID(who)

				if (thePlayer) then

					if thePlayer:getData("Roleplay:faccion") ~="" then

						player:outputChat(_getPlayerNameR(thePlayer).." se encuentra en una facción debe dejar su facción para que le puedas dar el lider de mecanico.", 150, 50, 50, true)

					else

						local s = query("SELECT * From `Facciones` where Faccion = ? and Lider=?", 'Mecanico', 'Si')

						if ( type( s ) == "table" and #s == 0 ) or not s then

							player:outputChat("* Le acabas de entregar el lider a #FFFFFF".._getPlayerNameR(player).."", 50, 100, 50, true)

							--

							thePlayer:outputChat("* Acabas de ser entregado el Lider de la facción de Mecanico", 50, 150, 50, true)

							--

							insert("insert into `Facciones` VALUES (?,?,?,?,?,?,?)", 'Mecanico', AccountName(thePlayer), 'Dueño', '0', 'Si', '', 'No')

							--

							thePlayer:setData("Roleplay:faccion", "Mecanico")

							thePlayer:setData("Roleplay:faccion_lider", "Si")

							thePlayer:setData("Roleplay:faccion_rango", "Dueño")

							thePlayer:setData("Roleplay:faccion_sueldo", 0)

							thePlayer:setData("Roleplay:faccion_division", "")

							thePlayer:setData("Roleplay:faccion_division_lider", "No")

						else

							player:outputChat("* Ya se encuentra un lider en mando: #FF0033"..s[1]["Nombre"], 115, 115, 115, true)

						end

					end

				else

					player:outputChat("Syntax: /lidermecanico [ID]", 255, 255, 255, true)

				end

			else

				local thePlayer = getPlayerFromPartialName(who)

				if (thePlayer) then

					if thePlayer:getData("Roleplay:faccion") ~="" then

						player:outputChat(_getPlayerNameR(thePlayer).." se encuentra en una facción debe dejar su facción para que le puedas dar el lider de mecanico.", 150, 50, 50, true)

					else

						local s = query("SELECT * From `Facciones` where Faccion = ? and Lider=?", 'Mecanico', 'Si')

						if ( type( s ) == "table" and #s == 0 ) or not s then

							player:outputChat("* Le acabas de entregar el lider a #FFFFFF".._getPlayerNameR(thePlayer).."", 50, 100, 50, true)

							--

							thePlayer:outputChat("* Acabas de ser entregado el Lider de la facción de Mecanico", 50, 150, 50, true)

							--

							insert("insert into `Facciones` VALUES (?,?,?,?,?,?,?)", 'Mecanico', AccountName(thePlayer), 'Dueño', '0', 'Si', '', 'No')

							--

							thePlayer:setData("Roleplay:faccion", "Mecanico")

							thePlayer:setData("Roleplay:faccion_lider", "Si")

							thePlayer:setData("Roleplay:faccion_rango", "Dueño")

							thePlayer:setData("Roleplay:faccion_sueldo", 0)

							thePlayer:setData("Roleplay:faccion_division", "")

							thePlayer:setData("Roleplay:faccion_division_lider", "No")

						else

							player:outputChat("* Ya se encuentra un lider en mando: #FF0033"..s[1]["Nombre"], 115, 115, 115, true)

						end

					end

				else

					player:outputChat("Syntax: /lidermecanico [ID]", 255, 255, 255, true)

				end

			end

		end

	end

end)



addCommandHandler("repararveh", function(player, cmd)

	if isElement(player) then

		if not notIsGuest(player) then

			if getPlayerFaction(player, "Mecanico") then

				local veh = player:getOccupiedVehicle()

				local seat = player:getOccupiedVehicleSeat()

				if player:isInVehicle() then

					if veh and seat == 0 then

						local owner = veh:getData("Owner")

						if owner then

							local thePlayer = getPlayerFromPartialName(owner)

							if (thePlayer) then

								local costoTotal = math.ceil(0.5*veh:getHealth())

								veh:fix()

								--

								player:outputChat("Acabas de reparar el vehículo de ".._getPlayerNameR(thePlayer).."", 50, 150, 50, true)

								thePlayer:outputChat("El mecanico: ".._getPlayerNameR(player).." acaba de reparar tu vehículo por el costo de: #004500$"..convertNumber(costoTotal).." dólares", 50, 150, 50, true)

								--

								thePlayer:takeMoney(tonumber(costoTotal))

							end

						end

					end

				end

			end

		end

	end

end)