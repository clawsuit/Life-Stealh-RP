--loadstring(exports["[LS]NewData"]:getMyCode())()
--import('getDato,setDato'):init('[LS]NewData')

local valoresJailOOC = {}
local tiempoTimers = {}

addCommandHandler("jail", function(source, cmd, jugador, tiempo, ...)
	if not notIsGuest( source ) then
		if permisos[getACLFromPlayer(source)] == true then
			if tonumber(jugador) then
				local player = getPlayerFromPartialNameID(jugador)
				if (player) and not isPlayerExists(player) then
					if player ~= source then
						if tonumber(tiempo) then
							local razon = table.concat({...}, " ")
							if razon ~="" and razon~= " " then
								-- si se encuentra en un vehiculo lo saca del auto
								if player:isInVehicle() then
									player:removeFromVehicle(player:getOccupiedVehicle())
								end
								for i, v in ipairs(Element.getAllByType("player")) do
									v:outputChat("#FFFFFF"..player:getName().." #e089feestá en JailOOC por culpa de #FFFFFF"..source:getName().." #e089fepor "..tiempo.." #e089feminutos.  #e70909Razón:#FFFFFF "..razon.."#FFFFFF", 255, 255, 255, true)
								end
								--
								player:setTeam(Team.getFromName("Jail OOC"))
								player:setDimension(math.random(0,300))
								player:setInterior(1)
								player:setPosition(1401.6107177734, -15.351807594299, 1000.9095458984)
								player:setData("JailOOC", 0)
								--
								table.insert(valoresJailOOC, {AccountName(player), tonumber(tiempo*60)})
								tiempoTimers[player] = setTimer(bajarTiempoJails, 1000, 0, player)
							end
						end
					end
				end
			else
				local player = getPlayerFromPartialName(jugador)
				if (player) and not isPlayerExists(player) then
					if player ~= source then
						if tonumber(tiempo) then
							local razon = table.concat({...}, " ")
							if razon ~="" and razon~= " " then
								-- si se encuentra en un vehiculo lo saca del auto
								if player:isInVehicle() then
									player:removeFromVehicle(player:getOccupiedVehicle())
								end
								for i, v in ipairs(Element.getAllByType("player")) do
									v:outputChat("#FFFFFF"..player:getName().." #e089feestá en JailOOC por culpa de #FFFFFF"..source:getName().." #e089fepor "..tiempo.." #e089feminutos.  #e70909Razón:#FFFFFF "..razon.."#FFFFFF", 255, 255, 255, true)
								end
								--
								player:setTeam(Team.getFromName("Jail OOC"))
								player:setDimension(math.random(0,300))
								player:setInterior(1)
								player:setPosition(1401.6107177734, -15.351807594299, 1000.9095458984)
								player:setData("JailOOC", 0)
								--
								table.insert(valoresJailOOC, {AccountName(player), tonumber(tiempo*60)})
								tiempoTimers[player] = setTimer(bajarTiempoJails, 1000, 0, player)
							end
						end
					end
				end
			end
		end
	end
end)

