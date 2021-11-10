------------------------------------------------- Pagar dinero

local antiSpamPagarDinero  = {} 



function pagar_jugador ( source, cmd, jugador, monto )

	if not notIsGuest( source ) then

		local tick = getTickCount()

		if (antiSpamPagarDinero[source] and antiSpamPagarDinero[source][1] and tick - antiSpamPagarDinero[source][1] < 10000) then

			source:outputChat("No puedes usar este comando después de 10 segundos", 150, 0, 0)

			return

		end

		--

		if tonumber(jugador) then

			local player = getPlayerFromPartialNameID(jugador)

			if (player) then

				if player ~= source then

					if tonumber(monto) then

						monto = math.floor(math.abs(monto))
						local money = source:getMoney()

						if tonumber(money) >= tonumber(monto) then

							--

							source:outputChat("Le entregaste #004500$"..convertNumber(monto).." dolares #FFFFFFa #329632".._getPlayerNameR(player), 255, 255, 255, true)

							player:outputChat("Recibiste #004500$"..convertNumber(monto).." dolares #FFFFFF de parte de #329632".._getPlayerNameR(source), 255, 255, 255, true)

							--

							player:giveMoney((monto))

							source:takeMoney((monto))

						else

							source:outputChat("No tienes suficiente dinero", 150, 50, 50, true)

						end

					end

				end

			end

		else

			local player = getPlayerFromPartialName(jugador)

			if (player) then

				if player ~= source then

					if tonumber(monto) then

						monto = math.floor(math.abs(monto))
						local money = source:getMoney()

						if tonumber(money) >= tonumber(monto) then

							--

							source:outputChat("Le entregaste #004500$"..convertNumber(monto).." dolares #FFFFFFa #329632".._getPlayerNameR(player), 255, 255, 255, true)

							player:outputChat("Recibiste #004500$"..convertNumber(monto).." dolares #FFFFFF de parte de #329632".._getPlayerNameR(source), 255, 255, 255, true)

							--

							player:giveMoney((monto))

							source:takeMoney((monto))

						else

							source:outputChat("No tienes suficiente dinero", 150, 50, 50, true)

						end

					end

				end

			end

		end

		--

		if (not antiSpamPagarDinero[source]) then

			antiSpamPagarDinero[source] = {}

		end

		antiSpamPagarDinero[source][1] = getTickCount()

	end

end

addCommandHandler({"dardinero", "pagar"}, pagar_jugador)

------------------------------------------------- Pagar dinero

local caminatas = {

["Hombre"] = {"Hombre", 128},

["Mujer"] = {"Mujer", 132},

["Borracho"] = {"Borracho", 126},

["Prostituta"] = {"Prostituta", 132},

["Gang"] = {"Gang", 121},

["Gang2"] = {"Gang2", 122},

}

addCommandHandler({"caminar", "walk"}, function(p, cmd, ...)

	if not notIsGuest(p) then

		local walk = table.concat({...}, " ")

		if walk ~="" and walk ~=" " then

			local s = trunklateText( p, walk )

			if s:find("Hombre") or s:find("hombre") or s:find("Mujer") or s:find("mujer") or s:find("Borracho") or s:find("borracho") or s:find("Prostituta") or s:find("prostituta") or s:find("Gang") or s:find("gang") or s:find("Gang2") or s:find("gang2") then

				p:outputChat("Estilo de caminar: #FF0033"..tostring(caminatas[s][1]), 30, 150, 30, true)

				p:setWalkingStyle(caminatas[s][2])

			else

				p:outputChat("Solamente puedes poner estos estilos: ", 150, 50, 50, true)

				for i, v in pairs(caminatas) do

					p:outputChat(caminatas[i][1], 60, 30, 100, true)

				end

			end

		end

	end

end)



------------------------------------------------- Bug

local antiSpamBug  = {} 

