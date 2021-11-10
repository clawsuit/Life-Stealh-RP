------------ Cono

local conos = {}



addCommandHandler("cono", function(p, cmd)

	if not notIsGuest( p ) then

		if getPlayerFaction( p, "Policia" ) or getPlayerFaction( p, "S.W.A.T." ) or getPlayerFaction( p, "DIC" ) then

			maxConos = #conos

			local pos = Vector3(p:getPosition())

			local x, y, z = pos.x, pos.y, pos.z

			local dim = p:getDimension()

			local int = p:getInterior()

			conos[maxConos + 1] = Object(1238, x, y, z-0.7, 0, 0, 0, false)

			--

			conos[maxConos + 1]:setData("Object:Cono", true)

			--

			conos[maxConos + 1]:setCollisionsEnabled(false)

			conos[maxConos + 1]:setDimension(dim)

			conos[maxConos + 1]:setInterior(int)

		end

	end

end)



addCommandHandler("eliminarcono", function(p, cmd)

	if not notIsGuest( p ) then

		if getPlayerFaction( p, "Policia" ) or getPlayerFaction( p, "S.W.A.T." ) or getPlayerFaction( p, "DIC" ) then

			local pos = Vector3(p:getPosition())

			local x, y, z = pos.x, pos.y, pos.z

			for i, v in ipairs(Element.getWithinRange(x, y, z, 1, "object")) do

				if v:getData("Object:Cono") == true then

					if isElement(v) then

						destroyElement(v)

					end

				end

			end

		end

	end

end)



local barras = {}



addCommandHandler("barra", function(p, cmd)

	if not notIsGuest( p ) then

		if getPlayerFaction( p, "Policia" ) or getPlayerFaction( p, "S.W.A.T." ) or getPlayerFaction( p, "DIC" ) then

			maxBarras = #barras

			local pos = Vector3(p:getPosition())

			local x, y, z = pos.x, pos.y, pos.z

			local rot = Vector3(p:getRotation())

			local rx, ry, rz = rot.x, rot.y, rot.z

			local dim = p:getDimension()

			local int = p:getInterior()

			barras[maxBarras + 1] = Object(1459, x, y, z-0.6, 0, 0, rz, false)

			--

			barras[maxBarras + 1]:setData("Object:Barra", true)

			--

			barras[maxBarras + 1]:setCollisionsEnabled(true)

			barras[maxBarras + 1]:setDimension(dim)

			barras[maxBarras + 1]:setInterior(int)

		end

	end

end)



addCommandHandler("eliminarbarra", function(p, cmd)

	if not notIsGuest( p ) then

		if getPlayerFaction( p, "Policia" ) or getPlayerFaction( p, "S.W.A.T." ) or getPlayerFaction( p, "DIC" ) then

			local pos = Vector3(p:getPosition())

			local x, y, z = pos.x, pos.y, pos.z

			for i, v in ipairs(Element.getWithinRange(x, y, z, 1, "object")) do

				if v:getData("Object:Barra") == true then

					if isElement(v) then

						destroyElement(v)

					end

				end

			end

		end

	end

end)



local valoresArresto = {}

local tiempoArrestos = {}



local posicionesJail = {

[1]={227.35778808594, 110.12662506104, 999.015625},

[2]={223.06430053711, 108.76822662354, 999.015625},

[3]={219.26962280273, 109.43273925781, 999.015625},

[4]={215.07423400879, 109.84159851074, 999.015625},

}



addCommandHandler("arrestar", function(player, cmd, who, money, time, id)

	if not notIsGuest( player ) then

		if getPlayerFaction( player, "Policia" ) or getPlayerDivision( player, "S.W.A.T." ) or getPlayerDivision( player, "DIC" ) then

			if tonumber(who) and tonumber(time) and tonumber(money) then

				local thePlayer = getPlayerFromPartialNameID(who)

				if (thePlayer) and not isPlayerExistsArresto(thePlayer) then

					--if thePlayer ~= player then

						if tonumber(id) >= 1 and tonumber(id) <= 4 then

							--

							thePlayer:outputChat("Has sido arrestado por ".._getPlayerNameR(player).." por "..tonumber(time).." minutos con una multa de $"..money, 150, 50, 50, true)

							--

							player:outputChat("Metistea ".._getPlayerNameR(thePlayer).." a la carcel por "..tonumber(time).." minutos y lo multaste por $"..money, 50, 150, 50, true)

							--

							if thePlayer:isInVehicle() then

								thePlayer:removeFromVehicle(thePlayer:getOccupiedVehicle())

							end

							thePlayer:takeMoney(tonumber(money))

							local x, y, z = posicionesJail[tonumber(id)][1], posicionesJail[tonumber(id)][2], posicionesJail[tonumber(id)][3]

							thePlayer:setPosition(x, y, z)

							thePlayer:setDimension(0)

							thePlayer:setInterior(10)

							--

							table.insert(valoresArresto, {AccountName(thePlayer), tonumber(time*60)})

							--

							tiempoArrestos[thePlayer] = setTimer(bajarTimeArresto, 1000, 0, thePlayer)

						else

							player:outputChat("* Debes colocar el número de celda que estara el preso: 1-4", 150, 50, 50, true)

						end

					--end

				else

					player:outputChat("Puedes colocar el número de celda del 1-6", 150, 50, 50, true)

					player:outputChat("Syntax: /arrestar [ID] [Money] [Time] [Celda]", 255, 255, 255, true)

				end

			else

				if tonumber(time) and tonumber(money) then

					local thePlayer = getPlayerFromPartialName(who)

					if (thePlayer) and not isPlayerExistsArresto(thePlayer) then

						--if thePlayer ~= player then

							if tonumber(id) >= 1 and tonumber(id) <= 6 then

								--

								thePlayer:outputChat("Has sido arrestado por ".._getPlayerNameR(player).." por "..tonumber(time).." minutos con una multa de $"..money, 150, 50, 50, true)

								--

								player:outputChat("Metistea ".._getPlayerNameR(thePlayer).." a la carcel por "..tonumber(time).." minutos y lo multaste por $"..money, 50, 150, 50, true)

								--

								if thePlayer:isInVehicle() then

									thePlayer:removeFromVehicle(thePlayer:getOccupiedVehicle())

								end

								thePlayer:takeMoney(tonumber(money))

								local x, y, z = posicionesJail[tonumber(id)][1], posicionesJail[tonumber(id)][2], posicionesJail[tonumber(id)][3]

								thePlayer:setPosition(x, y, z)

								thePlayer:setDimension(0)

								thePlayer:setInterior(10)

								--

								table.insert(valoresArresto, {AccountName(thePlayer), tonumber(time*60)})

								--

								tiempoArrestos[thePlayer] = setTimer(bajarTimeArresto, 1000, 0, thePlayer)

							else

								player:outputChat("* Debes colocar el número de celda que estara el preso: 1-4", 150, 50, 50, true)

							end

						--end

					else

						player:outputChat("Puedes colocar el número de celda del 1-6", 150, 50, 50, true)

						player:outputChat("Syntax: /arrestar [Nombre] [Money] [Time] [Celda]", 255, 255, 255, true)

					end

				end

			end

		end

	end

end)