addCommandHandler("unjail", function(source, cmd, jugador, ...)
	if not notIsGuest( source ) then
		if permisos[getACLFromPlayer(source)] == true then
			if tonumber(jugador) then
				local player = getPlayerFromPartialNameID(jugador)
				if (player) then
					if player ~= source then
						if isPlayerExists(player) then
							local razon = table.concat({...}, " ")
							if razon ~="" and razon ~=" " then
								for i, v in ipairs(Element.getAllByType("player")) do
									v:outputChat("#FFFFFF"..player:getName().." #e089fesalió de Jail OOC gracias a ".. source:getName().."  #e70909Razón:#FFFFFF "..razon.."", 255, 255, 255, true)
								end
								player:outputChat("* Acabas de salir de jail", 50, 150, 50, true)
								player:setPosition(2098, -1807.3177490234, 13.554069519043)
								player:setInterior(0)
								player:setDimension(0)
								player:setTeam(nil)
								player:setData("JailOOC", 0)
								if isTimer(tiempoTimers[player]) then
									killTimer(tiempoTimers[player])
								end
								for i, v in ipairs(valoresJailOOC) do
									if AccountName(player) == v[1] then
										table.remove(valoresJailOOC, i, v[1])
									end
								end
							end
						end
					end
				end
			else
				local player = getPlayerFromPartialName(jugador)
				if (player) then
					if player ~= source then
						if isPlayerExists(player) then
							local razon = table.concat({...}, " ")
							if razon ~="" and razon ~=" " then
								for i, v in ipairs(Element.getAllByType("player")) do
									v:outputChat("#FFFFFF"..player:getName().." #e089fesalió de Jail OOC gracias a ".. source:getName().."  #e70909Razón:#FFFFFF "..razon.."", 255, 255, 255, true)
								end
								player:outputChat("* Acabas de salir de jail", 50, 150, 50, true)
								player:setPosition(2098, -1807.3177490234, 13.554069519043)
								player:setInterior(0)
								player:setDimension(0)
								player:setTeam(nil)
								player:setData("JailOOC", 0)
								if isTimer(tiempoTimers[player]) then
									killTimer(tiempoTimers[player])
								end
								for i, v in ipairs(valoresJailOOC) do
									if AccountName(player) == v[1] then
										table.remove(valoresJailOOC, i, v[1])
									end
								end
							end
						end
					end
				end
			end
		end
	end
end)


addEventHandler("onPlayerQuit", getRootElement(), function()
	if isTimer(tiempoTimers[source]) then
		killTimer(tiempoTimers[source])
	end
end)

addCommandHandler("jails", function(source)
	if not notIsGuest( source ) then
		if permisos[getACLFromPlayer(source)] == true then
			source:outputChat("* Jugadores encarcelados: ", 50, 150, 50, true)
			for i, v in ipairs(valoresJailOOC) do
				if i == 0 then
					source:outputChat("- Ninguno", 150, 50, 50, true)
				else
					source:outputChat(v[1].. " | Tiempo: "..v[2], 150, 50, 50, true)
				end
			end
		end
	end
end)

function setPlayerJail(player)
	if isElement(player) then
		if player:getType() == "player" then
			tiempoTimers[player] = setTimer(bajarTiempoJails, 1000, 0, player)
			player:setTeam(Team.getFromName("Jail OOC"))
			for i, v in ipairs(valoresJailOOC) do
				if AccountName(player) == v[1] then
					player:outputChat("* Tienes #FF0033"..v[2].."#FFFFFF segundos para salir de jail", 255, 255, 255, true)
				end
			end
		end
	end
end

function isPlayerExists(player)
	for _, v in ipairs (valoresJailOOC) do
		if v[1] == AccountName(player) then
			return true
		end
	end
	return false
end

function getPlayerIndex(tab, index, player)
	for _, v in ipairs (valoresJailOOC) do
		if v[index] == AccountName(player) then
			return _
		end
	end
	return 0
end

function bajarTiempoJails(player)
	for i, v in ipairs(valoresJailOOC) do
		if AccountName(player) == v[1] then
			if v[2] >= 1 then
				v[2] = v[2] - 1
				player:setData("JailOOC", v[2])
			end
			if v[1] and v[2] == 0 then
				table.remove(valoresJailOOC, i, v[1])
				local thePlayer = getPlayerFromPartialName(v[1])
				if (thePlayer) then
					if isTimer(tiempoTimers[thePlayer]) then
						killTimer(tiempoTimers[thePlayer])
					end

					thePlayer:setTeam(nil)
					thePlayer:outputChat("* Acabas de salir de jail", 50, 150, 50, true)
					thePlayer:setPosition(2098, -1807.3177490234, 13.554069519043)
					thePlayer:setInterior(0)
					thePlayer:setDimension(0)
				end
			end
		end
	end
end