function bug_comando ( source )

	if not notIsGuest( source ) then

		local tick = getTickCount()

		if (antiSpamBug[source] and antiSpamBug[source][1] and tick - antiSpamBug[source][1] < 60000) then

			source:outputChat("No puedes usar este comando después de 60 segundos", 150, 0, 0)

			return

		end

		local posicion = Vector3(source:getPosition())

		local x, y, z = posicion.x, posicion.y, posicion.z

		source:setInterior(0)

		source:setDimension(0)

		source:setPosition(x, y, z+2)

		source:setAnimation()

		if (not antiSpamBug[source]) then

			antiSpamBug[source] = {}

		end

		antiSpamBug[source][1] = getTickCount()

	end

end

addCommandHandler({"bug", "bugeado"}, bug_comando)

------------------------------------------------- PAyuda

local antiSpamAyuda  = {} 

function payuda ( source )

	if not notIsGuest( source ) then

		local tick = getTickCount()

		if (antiSpamAyuda[source] and antiSpamAyuda[source][1] and tick - antiSpamAyuda[source][1] < 5000) then

			source:outputChat("No puedes usar este comando después de 5 segundos", 150, 0, 0)

			return

		end

		source:outputChat("Acabar de enviar una petición de ayuda a los administradores", 150, 0, 0)

		message_staffs(source)

		if (not antiSpamAyuda[source]) then

			antiSpamAyuda[source] = {}

		end

		antiSpamAyuda[source][1] = getTickCount()

	end

end

addCommandHandler({"payuda"}, payuda)



function message_staffs(player)

	if isElement(player) then

		for i, v in ipairs(getElementsByType("player")) do

			local accName = getAccountName ( getPlayerAccount ( v ) )

			if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "SuperModerador" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Moderador" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Ayudante" ) ) then

				v:outputChat("#FC921AEl Jugador: #00FF00*["..player:getData("ID").."]".. removeColorCoding(_getPlayerNameR(player)).." #FC921Anecesita ayuda", 255, 255, 255, true)

				v:outputChat("¡Usa /ir [Nombre_Apellido o ID] para ir donde el!", 255, 255, 255, true)

			end

		end

	end

	return false

end

------------------------------------------------- LimpiarChat

local antiSpamChat  = {} 

function limpiar_chat( source )

	local tick = getTickCount()

	if (antiSpamChat[source] and antiSpamChat[source][1] and tick - antiSpamChat[source][1] < 2000) then

		return

	end

	clearChatBox(source)

	if (not antiSpamChat[source]) then

		antiSpamChat[source] = {}

	end

	antiSpamChat[source][1] = getTickCount()

end

addCommandHandler({"cc", "limpiarchat"}, limpiar_chat)

------------------------------------------------- Staffs Disponibles

function staffs_onServer(source)

	if not notIsGuest( source ) then

		source:outputChat("STAFFS Disponibles:", 66, 57, 76)

		for _, v in ipairs(Element.getAllByType("player")) do

			local accName = getAccountName ( getPlayerAccount ( v ) )

			if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "SuperModerador" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Moderador" ) ) then

				if v:getData("Admin:Disponible") == true then

					source:outputChat("#42644C".._getPlayerNameR(v).." #FFFFFF[#FF0033"..getACLFromPlayer(v).."#FFFFFF]", 255, 255, 255, true)

				end

			end

--[[			if isObjectInACLGroup ("user."..accName, aclGetGroup ( "SuperModerador" ) ) then

				if v:getData("Admin:Disponible") == false then

					source:outputChat("* Ningún Super Moderador en Ayuda..", 150, 50, 50, true)

				else

					source:outputChat("#42644C"..v:getName().." #FFFFFF[#ECEF3BSuper Moderador#FFFFFF]", 255, 255, 255, true)

				end

			end

			if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Moderador" ) ) then

				if v:getData("Admin:Disponible") == false then

					source:outputChat("* Ningún Super Moderador en Ayuda..", 150, 50, 50, true)

				else

					source:outputChat("#42644C"..v:getName().." #FFFFFF[#365DE1Moderador#FFFFFF]", 255, 255, 255, true)

				end

			end]]

		end

	end

end

addCommandHandler({"admins", "staffs"}, staffs_onServer)



local antiSpamPM  = {} 

local MP = {}

------------------------------------------------- PM

