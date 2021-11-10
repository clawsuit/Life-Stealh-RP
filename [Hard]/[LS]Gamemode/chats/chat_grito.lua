local antiSpamGrito  = {} 
function chatGrito( source, cmd, ... )
	if not source:getAccount():isGuest () then
		if (source:isMuted()) then
			source:outputChat("No puedes escribir, estás muteado.. ", 150, 0, 0)
		return
		end
		local tick = getTickCount()
		if (antiSpamGrito[source] and antiSpamGrito[source][1] and tick - antiSpamGrito[source][1] < 500) then
			--source:outputChat("Espera 2 segundos para enviar un mensaje.. ", 150, 0, 0)
			return
		end
		local message = table.concat({...}, " ")
		if message ~= "" and message ~= " " and message:len() >= 1 then
			local pos = Vector3(source:getPosition())
			local x, y, z = pos.x, pos.y, pos.z
			local nick = _getPlayerNameR( source )
			chatCol = ColShape.Sphere(x, y, z, 20)
			nearPlayers = chatCol:getElementsWithin("player") 
			outputDebugString("[Ingles] "..nick.." grita: ¡¡"..message:upper().."!!", 0, 221, 250, 255)
			for _,v in ipairs(nearPlayers) do
				v:outputChat("#FEFFF0[Ingles] "..nick.." grita: #FFFFFF¡¡"..message:upper().."!!", 221, 250, 255, true)
			end
			if (not antiSpamGrito[source]) then
				antiSpamGrito[source] = {}
			end
			antiSpamGrito[source][1] = getTickCount()
			if isElement( chatCol ) then
				destroyElement( chatCol )
			end
		else
			source:outputChat("Debes escribir más de 1 carácteres.", 150, 0, 0)
		end
	end
end
addCommandHandler({"g"}, chatGrito)