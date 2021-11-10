local antiSpamDo  = {} 
function chatEtorno( source, cmd, ... )
	if not source:getAccount():isGuest () then
		if (source:isMuted()) then
			source:outputChat("No puedes escribir, estás muteado.. ", 150, 0, 0)
		return
		end
		local tick = getTickCount()
		if (antiSpamDo[source] and antiSpamDo[source][1] and tick - antiSpamDo[source][1] < 500) then
			--source:outputChat(" Espera 2 segundos para enviar un mensaje.. ", 150, 0, 0)
			return
		end
		local message = table.concat({...}, " ")
		if message ~= "" and message ~= " " and message:len() >= 1 then
			local pos = Vector3(source:getPosition())
			local x, y, z = pos.x, pos.y, pos.z
			local nick = _getPlayerNameR( source )
			local message2 = trunklateText( source, message )
			chatCol = ColShape.Sphere(x, y, z, 20)
			nearPlayers = chatCol:getElementsWithin("player") 
			outputDebugString("* "..message2.." (("..nick.."))", 0, 36, 178, 0)
			for _,v in ipairs(nearPlayers) do
				v:outputChat("#24B200 * "..message2.." (("..nick.."))", 36, 178, 0, true)
			end
			if (not antiSpamDo[source]) then
				antiSpamDo[source] = {}
			end
			antiSpamDo[source][1] = getTickCount()
			if isElement( chatCol ) then
				destroyElement( chatCol )
			end
		else
			source:outputChat("Debes escribir más de 3 carácteres.", 150, 0, 0)
		end
	end
end
addCommandHandler({"do"}, chatEtorno)