function mensaje(sourcePlayer, command, who, ...)

	if not notIsGuest( sourcePlayer ) then

		if tonumber(who) then

			local targetPlayer = getPlayerFromPartialNameID(who)

			if ( targetPlayer ) then 

				if targetPlayer ~= sourcePlayer then

					if MP[targetPlayer] == true then

						sourcePlayer:outputChat("* El jugador ".._getPlayerNameR(targetPlayer).." tiene desahabilitado los mensajes", 150, 50, 50, true)

					else

						local msg = table.concat({...}, " ")

						if msg ~= "" and msg ~= " " then

						local tick = getTickCount()

							if (antiSpamPM[sourcePlayer] and antiSpamPM[sourcePlayer][1] and tick - antiSpamPM[sourcePlayer][1] < 2000) then

								return

							end

							if MP[sourcePlayer] == true then

								sourcePlayer:outputChat("#FF0033[ADVERTENCIA] #FFFFFFTienes los mensajes desahabilitados, activalos para que te pueda responder.", 255, 255, 255, true)

							end

							sourcePlayer:outputChat("#FFFFFF[#6FB7FFMP#FFFFFF]#FFAD36".. removeColorCoding(_getPlayerNameR(sourcePlayer)).."#FFFFFF > ".. removeColorCoding(_getPlayerNameR(targetPlayer))..": ".. msg.."", 203, 129, 0, true)

							targetPlayer:outputChat("#FFFFFF[#6FB7FFMP#FFFFFF]#FFAD36".. removeColorCoding(_getPlayerNameR(sourcePlayer)).."#FFFFFF: ".. msg.."", 203, 129, 0, true)

							outputDebugString("".. _getPlayerNameR(sourcePlayer).." > ".. _getPlayerNameR(targetPlayer)..": ".. msg.."", 0, 111, 183, 255)

						end

						if (not antiSpamPM[sourcePlayer]) then

							antiSpamPM[sourcePlayer] = {}

						end

						antiSpamPM[sourcePlayer][1] = getTickCount()

					end

				end

			else

				sourcePlayer:outputChat("* [Nombre_Apellido o ID] [Mensaje] ", 150, 0, 0)

			end

		else

			local targetPlayer = getPlayerFromPartialName(who)

			if ( targetPlayer ) then 

				if targetPlayer ~= sourcePlayer then

					if MP[targetPlayer] == true then

						sourcePlayer:outputChat("* El jugador ".._getPlayerNameR(targetPlayer).." tiene desahabilitado los mensajes", 150, 50, 50, true)

					else

						local msg = table.concat({...}, " ")

						if msg ~= "" and msg ~= " " then

						local tick = getTickCount()

							if (antiSpamPM[sourcePlayer] and antiSpamPM[sourcePlayer][1] and tick - antiSpamPM[sourcePlayer][1] < 2000) then

								return

							end

							if MP[sourcePlayer] == true then

								sourcePlayer:outputChat("#FF0033[ADVERTENCIA] #FFFFFFTienes los mensajes desahabilitados, activalos para que te pueda responder.", 255, 255, 255, true)

							end

							sourcePlayer:outputChat("#FFFFFF[#6FB7FFMP#FFFFFF]#FFAD36".. removeColorCoding(_getPlayerNameR(sourcePlayer)).."#FFFFFF > ".. removeColorCoding(_getPlayerNameR(targetPlayer))..": ".. msg.."", 203, 129, 0, true)

							targetPlayer:outputChat("#FFFFFF[#6FB7FFMP#FFFFFF]#FFAD36".. removeColorCoding(_getPlayerNameR(sourcePlayer)).."#FFFFFF: ".. msg.."", 203, 129, 0, true)

							outputDebugString("".. _getPlayerNameR(sourcePlayer).." > ".. _getPlayerNameR(targetPlayer)..": ".. msg.."", 0, 111, 183, 255)

						end

						if (not antiSpamPM[sourcePlayer]) then

							antiSpamPM[sourcePlayer] = {}

						end

						antiSpamPM[sourcePlayer][1] = getTickCount()

					end

				end

			else

				sourcePlayer:outputChat("* [Nombre_Apellido o ID] [Mensaje] ", 150, 0, 0)

			end

		end

	end

end

addCommandHandler({"mp", "mensaje"}, mensaje)



