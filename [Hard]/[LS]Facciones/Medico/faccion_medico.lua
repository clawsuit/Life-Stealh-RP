local pickEmerg = Pickup(2042.1405029297, -1423.4041748047, 17.1640625, 3, 1240, 0)

local pickMarker = Marker(2042.1405029297, -1423.4041748047, 17.1640625-1, "cylinder", 1.3, 100, 100, 100, 0)



addCommandHandler("emergencia", function(player)

	if not notIsGuest(player) then

		if player:isWithinMarker(pickMarker) then

			if player:getMoney() >= 100 then

				if player:getHealth() <= 60 then

					player:outputChat("¡Has sido totalmente curado!", 50, 150, 50, true)

					player:setHealth(200)

					player:takeMoney(100)

				else

					exports['[LS]Notificaciones']:setTextNoti(player, "Debes tener menos de 60% de vida", 150, 50, 50)

				end

			else

				exports['[LS]Notificaciones']:setTextNoti(player, "No tienes suficiente dinero", 150, 50, 50)

			end

		end

	end

end)



addCommandHandler("lidermedico", function(player, cmd, who)

	if not notIsGuest( player ) then

		if permisos[getACLFromPlayer(player)] == true then

			if tonumber(who) then

				local thePlayer = getPlayerFromPartialNameID(who)

				if (thePlayer) then

					if thePlayer:getData("Roleplay:faccion") ~="" then

						player:outputChat(_getPlayerNameR(thePlayer).." se encuentra en una facción debe dejar su facción para que le puedas dar el lider de medico.", 150, 50, 50, true)

					else

						local s = query("SELECT * From `Facciones` where Faccion = ? and Lider=?", 'Medico', 'Si')

						if ( type( s ) == "table" and #s == 0 ) or not s then

							player:outputChat("* Le acabas de entregar el lider a #FFFFFF".._getPlayerNameR(thePlayer).."", 50, 100, 50, true)

							--

							thePlayer:outputChat("* Acabas de ser entregado el Lider de la facción de Medico", 50, 150, 50, true)

							--

							insert("insert into `Facciones` VALUES (?,?,?,?,?,?,?)", 'Medico', AccountName(thePlayer), 'Director', '0', 'Si', '', 'No')

							--

							thePlayer:setData("Roleplay:faccion", "Medico")

							thePlayer:setData("Roleplay:faccion_lider", "Si")

							thePlayer:setData("Roleplay:faccion_rango", "Director")

							thePlayer:setData("Roleplay:faccion_sueldo", 0)

							thePlayer:setData("Roleplay:faccion_division", "")

							thePlayer:setData("Roleplay:faccion_division_lider", "No")

						else

							player:outputChat("* Ya se encuentra un lider en mando: #FF0033"..s[1]["Nombre"], 115, 115, 115, true)

						end

					end

				else

					player:outputChat("Syntax: /lidermedico [ID]", 255, 255, 255, true)

				end

			else

				local thePlayer = getPlayerFromPartialName(who)

				if (thePlayer) then

					if thePlayer:getData("Roleplay:faccion") ~="" then

						player:outputChat(_getPlayerNameR(thePlayer).." se encuentra en una facción debe dejar su facción para que le puedas dar el lider de medico.", 150, 50, 50, true)

					else

						local s = query("SELECT * From `Facciones` where Faccion = ? and Lider=?", 'Medico', 'Si')

						if ( type( s ) == "table" and #s == 0 ) or not s then

							player:outputChat("* Le acabas de entregar el lider a #FFFFFF".._getPlayerNameR(thePlayer).."", 50, 100, 50, true)

							--

							thePlayer:outputChat("* Acabas de ser entregado el Lider de la facción de Medico", 50, 150, 50, true)

							--

							insert("insert into `Facciones` VALUES (?,?,?,?,?,?,?)", 'Medico', AccountName(thePlayer), 'Director', '0', 'Si', '', 'No')

							--

							thePlayer:setData("Roleplay:faccion", "Medico")

							thePlayer:setData("Roleplay:faccion_lider", "Si")

							thePlayer:setData("Roleplay:faccion_rango", "Director")

							thePlayer:setData("Roleplay:faccion_sueldo", 0)

							thePlayer:setData("Roleplay:faccion_division", "")

							thePlayer:setData("Roleplay:faccion_division_lider", "No")

						else

							player:outputChat("* Ya se encuentra un lider en mando: #FF0033"..s[1]["Nombre"], 115, 115, 115, true)

						end

					end

				else

					player:outputChat("Syntax: /lidermedico [ID]", 255, 255, 255, true)

				end

			end

		end

	end

end)



--- Spawn

local JugadorMuerto = {}

local ValoresTablaAsesinato = {}

local antiSpamMensajes = {}



cuerpos = {

[3]="Torso", 

[4]="Culo", 

[5]="Brazo izquierdo", 

[6]="Brazo derecho", 

[7]="Pierna izquierda", 

[8]="Pierna derecha", 

[9]="Cabeza", 

}



function PlayerDamageText( attacker, weapon, bodypart, loss )

	if ( attacker and attacker:getType() == "player" and bodypart ) then

		if ( source and source:getType() == "player" ) then

			if not source:isDead() then

				local tick = getTickCount()

				if (antiSpamMensajes[source] and antiSpamMensajes[source][1] and tick - antiSpamMensajes[source][1] < 1000) then

					return

				end

				source:outputChat(_getPlayerNameR(attacker).." te acaba de atacar.", 150, 50, 50, true)

				if (not antiSpamMensajes[source]) then

					antiSpamMensajes[source] = {}

				end

				antiSpamMensajes[source][1] = getTickCount()

			end

		end

	end

end

addEventHandler("onPlayerDamage", getRootElement(), PlayerDamageText)



function PlayerKilled( ammo, attacker, weapon, bodypart )

	if ( attacker and attacker:getType() == "player" and bodypart ) then

		if ( source and source:getType() == "player" ) then

			source:outputChat("#FF0033[ADVERTENCIA] #FFFF00Si reconnectas en pleno asesinato de tu personaje, serás sancionado.", 150, 50, 50, true)

			source:outputChat("#FFFFFF".._getPlayerNameR(attacker).." #963200te acaba de dejar inconsciente.", 255, 255, 255, true)

			JugadorMuerto[source] = false

			setTimer(function(source, weapon, bodypart, attacker)

				if isElement(source) or isElement(attacker) then

				local pos = Vector3(source:getPosition())

				local x, y, z = pos.x, pos.y, pos.z

				local pos2 = Vector3(source:getRotation())

				local rx, ry, rz = pos2.x, pos2.y, pos2.z

				local int = source:getInterior()

				local dim = source:getDimension()

				source:spawn(x, y, z, rz, source:getModel(), int, dim, nil)

				source:setFrozen(true)

				source:setData("NoDamageKill", true)

				setPedAnimation(source, "crack", "crckidle4", -1,true, false, false)

				source:setHealth(1)

				JugadorMuerto[source] = true

				setControlState( source, "fire", false )

				source:removeFromVehicle(source:getOccupiedVehicle())

				source:outputChat("#FFFFFFPuedes avisar de tu muerte con el comando #00FF00/avisarmuerte", 255, 255, 255, true)

				source:outputChat("#FFFFFFO puedes aceptar tu destino utilizando el comando #963200/aceptarmuerte", 255, 255, 255, true)

				source:setData("yo", {"Inconsciente | Herido por "..getWeaponNameFromID ( weapon ).." en "..cuerpos[bodypart].."", 150, 50, 0})

				ValoresTablaAsesinato[source] = attacker

			end

			end, 3000, 1, source, weapon, bodypart, attacker)

		end

	else

		source:outputChat("#FF0033[ADVERTENCIA] #FFFF00Si reconnectas en pleno asesinato de tu personaje, serás sancionado.", 150, 50, 50, true)

		JugadorMuerto[source] = false

		setTimer(function(source, weapon, bodypart)

			if isElement(source) then

			local pos = Vector3(source:getPosition())

			local x, y, z = pos.x, pos.y, pos.z

			local pos2 = Vector3(source:getRotation())

			local rx, ry, rz = pos2.x, pos2.y, pos2.z

			local int = source:getInterior()

			local dim = source:getDimension()

			source:spawn(x, y, z, rz, source:getModel(), int, dim, nil)

			source:setFrozen(true)

			setPedAnimation(source, "crack", "crckidle4", -1,true, false, false)

			source:setHealth(1)

			setControlState( source, "fire", false )

			source:setData("NoDamageKill", true)

			JugadorMuerto[source] = true

			source:removeFromVehicle(source:getOccupiedVehicle())

			source:outputChat("#FFFFFFPuedes avisar de tu muerte con el comando #00FF00/avisarmuerte", 255, 255, 255, true)

			source:outputChat("#FFFFFFO puedes aceptar tu destino utilizando el comando #963200/aceptarmuerte", 255, 255, 255, true)

			source:setData("yo", {"Inconsciente | Herido por caida", 150, 50, 0})

			ValoresTablaAsesinato[source] = source

		end

		end, 3000, 1, source, weapon, bodypart)

	end

end

addEventHandler("onPlayerWasted", getRootElement(), PlayerKilled)

--ver asesino 

function VerAsesino(player, cmd, who)

	if not notIsGuest( player ) then

		if permisosTotal[getACLFromPlayer(player)] == true then

			if tonumber(who) then

				local thePlayer = getPlayerFromPartialNameID(who)

				if (thePlayer) then

					if ValoresTablaAsesinato[thePlayer] then

						player:outputChat("* El asesino de ".._getPlayerNameR(thePlayer).." es: #FF0033".._getPlayerNameR(ValoresTablaAsesinato[thePlayer]), 255, 255, 255, true)

					end

				else

					player:outputChat("Syntax: /asesino [ID]", 255, 255, 255, true)

				end

			else

				local thePlayer = getPlayerFromPartialNameID(who)

				if (thePlayer) then

					if ValoresTablaAsesinato[thePlayer] then

						player:outputChat("* El asesino de ".._getPlayerNameR(thePlayer).." es: #FF0033".._getPlayerNameR(ValoresTablaAsesinato[thePlayer]), 255, 255, 255, true)

					end

				else

					player:outputChat("Syntax: /asesino [Nombre]", 255, 255, 255, true)

				end

			end

		end

	end

end

addCommandHandler("asesino", VerAsesino)

--

function aceptarMuerte(player)

	if not notIsGuest(player) then

		if JugadorMuerto[player] == true then

			player:outputChat("En 10 segundos, serás spawneado al hospital.", 150, 50, 50, true)

			--

			JugadorMuerto[player] = nil

			setTimer(function(source)

				if isElement(source) then

				setControlState( source, "fire", true )

				source:spawn(2032.90234375, -1417.4990234375, 16.9921875, 119.14031982422, source:getModel(), 0, 0, nil)

				source:setData("yo", {"", 150, 0, 0})

				source:setHealth(100)

				source:setFrozen(false)

				source:setData("NoDamageKill", nil)

				setPedAnimation(source)

			end

			end, 10000, 1, player)

		end

	end

end



addCommandHandler("aceptarmuerte", aceptarMuerte)

local aviso = {
	AntiSpamM = {},
	blips = {},
}


--avisar_muerte

function avisar_muerte(jug)
	if not notIsGuest(jug) then

		if JugadorMuerto[jug] == true then

			if aviso.AntiSpamM[jug] and getTickCount(  ) - aviso.AntiSpamM[jug] < 2000 then

				return exports['[LS]Notificaciones']:setTextNoti(jug, 'Ya haz enviando un aviso, ¡espera unos segundo!', 255, 255, 0)

			end
			for i,who in ipairs(Element.getAllByType('player')) do
				
				if getPlayerFaction( who, "Medico" ) then

					who:outputChat('Se ha recibido un reporte de una persona herida. ((/muerto '..jug:getData('ID')..'))',255,255,0,true)
				end

			end

			jug:outputChat('Haz avisado a todas las unidades de tu ubicacion',255,255,0,true)

			aviso.AntiSpamM[jug] = getTickCount(  )

		end

	end

end
addCommandHandler("avisarmuerte", avisar_muerte)


addCommandHandler("muerte",
	function(jug, cmd, who)
		if not notIsGuest(jug) then

			if getPlayerFaction( jug, "Medico" ) then

				if tonumber(who) then
					local player = getPlayerFromPartialNameID(who)
					
					if player and JugadorMuerto[player] == true then

						local pos = player.position
						aviso.blips[jug] = aviso.blips[jug] or {}

						if isElement( aviso.blips[jug][player] ) then
							aviso.blips[jug][player]:destroy()
						end

						aviso.blips[jug][player] = Blip(pos,0,2, 255,255,0,255,0,65535,jug)		--exports['[LS]NuevosBlips']:createNewBlip(pos.x,pos.y, pos.z, 'dead', 0, 0, 1, 255, 255, 255, 65535, player)

						exports['[LS]Notificaciones']:setTextNoti(jug, 'Se a marcado la zona con un punto en tu mapa con un cuadro/triangulo #ffff00Amarillo', 255, 255, 255, true)
					end

				end

			end

		end

	end
)

addEventHandler( "onPlayerCommand", getRootElement(), 
	function(c)

		if c == 'limpref' then
			if getPlayerFaction( source, "Medico" ) then

				if aviso.blips[source] then

					for k,v in pairs(aviso.blips[source]) do
						v:destroy()
						aviso.blips[source][k] = nil
					end

				end
				
			end

		end

	end
)
-- curar jugadores

function curar_medico( source, cmd, jugador )

	if not notIsGuest( source ) then

		if getPlayerFaction( source, "Medico" ) or permisosTotal[getACLFromPlayer(source)] == true then

			if tonumber(jugador) then

				local player = getPlayerFromPartialNameID(jugador)

				if ( player ) then

					if ( not JugadorMuerto[player] == true) then

						setPedAnimation(source)

						player:setHealth(player:getHealth()+20)

						player:setFrozen(false)

						MensajeRoleplay(source, "le ah dado una inyección a ".._getPlayerNameR(player))

					else

						source:outputChat("* El jugador: ".._getPlayerNameR(player).." esta muerto, usa el comando /reanimar [Nombre_Apellido o ID].", 150, 0, 0)

					end

				else

					source:outputChat("Syntax: /curar [ID]", 255, 255, 255, true)

				end

			else

				local player = getPlayerFromPartialName(jugador)

				if ( player ) then

					if ( not JugadorMuerto[player] == true) then

						setPedAnimation(source)

						player:setHealth(player:getHealth()+20)

						player:setFrozen(false)

						MensajeRoleplay(source, "le ah dado una inyección a ".._getPlayerNameR(player))


					else

						source:outputChat("* El jugador: ".._getPlayerNameR(player).." esta muerto, usa el comando /reanimar [Nombre_Apellido o ID].", 150, 0, 0)

					end

				else

					source:outputChat("Syntax: /curar [Nombre]", 255, 255, 255, true)

				end

			end

 		else

			source:outputChat("* No puedes usar este comando", 150, 50, 50)

		end

	end

end

addCommandHandler("curar", curar_medico)



-- revivir para administradores

function revivirJugador(player, cmd, who)

	if not notIsGuest( player ) then

		if permisosTotal[getACLFromPlayer(player)] == true then

			if tonumber(who) then

				local thePlayer = getPlayerFromPartialNameID(who)

				if (thePlayer) then

					if JugadorMuerto[thePlayer] == true then

						local pos = Vector3(thePlayer:getPosition())

						local x, y, z = pos.x, pos.y, pos.z

						local pos2 = Vector3(thePlayer:getRotation())

						local rx, ry, rz = pos2.x, pos2.y, pos2.z

						local int = thePlayer:getInterior()

						local dim = thePlayer:getDimension()

						JugadorMuerto[thePlayer] = nil

						thePlayer:spawn(x, y, z, rz, thePlayer:getModel(), int, dim, nil)

						thePlayer:setFrozen(false)

						thePlayer:setData("NoDamageKill", nil)

						setPedAnimation(thePlayer)

						setControlState( thePlayer, "fire", true )

						thePlayer:setHealth(100)

						thePlayer:removeFromVehicle(thePlayer:getOccupiedVehicle())

						thePlayer:setData("yo", {"", 150, 0, 0})

						outputDebugString("* ".._getPlayerNameR(player).." revivio al jugador: ".._getPlayerNameR(thePlayer).."", 0, 0, 150, 0)

						player:outputChat("* Acabas de revivir al jugador: ".._getPlayerNameR(thePlayer)..".", 50, 150, 0)

						thePlayer:outputChat("* ".._getPlayerNameR(player).." te acaba de revivir.", 50, 150, 0)

					else

						player:outputChat("* El jugador: ".._getPlayerNameR(thePlayer).." no esta muerto.", 150, 0, 0)

					end

				else

					player:outputChat("Syntax: /revivir [ID]", 255, 255, 255, true)

				end

			else

				local thePlayer = getPlayerFromPartialName(who)

				if (thePlayer) then

					if JugadorMuerto[thePlayer] == true then

						local pos = Vector3(thePlayer:getPosition())

						local x, y, z = pos.x, pos.y, pos.z

						local pos2 = Vector3(thePlayer:getRotation())

						local rx, ry, rz = pos2.x, pos2.y, pos2.z

						local int = thePlayer:getInterior()

						local dim = thePlayer:getDimension()

						JugadorMuerto[thePlayer] = nil

						thePlayer:spawn(x, y, z, rz, thePlayer:getModel(), int, dim, nil)

						thePlayer:setFrozen(false)

						thePlayer:setData("NoDamageKill", nil)

						setPedAnimation(thePlayer)

						setControlState( thePlayer, "fire", true )

						thePlayer:setHealth(100)

						thePlayer:removeFromVehicle(thePlayer:getOccupiedVehicle())

						thePlayer:setData("yo", {"", 150, 0, 0})

						outputDebugString("* ".._getPlayerNameR(player).." revivio al jugador: ".._getPlayerNameR(thePlayer).."", 0, 0, 150, 0)

						player:outputChat("* Acabas de revivir al jugador: ".._getPlayerNameR(thePlayer)..".", 50, 150, 0)

						thePlayer:outputChat("* ".._getPlayerNameR(player).." te acaba de revivir.", 50, 150, 0)

					else

						player:outputChat("* El jugador: ".._getPlayerNameR(thePlayer).." no esta muerto.", 150, 0, 0)

					end

				else

					player:outputChat("Syntax: /revivir [ID]", 255, 255, 255, true)

				end

			end

		end

	end

end

addCommandHandler("revivir", revivirJugador)



function reanimar_medico ( source, cmd, jugador )

	if not notIsGuest( source ) then

		if getPlayerFaction( source, "Medico" )  then

			if tonumber(jugador) then

				local player = getPlayerFromPartialNameID(jugador)

				if ( player ) then

					-- source

					local posicion = Vector3(source:getPosition()) -- source

					local x2, y2, z2 = posicion.x, posicion.y, posicion.z -- jugador

					-- jugador

					local pos = Vector3(player:getPosition())

					local x, y, z = pos.x, pos.y, pos.z

					local pos2 = Vector3(player:getRotation())

					local rx, ry, rz = pos2.x, pos2.y, pos2.z

					local int = player:getInterior()

					local dim = player:getDimension()

					if getDistanceBetweenPoints3D(x2, y2, z2, x, y, z) < 1.5 then -- 5

						if ( JugadorMuerto[player] == true ) then

							setPedAnimation(source, "MEDIC", "CPR", -1,true, false, false)

							outputDebugString("* ".._getPlayerNameR(source).." revivio al jugador: ".._getPlayerNameR(player).."", 0, 0, 150, 0)

							source:outputChat("* En 5 segundos será revivido el jugador: ".._getPlayerNameR(player).."", 50, 150, 50)

							JugadorMuerto[player] = nil

							setTimer(function(player, source, x, y, z, rz, int, dim) 

								if isElement(player) then

								player:spawn(x, y, z, rz, player:getModel(), int, dim, nil)

								setPedAnimation(source)

								setControlState( source, "fire", true )

								player:setHealth(10)

								player:setData("yo", {"", 150, 0, 0})

								player:outputChat("* ".._getPlayerNameR(source).." te acaba de revivir.", 50, 150, 50)

								source:outputChat("* Acabas de revivir al jugador: ".._getPlayerNameR(player)..".", 50, 150, 50)

							end

							end, 5000, 1, player, source, x, y, z, rz, int, dim)

							player:setData("NoDamageKill", false)

						else

							source:outputChat("* El jugador: ".._getPlayerNameR(player).." no esta muerto.", 150, 0, 0)

						end

					else

						source:outputChat("* Tienes que estar cerca al jugador.", 150, 0, 0)

					end

				else

					source:outputChat("Syntax: /reanimar [ID]", 255, 255, 255, true)

				end

			else

				local player = getPlayerFromPartialName(jugador)

				if ( player ) then

					-- source

					local posicion = Vector3(source:getPosition()) -- source

					local x2, y2, z2 = posicion.x, posicion.y, posicion.z -- jugador

					-- jugador

					local pos = Vector3(player:getPosition())

					local x, y, z = pos.x, pos.y, pos.z

					local pos2 = Vector3(player:getRotation())

					local rx, ry, rz = pos2.x, pos2.y, pos2.z

					local int = player:getInterior()

					local dim = player:getDimension()

					if getDistanceBetweenPoints3D(x2, y2, z2, x, y, z) < 1.5 then -- 5

						if ( JugadorMuerto[player] == true ) then

							setPedAnimation(source, "MEDIC", "CPR", -1,true, false, false)

							outputDebugString("* ".._getPlayerNameR(source).." revivio al jugador: ".._getPlayerNameR(player).."", 0, 0, 150, 0)

							source:outputChat("* En 5 segundos será revivido el jugador: ".._getPlayerNameR(player).."", 50, 150, 50)

							JugadorMuerto[player] = nil

							setTimer(function(player, source, x, y, z, rz, int, dim) 

								if isElmenet(player) then

								player:spawn(x, y, z, rz, player:getModel(), int, dim, nil)

								setPedAnimation(source)

								setControlState( source, "fire", true )

								player:setHealth(10)

								player:setData("yo", {"", 150, 0, 0})

								player:outputChat("* ".._getPlayerNameR(source).." te acaba de revivir.", 50, 150, 50)

								source:outputChat("* Acabas de revivir al jugador: ".._getPlayerNameR(player)..".", 50, 150, 50)

							end

							end, 5000, 1, player, source, x, y, z, rz, int, dim)

							player:setData("NoDamageKill", false)

						else

							source:outputChat("* El jugador: ".._getPlayerNameR(player).." no esta muerto.", 150, 0, 0)

						end

					else

						source:outputChat("* Tienes que estar cerca al jugador.", 150, 0, 0)

					end

				else

					source:outputChat("Syntax: /reanimar [ID]", 255, 255, 255, true)

				end

			end

 		else

			source:outputChat("* No puedes usar este comando", 150, 50, 50)

		end

	end

end

addCommandHandler("reanimar", reanimar_medico)

function getPlayersWithinRange( vector, range )
	local players = {}	-- body
	for i,v in ipairs(Element.getAllByType('player')) do
		
		if getDistanceBetweenPoints3D( vector, v.positon ) <= range then

			table.insert(players, v)

		end
	end
	return players
end