addCommandHandler("sacardecarcel", function(player, cmd, who)

	if not notIsGuest( player ) then

		if getPlayerFaction( player, "Policia" ) or getPlayerDivision( player, "S.W.A.T." ) or getPlayerDivision( player, "DIC" ) then

			if tonumber(who) then

				local thePlayer = getPlayerFromPartialNameID(who)

				if (thePlayer) then

					if isPlayerExistsArresto(thePlayer) then

						thePlayer:setTeam(nil)

						thePlayer:outputChat("* Acabas de salr de la carcel", 50, 150, 50, true)

						thePlayer:setPosition(1546.2447509766, -1675.5861816406, 13.561938285828)

						thePlayer:setInterior(0)

						thePlayer:setDimension(0)

						setElementData(thePlayer, "JailOOC", 0)

						if isTimer(tiempoArrestos[thePlayer]) then

							killTimer(tiempoArrestos[thePlayer])

						end

						for i, v in ipairs(valoresArresto) do

							if AccountName(thePlayer) == v[1] then

								table.remove(valoresArresto, i, v[1])

							end

						end

					end

				else

					player:outputChat("Syntax: /sacardecarcel [ID]", 255, 255, 255, true)

				end

			else

				local thePlayer = getPlayerFromPartialName(who)

				if (thePlayer) then

					if isPlayerExistsArresto(thePlayer) then

						thePlayer:setTeam(nil)

						thePlayer:outputChat("* Acabas de salr de la carcel", 50, 150, 50, true)

						thePlayer:setPosition(1546.2447509766, -1675.5861816406, 13.561938285828)

						thePlayer:setInterior(0)

						thePlayer:setDimension(0)

						setElementData(thePlayer, "JailOOC", 0)

						if isTimer(tiempoArrestos[thePlayer]) then

							killTimer(tiempoArrestos[thePlayer])

						end

						for i, v in ipairs(valoresArresto) do

							if AccountName(thePlayer) == v[1] then

								table.remove(valoresArresto, i, v[1])

							end

						end

					end

				else

					player:outputChat("Syntax: /sacardecarcel [Nombre]", 255, 255, 255, true)

				end

			end

		end

	end

end)



addEventHandler("onPlayerQuit", getRootElement(), function()

	if isTimer(tiempoArrestos[source]) then

		killTimer(tiempoArrestos[source])

	end

end)



function setPlayerJailPolice(player)

	if isElement(player) then

		if player:getType() == "player" then

			tiempoArrestos[player] = setTimer(bajarTimeArresto, 1000, 0, player)

			for i, v in ipairs(valoresArresto) do

				if AccountName(player) == v[1] then

					player:outputChat("* Tienes #FF0033"..v[2].."#FFFFFF segundos para salir de la carcel", 255, 255, 255, true)

				end

			end

		end

	end

end



function isPlayerExistsArresto(player)

	for _, v in ipairs (valoresArresto) do

		if v[1] == AccountName(player) then

			return true

		end

	end

	return false

end



function bajarTimeArresto(player)

	for i, v in ipairs(valoresArresto) do

		if AccountName(player) == v[1] then

			if v[2] > 0 then

				v[2] = v[2] - 1

				setElementData(player, "JailOOC", v[2])

			else

				if v[1] then

					table.remove(valoresArresto, i, v[1])

					setElementData(player, "JailOOC", 0)

					print(v[1].." ha sido removida de la tabla de carcel")

					local thePlayer = getPlayerFromPartialName(v[1])
					print(v[1], thePlayer)
					if (thePlayer) then

						if isTimer(tiempoArrestos[thePlayer]) then

							killTimer(tiempoArrestos[thePlayer])

						end

						thePlayer:setTeam(nil)

						thePlayer:outputChat("* Acabas de salr de la carcel", 50, 150, 50, true)

						thePlayer:setPosition(1546.2447509766, -1675.5861816406, 13.561938285828)

						thePlayer:setInterior(0)

						thePlayer:setDimension(0)

					end
				end

			end

		end

	end

end