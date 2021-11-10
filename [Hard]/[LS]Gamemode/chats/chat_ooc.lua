local antiSpamOOC = {}
function chatOCC( source, cmd, ... )
	if not source:getAccount():isGuest () then
		if (source:isMuted()) then
			source:outputChat("No puedes escribir, estás muteado.. ", 150, 0, 0)
		return
		end
		local tick = getTickCount()
		if (antiSpamOOC[source] and antiSpamOOC[source][1] and tick - antiSpamOOC[source][1] < 2000) then
			source:outputChat("Espera 2 segundos para enviar un mensaje.. ", 150, 0, 0)
			return
		end
		local message = table.concat({...}, " ")
		if message ~= "" and message ~= " " and message:len() >= 1 then
			local pos = Vector3(source:getPosition())
			local x, y, z = pos.x, pos.y, pos.z
			local nick = _getPlayerNameR( source )
			local cuenta = source:getAccount():getName()
			if isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Admin" ) ) then
				tipo = " [#FF0033Administrador#A5F2FF]"
			elseif isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "SuperModerador" ) ) then
				tipo = " [#ECEF3BSuper Moderador#A5F2FF]"
			elseif isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Moderador" ) ) then
				tipo = " [#365DE1Moderador#A5F2FF]"
			elseif isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Enc.Facciones" ) ) then
				tipo = " [#188E16Enc.Facciones#A5F2FF]"
			elseif isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Enc.Ayudas" ) ) then
				tipo = " [#BC02A8Enc.Ayudas#A5F2FF]"
			elseif isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Enc.Familias" ) ) then
				tipo = " [#81852AEnc.Familias#A5F2FF]"
			elseif isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Donador" ) ) then
				tipo = " [#F2F609Donador#A5F2FF]"
			elseif isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Ayudante" ) ) then
				tipo = " [#1EF6E2Ayudante#A5F2FF]"
			else
				tipo = ""
			end
			local message2 = trunklateText( source, message )
			chatCol = ColShape.Sphere(x, y, z, 20)
			nearPlayers = chatCol:getElementsWithin("player") 
			outputDebugString("((OCC))"..tipo..""..nick..": "..message2.."", 0, 165, 242, 255)
			for _,v in ipairs(nearPlayers) do
				v:outputChat("((OCC))"..tipo..""..nick..": #A5F2FF"..message2.."", 165, 242, 255, true)
			end
			if (not antiSpamOOC[source]) then
				antiSpamOOC[source] = {}
			end
			antiSpamOOC[source][1] = getTickCount()
			if isElement( chatCol ) then
				destroyElement( chatCol )
			end
		else
			source:outputChat("Debes escribir más de 1 carácteres.", 150, 0, 0)
		end
	end
end
addCommandHandler({"b", "occ"}, chatOCC)