addEventHandler("onPlayerQuit", getRootElement(), function()

	if MP[source] == true then

		MP[source] = nil

	end

end)



function no_mp( player )

	if not notIsGuest( player ) then

		if MP[player] == true then

			MP[player] = nil--

			player:outputChat("Los mensajes mediante MP han sido #00FF00Activados.", 255, 255, 255, true)

		else

			MP[player] = true

			player:outputChat("Los mensajes mediante MP han sido #FF0033Desactivados.", 255, 255, 255, true)

		end

	end

end

addCommandHandler("nomp", no_mp)



------------------------------------------------- Sistema de idiomas

local valoresIdioma = {}



local idiomas = {

["Español"] = "Español",

["Inglés"] = "Inglés",

["Latino"] = "Latino",

["Frances"] = "Frances",

["Alemán"] = "Alemán",

["Noruego"] = "Noruego",

}

local antiSpamIdioma = {}

addCommandHandler({"idioma", "lenguaje"}, function(p, cmd, ...)

	if not notIsGuest(p) then

		local id = table.concat({...}, " ")

		if id ~="" and id ~=" " then

			local tick = getTickCount()

			if (antiSpamIdioma[p] and antiSpamIdioma[p][1] and tick - antiSpamIdioma[p][1] < 30000) then

				return

				p:outputChat("Espera 30 segundos para cambiar el idioma", 150, 0, 0, true)

			end

			local s = trunklateText( p, id )

			if s:find(tostring(idiomas[s])) then

				p:outputChat("Acabas de cambiar el idioma a:#FF0033 "..s, 0, 150, 0, true)

				p:setData("Roleplay:Idioma", tostring(idiomas[s]))

			else

				p:outputChat("Solamente puedes poner estos idiomas: ", 150, 50, 50, true)

				for i, v in pairs(idiomas) do

					p:outputChat(idiomas[i], 20, 50, 20, true)

				end

			end

		else

			p:outputChat("Recuerda no poner idiomas que cause anti rol o serás sancionado.", 150, 0, 0, true)

		end

		if (not antiSpamIdioma[p]) then

			antiSpamIdioma[p] = {}

		end

		antiSpamIdioma[p][1] = getTickCount()

	end

end)



addEventHandler("onPlayerQuit", getRootElement(), function()

	if isPlayerExists(valoresIdioma, source) then

		for i, v in ipairs(valoresIdioma) do

			if AccountName(source) == v[1] then

				v[2] = source:getData("Roleplay:Idioma")

			end

		end

	else

		table.insert(valoresIdioma, { AccountName(source), source:getData("Roleplay:Idioma")})

	end

end)



addEventHandler("onPlayerLogin", getRootElement(), function()

	if isPlayerExists(valoresIdioma, source) then

		for i, v in ipairs(valoresIdioma) do 

			if AccountName(source) == v[1] then

				source:setData("Roleplay:Idioma", v[2])

			end

		end

	end

end)



------------------------------------------------- Ayudas

--[[function aiudaa(source,cmd,ayuda)

	if not notIsGuest( source ) then

		if ayuda == "comandos" then

			source:outputChat(" ",200,50,50)

			source:outputChat("/nomp /mp /duda /payuda /bug /bugeado",150,150,150)

			source:outputChat("/caminar /dardinero /pagar",150,150,150)

			source:outputChat("/idioma /guardaryo /limpiarchat /cc",150,150,150)

			source:outputChat("/mostrardni /mostrarplaca",150,150,150)

		elseif ayuda == "facciones" then

			source:outputChat(" ",200,50,50)

			source:outputChat("Facciones actuales:",180,180,180)

			source:outputChat("LSPD - LSRD - LSFD - Mecanico - Gobierno",180,180,180)

			source:outputChat("/contratar /aceptarcontrato /despedir",150,150,150)

		elseif ayuda == "casas" then

			source:outputChat(" ",200,50,50)

			source:outputChat("Las casas las podes encontrar en cualquier parte del mapa",200,200,200)

			source:outputChat("Apreta la letra i para revelar los iconos",200,200,200)

		elseif ayuda == "vehiculos" then

			source:outputChat(" ",200,50,50)

			source:outputChat("/abrirveh /cerrarveh /localizarveh /venderveh",200,200,200)

			source:outputChat("/maletero /llaveveh",190,190,190)

		else

			source:outputChat(" ",200,50,50)

			source:outputChat("Syntax: /ayuda < >",200,50,50)

			source:outputChat("/ayuda comandos - /ayuda facciones",200,50,50)

			source:outputChat("/ayuda casas - /ayuda vehiculos",200,50,50)

		end

	end

end

addCommandHandler("ayuda",aiudaa)

]]

