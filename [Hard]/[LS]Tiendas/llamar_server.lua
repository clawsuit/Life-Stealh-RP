--[[

--------[COMANDOS para la gente fuera de la faccion---------



/llamar 911  [Cuando llamen al 911 les saldra esto "911 ¿Cuál es su emergencia" y ellos tienen que responder no se algo "Me robaron el carro" y le sale lo siguiente "Muy bien, espere a que la unidad policial llegue a su ubicacion, mantenga la calma" y a los policia les saldra lo siguiente:

Se ah recibido una llamada del número ..numero.

Usa /llamado [ID DE LA PERSONA QUE LLAMÓ] para acudir al llamado]

(Ya cuando usen el comando dicho les saldrá así)

Llamado [ID] : ..texto escrito por el que llamo



--

* A nombre le estan llamando (( nombre ))

]]



local EnLlamada = {}

local EnLlamadaEmergencia = {}

local ResponderLlamada = {}

local ApagarCelular = {}

local JugadorLlamada = {}

local TimerLlamada = {}

local MensajeEmergencia = {}

local blipsCentral = {}

addCommandHandler("llamar", function(player, cmd, number)

	if not notIsGuest( player ) then

		if player:getData("Roleplay:Telefono") ~="No" then

			if EnLlamada[player] == true or ApagarCelular[player] == true then

				player:outputChat("* En este momento te encuentras en una llamada o tienes el celular apagado.", 150, 50, 50, true)

			else

				if tonumber(number) then

					if tonumber(number) == 911 or tonumber(number) == 512 then

						player:outputChat("Operadora: ¿Cual es su emergencia?", 85, 50, 108, true)

						player:outputChat("usa /ll para responder la llamada", 50, 150, 50, true)

						ResponderLlamada[player] = true;

						EnLlamadaEmergencia[player] = tonumber(number);

						EnLlamada[player] = true;

					else

						if tostring(player:getData("Roleplay:NumeroTelefono")) ~= tostring(number) then

							if string.len(number) >= 2 then

								local thePlayer = getPlayerNumberCall(number)

								if (thePlayer) then

									if ApagarCelular[thePlayer] == true then

										player:outputChat("#FFFF00"..thePlayer:getData("Roleplay:NumeroTelefono").." tiene el celular apagado", 150, 50, 50, true)

										thePlayer:outputChat("Tienes una llamada perdida del número: "..player:getData("Roleplay:NumeroTelefono").."", 32, 100, 32)

									else

										if EnLlamada[thePlayer] == true then

											player:outputChat("#FFFF00"..thePlayer:getData("Roleplay:NumeroTelefono").." #FFFFFFse encuentra en una llamada", 255, 255, 255, true)

										else

											EnLlamada[player] = true

											ResponderLlamada[thePlayer] = true

											JugadorLlamada[thePlayer] = player:getName()

											--

											thePlayer:outputChat("Te esta llamando el número: "..player:getData("Roleplay:NumeroTelefono").."", 50, 150, 50, true)

											thePlayer:outputChat("/contestar", 150, 150, 0)

											thePlayer:outputChat("/colgar", 150, 50, 50)

											--

											player:triggerEvent("SoundsPhone", player, "LlamarSound")

											--

											local x, y, z = getElementPosition( player )

											local chatCol = ColShape.Sphere(x, y, z, 10)

											local nearPlayers = chatCol:getElementsWithin("player")

											for index, v in ipairs(nearPlayers) do

												v:outputChat("* A ".._getPlayerNameR(thePlayer).." le estan llamando (( ".._getPlayerNameR(thePlayer).." ))", 32, 100, 32, true)

												v:triggerEvent("SoundsPhone", getRootElement(  ), "LlamadaSound", thePlayer)

											end

											if isElement(chatCol) then

												chatCol:destroy()

											end

											--

											TimerLlamada[player] = setTimer(function(p, t, n)

												p:outputChat("El número: "..thePlayer:getData("Roleplay:NumeroTelefono").." no ha contestado.", 150, 50, 50)

												t:outputChat("Tienes una llamada perdida del número: "..player:getData("Roleplay:NumeroTelefono").."", 32, 100, 32)

												ResponderLlamada[t] = nil

												EnLlamada[p] = nil

												JugadorLlamada[t] = nil

												player:triggerEvent("SoundsPhone", player, "stopLlamada")

												for index, v in ipairs(nearPlayers) do

													v:triggerEvent("SoundsPhone", getRootElement(  ), "stopLlamado", thePlayer)

												end

											end, 20000, 1, player, thePlayer)

										end

									end

								else

									player:outputChat("El número que usted ha marcado no existe.", 150, 50, 50,true)

								end

							end

						end

					end

				end

			end

		else

			player:outputChat("No tienes un telefono para llamar", 150, 50, 50, true)

		end

	end

end)



function ApagarTelefono(player)

	if not notIsGuest( player ) then

		if ResponderLlamada[player] == nil or ResponderLlamada[player] == false then

			if ApagarCelular[player] == true then

				player:outputChat("Ya tienes el celular apagado.", 150, 50, 50, true)

			else

				ApagarCelular[player] = true

				MensajeRol(player, "apago su telefono.")

			end

		else

			player:outputChat("Tienes una llamada en este momento usa colgar para después apagar el celular", 150, 50, 50)

		end

	end

end

addCommandHandler("apagarcelular", ApagarTelefono)



function EncenderTelefono(player)

	if not notIsGuest( player ) then

		if ApagarCelular[player] == true then

			ApagarCelular[player] = nil

			MensajeRol(player, "encendio su telefono.")

		else

			player:outputChat("Ya tienes el celular encendido.", 150, 50, 50, true)

		end

	end

end

addCommandHandler("encendercelular", EncenderTelefono)



local MandarMensajesEnLLamada = {}



function colgarLlamada(player)

	if not notIsGuest( player ) then

		if ResponderLlamada[player] == true then

			local thePlayer = getPlayerFromPartialName(JugadorLlamada[player])

			if (thePlayer) then

				player:outputChat("Colgaste al número: "..thePlayer:getData("Roleplay:NumeroTelefono"), 150, 50, 50)

				thePlayer:outputChat("El número: "..player:getData("Roleplay:NumeroTelefono").." te ha colgado.", 150, 50, 50)

				--

				thePlayer:triggerEvent("SoundsPhone", thePlayer, "stopLlamada")

				--

				if isTimer(TimerLlamada[thePlayer]) then

					killTimer(TimerLlamada[thePlayer])

				end

				--

				TimerLlamada[thePlayer] = nil

				EnLlamada[thePlayer] = nil

				ResponderLlamada[thePlayer] = nil

				JugadorLlamada[thePlayer] = nil

				JugadorLlamada[player] = nil

				ResponderLlamada[player] = nil

				EnLlamada[player] = nil

				local x, y, z = getElementPosition( player )

				local chatCol = ColShape.Sphere(x, y, z, 10)

				local nearPlayers = chatCol:getElementsWithin("player")

				for index, v in ipairs(nearPlayers) do

					v:triggerEvent("SoundsPhone", getRootElement(  ), "stopLlamado", player)

				end

				if isElement(chatCol) then

					chatCol:destroy()

				end

			end

		end

	end

end

addCommandHandler("colgar", colgarLlamada)



function contestarLlamada(player)

	if not notIsGuest( player ) then

		if ResponderLlamada[player] == true then

			local thePlayer = getPlayerFromPartialName(JugadorLlamada[player])

			if (thePlayer) then

				player:outputChat("Acabas de contestar al número: "..thePlayer:getData("Roleplay:NumeroTelefono"), 50, 150, 50)

				thePlayer:outputChat("El número: "..player:getData("Roleplay:NumeroTelefono").." te ha contestado.", 50, 150, 50)

				--

				player:outputChat("usa /ll -mensaje--", 50, 150, 50)

				--

				thePlayer:triggerEvent("SoundsPhone", thePlayer, "stopLlamada")

				--

				if isTimer(TimerLlamada[thePlayer]) then

					killTimer(TimerLlamada[thePlayer])

				end

				--

				TimerLlamada[thePlayer] = nil

				EnLlamada[player] = true

				EnLlamada[thePlayer] = true

				ResponderLlamada[player] = true

				ResponderLlamada[thePlayer] = true

				MandarMensajesEnLLamada[thePlayer] = true

				MandarMensajesEnLLamada[player] = true

				JugadorLlamada[player] = thePlayer:getName()

				JugadorLlamada[thePlayer] = player:getName()

				local x, y, z = getElementPosition( player )

				local chatCol = ColShape.Sphere(x, y, z, 10)

				local nearPlayers = chatCol:getElementsWithin("player")

				for index, v in ipairs(nearPlayers) do

					v:triggerEvent("SoundsPhone", getRootElement(  ), "stopLlamado", player)

				end

				if isElement(chatCol) then

					chatCol:destroy()

				end

			end

		end

	end

end

addCommandHandler("contestar", contestarLlamada)



addCommandHandler("ll", function(player, cmd, ...)

	if not notIsGuest( player ) then

		if EnLlamada[player] == true and ResponderLlamada[player] == true then

			local msg = table.concat({...}, " ")

			local xd = trunklateText( player, msg )

			if msg ~="" and msg ~=" " then

				if EnLlamadaEmergencia[player] then

					outputDebugString("[LLAMADA] ".. player:getName().." > Operadora: "..xd.." ", 0, 150, 0, 100)

					player:outputChat("* "..player:getName().." > Operadora: #FFFFFF"..msg, 0, 150, 0, true)

					local zona = getZoneName( player.position )
					MensajeEmergencia[tonumber(player:getData("Roleplay:NumeroTelefono"))] = {'#FFFFFF[#FF0000Llamado '..player:getData("Roleplay:NumeroTelefono")..'#FFFFFF] | #F3FF00Ubicación#FFFFFF: '..zona..' | #F3FF00Razón#FFFFFF: '..msg, player, true}

					setTimer(function(p)

						p:outputChat("Muy bien, espere a que la unidad policial llegue a su ubicacion, mantenga la calma", 0, 150, 0, true)

					

						for i, v in ipairs(Element.getAllByType("player")) do

							if EnLlamadaEmergencia[player] == 911 and v:getData("Roleplay:faccion") == "Policia" then

								v:outputChat("#FFFFFF[#FF0000Central#FFFFFF] Se ah recibido una llamada. #FFFFFFUsa #FFF700/central "..player:getData("Roleplay:NumeroTelefono").." #FFFFFFpara acudir al llamado.", 50, 150, 50, true)

							elseif EnLlamadaEmergencia[player] == 512 and v:getData("Roleplay:faccion") == "Medico" then

								v:outputChat("#FFFFFF[#FF0000Central#FFFFFF] Se ah recibido una llamada. #FFFFFFUsa #FFF700/central "..player:getData("Roleplay:NumeroTelefono").." #FFFFFFpara acudir al llamado.", 50, 150, 50, true)

							end

						end

					end, 1000, 1, player)

					setTimer(function(p)

						p:outputChat("* El número: Operadora te colgo", 150, 50, 50, true)

						EnLlamadaEmergencia[p] = nil

						ResponderLlamada[p] = nil

						EnLlamada[p] = nil

					end, 3000, 1, player)

				else

					if EnLlamada[player] == true and MandarMensajesEnLLamada[player] == true then

						player:setData("TextInfo", {"> habla por telefono", 255, 0, 216})

						setTimer(function(p)

							p:setData("TextInfo", {"", 255, 0, 216})

						end, 2000, 1, player)

						local thePlayer = getPlayerFromPartialName(JugadorLlamada[player])

						if (thePlayer) then

							outputDebugString("[LLAMADA] ".._getPlayerNameR(player).." > ".._getPlayerNameR(thePlayer)..": "..xd.." ", 0, 150, 0, 100)

							player:outputChat("".._getPlayerNameR(player).." > "..thePlayer:getData("Roleplay:NumeroTelefono")..": #FFFFFF"..xd, 150, 0, 100, true)

							thePlayer:outputChat(""..player:getData("Roleplay:NumeroTelefono")..": #FFFFFF"..xd, 150, 0, 100, true)

						end

					end

				end

			end

		end

	end

end)


addCommandHandler("central", 
	function(player, _, ...)

		if not notIsGuest( player ) then

			if player:getData("Roleplay:faccion") == "Policia" or player:getData("Roleplay:faccion") == "Medico" then
				local num = tonumber(...)

				if num then
					if MensajeEmergencia[num] then

						player:outputChat(tostring(MensajeEmergencia[num][1]), 255, 255, 0, true)

						blipsCentral[player] = blipsCentral[player] or {}
						local who = MensajeEmergencia[num][2]

						if isElement(who) then

							local pos = who.position
							
							if isElement( blipsCentral[player][who] ) then
								blipsCentral[player][who]:destroy()
							end
					
							blipsCentral[player][who] = Blip(pos,0,2, 255,255,0,255,0,65535,player)
							exports['[LS]Notificaciones']:setTextNoti(player, 'Se a marcado la zona con un punto en tu mapa con un cuadro/triangulo #ffff00Amarillo', 255, 255, 255, true)

						end

					end

				end

			end

		end

	end
)

addEventHandler( "onPlayerCommand", getRootElement(), 
	function(c)

		if c == 'limpref' then
			if source:getData("Roleplay:faccion") == "Policia" or source:getData("Roleplay:faccion") == "Medico" then

				if blipsCentral[source] then

					for k,v in pairs(blipsCentral[source]) do
						v:destroy()
						blipsCentral[source][k] = nil
					end

				end
				
			end

		end

	end
)

addEventHandler("onPlayerQuit", getRootElement(), function()

	if ResponderLlamada[source] == true then

		local thePlayer = getPlayerFromPartialName(JugadorLlamada[source])

		if (thePlayer) then

			source:outputChat("Colgaste al número: "..thePlayer:getData("Roleplay:NumeroTelefono"), 150, 50, 50)

			thePlayer:outputChat("El número: "..source:getData("Roleplay:NumeroTelefono").." te ha colgado.", 150, 50, 50)

			--

			thePlayer:triggerEvent("SoundsPhone", thePlayer, "stopLlamada")

			--

			if isTimer(TimerLlamada[thePlayer]) then

				killTimer(TimerLlamada[thePlayer])

			end

			--

			TimerLlamada[thePlayer] = nil

			EnLlamada[thePlayer] = nil

			ResponderLlamada[thePlayer] = nil

			JugadorLlamada[thePlayer] = nil

			JugadorLlamada[source] = nil

			ResponderLlamada[source] = nil

			EnLlamada[source] = nil

			local x, y, z = getElementPosition( source )

			local chatCol = ColShape.Sphere(x, y, z, 10)

			local nearPlayers = chatCol:getElementsWithin("player")

			for index, v in ipairs(nearPlayers) do

				v:triggerEvent("SoundsPhone", getRootElement(  ), "stopLlamado", source)

			end

			if isElement(chatCol) then

				chatCol:destroy()

			end

		end

	end

	if EnLlamada[source] == true then

		EnLlamada[source] = nil

	end

	if ResponderLlamada[source] == true then

		ResponderLlamada[source] = nil

	end

	if EnLlamadaEmergencia[source] then

		EnLlamadaEmergencia[source] = nil

	end

	if MandarMensajesEnLLamada[source] == true then

		MandarMensajesEnLLamada[source] = nil

	end

	if JugadorLlamada[source] then

		JugadorLlamada[source] = nil

	end

end)



function trunklateText(thePlayer, text, factor)

    local msg = (tostring(text):gsub("%u", string.lower))

	return (tostring(msg):gsub("^%l", string.upper))

end



function getPlayerNumberCall(number)

    local number = number and tonumber(number) or nil

    if number then

        for _, player in ipairs(Element.getAllByType("player")) do

            local number_ = player:getData("Roleplay:NumeroTelefono")

            if tostring(number_):find(number, 1, true) then

				return player

            end

        end

    end

end