------------------------------------------------- Sistema de dudas

local antiSpamDuda  = {}

local responderDuda = {}

local adminDuda = {}



function dude_command( thePlayer, commandName, ... )

	if not notIsGuest( thePlayer ) then

		local msg = table.concat({...}, " ")

		if msg ~= "" and msg ~= " " then

			local tick = getTickCount()

			if (antiSpamDuda[thePlayer] and antiSpamDuda[thePlayer][1] and tick - antiSpamDuda[thePlayer][1] < 30000) then

				return

				thePlayer:outputChat("Espera 30 segundos para enviar una duda", 150, 0, 0, true)

			end

			thePlayer:outputChat("#FC921A¡#FFFFFFAcabas de enviar tu Duda#FC921A!", 255, 255, 255, true)

			thePlayer:outputChat("#FC921A[Duda]#FFFFFF: "..msg, 255, 255, 255, true)

			-- admins

			message_admins_duda(thePlayer, msg)

		end

		if (not antiSpamDuda[thePlayer]) then

			antiSpamDuda[thePlayer] = {}

		end

		antiSpamDuda[thePlayer][1] = getTickCount()

	end

end

addCommandHandler({"duda"}, dude_command)



function message_admins_duda(player, msg)

	if isElement(player) then

		for i, v in ipairs(getElementsByType("player")) do

			local accName = getAccountName ( getPlayerAccount ( v ) )

			if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "SuperModerador" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Moderador" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Ayudante" ) ) then

				v:outputChat("#FC921AEl Jugador: #00FF00*["..player:getData("ID").."]".. removeColorCoding(_getPlayerNameR(player)).." #FC921Aacaba de enviar su duda", 255, 255, 255, true)

				v:outputChat("#FC921A[Duda del Jugador]#FFFFFF"..msg, 255, 255, 255, true)

				v:outputChat("¡Usa /responderduda [Nombre_Apellido o ID]", 255, 255, 255, true)

				responderDuda[v] = true

				adminDuda[v] = _getPlayerNameR(player)

			end

		end

	end

	return false

end



function responder_duda( player, cmd, p )

	local accName = getAccountName ( getPlayerAccount ( player ) )

	if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "SuperModerador" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Moderador" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Ayudante" ) ) then

		if responderDuda[player] == true then

			if tonumber(p) then

				local jugador = getPlayerFromPartialNameID(p)

				if (jugador) then

					jugador:outputChat("¡El ("..getACLFromPlayer(player)..") ".._getPlayerNameR(player).." ah respondido tu duda!", 255, 255, 255, true)

					message_admins("¡El ("..getACLFromPlayer(player)..") ".._getPlayerNameR(player).." ah respondido la duda del jugador: "..adminDuda[player].."!", 50, 150, 50, true)

				end

			else

				local jugador = getPlayerFromPartialName(p)

				if (jugador) then

					jugador:outputChat("¡El ("..getACLFromPlayer(player)..") ".._getPlayerNameR(player).." ah respondido tu duda!", 255, 255, 255, true)

					message_admins("¡El ("..getACLFromPlayer(player)..") ".._getPlayerNameR(player).." ah respondido la duda del jugador: "..adminDuda[player].."!", 50, 150, 50, true)

				end

			end

			adminDuda[player] = nil

			responderDuda[player] = nil

		end

	end

end

addCommandHandler({"responderduda", "rduda"}, responder_duda)



function message_admins(msg, r, g, b, val)

	for i, v in ipairs(getElementsByType("player")) do

		local accName = getAccountName ( getPlayerAccount ( v ) )

		if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "SuperModerador" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Moderador" ) ) then

			v:outputChat(msg, r, g, b, val)

		end

	end

	return false

end