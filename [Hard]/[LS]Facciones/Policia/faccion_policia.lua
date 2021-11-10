

addCommandHandler("liderpolicia", function(player, cmd, who)

	if not notIsGuest( player ) then

		if permisos[getACLFromPlayer(player)] == true then

			if tonumber(who) then

				local thePlayer = getPlayerFromPartialNameID(who)

				if (thePlayer) then

					if thePlayer:getData("Roleplay:faccion") ~="" then

						player:outputChat(thePlayer:getName().." se encuentra en una facción debe dejar su facción para que le puedas dar el lider de policia.", 150, 50, 50, true)

					else

						local s = query("SELECT * From `Facciones` where Faccion = ? and Lider=?", 'Policia', 'Si')

						if ( type( s ) == "table" and #s == 0 ) or not s then

							player:outputChat("* Le acabas de entregar el lider a #FFFFFF"..thePlayer:getName().."", 50, 100, 50, true)

							--

							thePlayer:outputChat("* Acabas de ser entregado el Lider de la facción de Policia", 50, 150, 50, true)

							--

							insert("insert into `Facciones` VALUES (?,?,?,?,?,?,?)", 'Policia', AccountName(thePlayer), 'Comandante', '0', 'Si', '', 'No')

							--

							thePlayer:setData("Roleplay:faccion", "Policia")

							thePlayer:setData("Roleplay:faccion_lider", "Si")

							thePlayer:setData("Roleplay:faccion_rango", "Comandante")

							thePlayer:setData("Roleplay:faccion_sueldo", 0)

							thePlayer:setData("Roleplay:faccion_division", "")

							thePlayer:setData("Roleplay:faccion_division_lider", "No")

						else

							player:outputChat("* Ya se encuentra un lider en mando: #FF0033"..s[1]["Nombre"], 115, 115, 115, true)

						end

					end

				else

					player:outputChat("Syntax: /liderpolicia [ID]", 255, 255, 255, true)

				end

			else

				local thePlayer = getPlayerFromPartialName(who)

				if (thePlayer) then

					if thePlayer:getData("Roleplay:faccion") ~="" then

						player:outputChat(thePlayer:getName().." se encuentra en una facción debe dejar su facción para que le puedas dar el lider de policia.", 150, 50, 50, true)

					else

						local s = query("SELECT * From `Facciones` where Faccion = ? and Lider=?", 'Policia', 'Si')

						if ( type( s ) == "table" and #s == 0 ) or not s then

							player:outputChat("* Le acabas de entregar el lider a #FFFFFF"..thePlayer:getName().."", 50, 100, 50, true)

							--

							thePlayer:outputChat("* Acabas de ser entregado el Lider de la facción de Policia", 50, 150, 50, true)

							--

							insert("insert into `Facciones` VALUES (?,?,?,?,?,?,?)", 'Policia', AccountName(thePlayer), 'Comandante', '0', 'Si', '', 'No')

							--

							thePlayer:setData("Roleplay:faccion", "Policia")

							thePlayer:setData("Roleplay:faccion_lider", "Si")

							thePlayer:setData("Roleplay:faccion_rango", "Comandante")

							thePlayer:setData("Roleplay:faccion_sueldo", 0)

							thePlayer:setData("Roleplay:faccion_division", "")

							thePlayer:setData("Roleplay:faccion_division_lider", "No")

						else

							player:outputChat("* Ya se encuentra un lider en mando: #FF0033"..s[1]["Nombre"], 115, 115, 115, true)

						end

					end

				else

					player:outputChat("Syntax: /liderpolicia [Nombre]", 255, 255, 255, true)

				end

			end

		end

	end

end)



local antiSpamRadio = {}



function radio_police(p, cmd, ...)

	if not notIsGuest( p ) then

		if p:getData("Roleplay:faccion") ~="" then

			local tick = getTickCount()

			if (antiSpamRadio[p] and antiSpamRadio[p][1] and tick - antiSpamRadio[p][1] < 2000) then

				return

			end

			--

			local nick = _getPlayerNameR(p)

			--

			if p:getData("Roleplay:faccion_division") ~="" then

				div = "| "..p:getData("Roleplay:faccion_division").." "

			else

				div = ""

			end

			local msg = table.concat({...}, " ")

			if msg ~="" and msg ~=" " then

				local faccion = p:getData("Roleplay:faccion")

				local division = p:getData("Roleplay:faccion_division")

				outputDebugString("[RADIO] "..(p:getData("Roleplay:faccion_rango") or "").." "..div..""..nick..": "..msg.."", 0, 118, 98, 134)

				--

				for i, v in ipairs(Element.getAllByType("player")) do

					if v:getData("Roleplay:faccion") == faccion and v:getData("Roleplay:faccion_division") == division then

						--

						playSoundFrontEnd (v, 49)

						--

						setTimer(function(v, rank)

							if isElement(v) then

							v:outputChat("#FFFFFF[RADIO] #5C78BA"..(p:getData("Roleplay:faccion_rango") or "").." "..div..""..nick..":#FFFFFF "..msg.."", 118, 98, 134, true)

						end

						end, 100, 1, v, rank)

						-- antispam

						if (not antiSpamRadio[v]) then

							antiSpamRadio[v] = {}

						end

						antiSpamRadio[v][1] = getTickCount()

					end

				end

				--

				p:setData("TextInfo", {"> habla por la radio", 255, 0, 216})

				setTimer(function(p)

					if isElement(p) then

					p:setData("TextInfo", {"", 255, 0, 216})

				end

				end, 2000, 1, p)

			end

		end

	end

end

addCommandHandler({"rf", "fr"}, radio_police)

 -- [Departamental | ..faccion | ..name]: [Texto]

local antiSpamOOCRadio = {}



function ooc_radio_polices(p, cmd, ...)

	if not notIsGuest( p ) then

		if p:getData("Roleplay:faccion") ~="" then

			local tick = getTickCount()

			if (antiSpamOOCRadio[p] and antiSpamOOCRadio[p][1] and tick - antiSpamOOCRadio[p][1] < 800) then

				return

			end

			local nick = _getPlayerNameR( p )

			--

			if p:getData("Roleplay:faccion_division") ~="" then

				div = "| "..p:getData("Roleplay:faccion_division").." "

			else

				div = ""

			end

			local msg = table.concat({...}, " ")

			if msg ~="" and msg ~=" " then

				outputDebugString("[OOC] "..(p:getData("Roleplay:faccion_rango") or "").." "..div..""..nick..": "..msg.."", 0, 255, 255, 255)

				for i, v in ipairs(Element.getAllByType("player")) do

					if v:getData("Roleplay:faccion") == p:getData("Roleplay:faccion") and v:getData("Roleplay:faccion_division") == p:getData("Roleplay:faccion_division") then

						-- [OOC | ..name | ..division(SOLO SI TIENE)]: [Texto]

						v:outputChat("#FFFFFF[OOC] #243A6E"..(p:getData("Roleplay:faccion_rango") or "").." "..div..""..nick..":#FFFFFF "..msg.."", 255, 255, 255, true)

						-- antispam

					end

				end

			end

			if (not antiSpamOOCRadio[p]) then

				antiSpamOOCRadio[p] = {}

			end

			antiSpamOOCRadio[p][1] = getTickCount()

		end

	end

end

addCommandHandler({"f"}, ooc_radio_polices)



local antiSpamDepartament = {}



function radio_derpatament(p, cmd, ...)

	if not notIsGuest( p ) then

		if getPlayerFaction( p, "Policia" ) or getPlayerFaction(p, "Medico") or getPlayerDivision( p, "S.W.A.T." ) or getPlayerDivision( p, "DIC" ) or getPlayerFaction( p, "Medico" ) or getPlayerFaction( p, "Bombero" ) or getPlayerFaction( p, "Mecanico" ) or getPlayerFaction( p, "Gobierno" )  then

			local tick = getTickCount()

			if (antiSpamDepartament[p] and antiSpamDepartament[p][1] and tick - antiSpamDepartament[p][1] < 800) then

				return

			end

			local nick = _getPlayerNameR( p )

			--

			if getPlayerFaction(p, "Policia") then

				rank = "LSPD"

			elseif getPlayerFaction(p, "Medico") then

				rank = "LSRD"

			elseif getPlayerFaction(p, "Bombero") then

				rank = "LSFD"

			elseif getPlayerFaction(p, "Gobierno") then

				rank = "LSJD"

			elseif getPlayerFaction(p, "Mecanico") then

				rank = "Mecanico"

			end

			local msg = table.concat({...}, " ")

			if msg ~="" and msg ~=" " then

				for i, v in ipairs(Element.getAllByType("player")) do

					if getPlayerFaction(v, "Policia") or getPlayerFaction(v, "Medico") or getPlayerDivision( v, "S.W.A.T." ) or getPlayerDivision( v, "DIC" ) or getPlayerFaction( v, "Medico" ) or getPlayerFaction( v, "Bombero" ) or getPlayerFaction( v, "Mecanico" )  or getPlayerFaction( v, "Gobierno" ) then

						-- [Departamental | ..faccion | ..name]: [Texto]

						setTimer(function(v)

							if isElement(v) then

							v:outputChat("[Departamental "..rank.."] "..nick.." dice: "..msg.."", 0, 98, 134, true)

						end

						end, 800, 1, v)

						-- antispam

						if (not antiSpamRadio[v]) then

							antiSpamRadio[v] = {}

						end

					end

				end

			end

		end

	end

end

addCommandHandler({"d"}, radio_derpatament)



--

local antiSpam  = {} 



function megafono_policia ( source, cmd, ... )

	if not notIsGuest( source ) then

		local tick = getTickCount()

		if (antiSpam[source] and antiSpam[source][1] and tick - antiSpam[source][1] < 500) then

			return

		end

		if getPlayerFaction( source, "Policia" ) or getPlayerDivision( source, "S.W.A.T." ) or getPlayerDivision( source, "DIC" ) or getPlayerFaction( source, "Medico" ) then

			if inPlayerVehiclePolice(source) then

				local msg = table.concat({...}, " ")

				if msg ~="" and msg ~=" " then

					local vehicle = source:getOccupiedVehicle()

					local seat = source:getOccupiedVehicleSeat()

					if seat == 0 or seat == 1 then

						local pos = Vector3(vehicle:getPosition())

						local nick = _getPlayerNameR( source )

						local x, y, z = pos.x, pos.y, pos.z

						chatCol = ColShape.Sphere(x, y, z, 30)

						nearPlayers = chatCol:getElementsWithin("player") 

						outputDebugString("[MEGÁFONO] "..nick..": "..msg.."", 0, 215, 255, 0)

						for _,v in ipairs(nearPlayers) do

							v:outputChat("[MEGÁFONO] "..nick..": "..msg.."", 255, 255, 0, true)

						end

						if isElement( chatCol ) then

							destroyElement( chatCol )

						end

					end

				end

			end

		end

		if (not antiSpam[source]) then

			antiSpam[source] = {}

		end

		antiSpam[source][1] = getTickCount()

	end

end

addCommandHandler("meg", megafono_policia)



local valoresRefuerzos = {}

local antiSpamRef = {}



addCommandHandler("ref", function(p)

	if not notIsGuest( p ) then

		if getPlayerFaction( p, "Policia" ) or getPlayerDivision( p, "S.W.A.T." ) or getPlayerDivision( p, "DIC" ) or getPlayerFaction( p, "Medico" ) then

			if inPlayerVehiclePolice(p) then

				local tick = getTickCount()

				if (antiSpamRef[p] and antiSpamRef[p][1] and tick - antiSpamRef[p][1] < 2000) then

					return

				end

					local nick = _getPlayerNameR( p )

					if valoresRefuerzos[p] == true then

						valoresRefuerzos[p] = nil

						for i, v in ipairs(Element.getAllByType("player")) do

							if getPlayerFaction(v, "Policia") or getPlayerFaction( v, "Medico" ) then

								v:triggerEvent("Police:destroy_blip", v, (p:getOccupiedVehicle() or nil))

								v:outputChat("#FF6C6C* ".. nick.." ya no pide refuerzos.", 255, 255, 255, true)

							end

						end

					else

						--

						valoresRefuerzos[p] = true

						--

						for i, v in ipairs(Element.getAllByType("player")) do

							if getPlayerFaction(v, "Policia") or getPlayerFaction( v, "Medico" ) then

								--

								v:triggerEvent("Police:create_blip", v, (p:getOccupiedVehicle() or nil))

								--

								v:outputChat("#FF6C6C* ".. nick.." pide refuerzos utilizando su radio.", 255, 255, 255, true)

								v:outputChat("#A50101El "..(p:getData("Roleplay:faccion_rango") or "Cadete").." ".. nick.." necesita refuerzos, se le ha indicado su posición.", 255, 255, 255, true)

							end

						end

					end

				if (not antiSpamRef[p]) then

					antiSpamRef[p] = {}

				end

				antiSpamRef[p][1] = getTickCount()

			end

		end

	end

end)



addCommandHandler("limpref", function(p)

	if not notIsGuest( p ) then

		if getPlayerFaction( p, "Policia" ) or getPlayerDivision( p, "S.W.A.T." ) or getPlayerDivision( p, "DIC" ) or getPlayerFaction( p, "Medico" ) then

			p:outputChat("* Has eliminado todo los blips", 50, 150, 50, true)

			for _, vehs in ipairs(Element.getAllByType("vehicle")) do

				p:triggerEvent("Police:destroy_blip", p, (vehs or nil))

				if valoresRefuerzos[p] == true then

					valoresRefuerzos[p] = nil

				end

			end

		end

	end

end)



----

local _Rangos = {

	["Policia"]={

    'Cadete'

    ,'Oficial I'

    ,'Oficial II'

    ,'Oficial III'

    ,'Sargento I'

    ,'Sargento II'

    ,'General'

    ,'Teniente'

	},

	["Medico"]={

    'Aspirante'

    ,'Paramedico'

    ,'Medico'

    ,'Sub Director'

	},

	["Mecanico"]={

    'Aprendiz'

    ,'Mecanico'

    ,'Junior'

	},

	["Gobierno"]={

    'Guarura'

    ,'Guardia'

    ,'Encargado de Seguridad'

    ,'Asistente'

    ,'Abogado Privado'

    ,'Abogado Estatal'

    ,'Maestro de Derecho'

    ,'Fiscal'

	},

}



function _Cmd_Rangos(jug, cmd, name)

	if not notIsGuest( jug ) then

		if jug:getData("Roleplay:faccion") ~= "" then

			if jug:getData("Roleplay:faccion_rango") == "Teniente" or jug:getData("Roleplay:faccion_rango") == "Comandante" or jug:getData("Roleplay:faccion_rango") == "Director" or jug:getData("Roleplay:faccion_rango") == "Sub Director" or jug:getData("Roleplay:faccion_rango") == "Dueño" then

			    if tonumber(name) then

			        local who = getPlayerFromPartialNameID( name )

			        if who then

			            local old_rank = who:getData("Roleplay:faccion_rango")

			            if old_rank then

			                local ID = table.find(_Rangos[jug:getData("Roleplay:faccion")], old_rank)

			                if ID then

			                    if cmd == 'subirrango' then

			                        ID = ID + 1

			                    elseif cmd == 'bajarrango' then

			                        ID = ID - 1

			                    end

			                    if _Rangos[jug:getData("Roleplay:faccion")][ID] then

			                        if who then

			                        	update("UPDATE Facciones SET Rango = ?  WHERE Nombre = ?", _Rangos[jug:getData("Roleplay:faccion")][ID], AccountName(who))

			                            who:setData("Roleplay:faccion_rango", _Rangos[jug:getData("Roleplay:faccion")][ID])



			                            who_sms = (cmd == 'subirrango' and jug.name..' te ascendió a '.._Rangos[jug:getData("Roleplay:faccion")][ID]) or (cmd == 'bajarrango' and jug.name..' te a bajado de puesto a '.._Rangos[jug:getData("Roleplay:faccion")][ID])

			                            who:outputChat(who_sms,(cmd == 'subirrango' and 0 or 255),(cmd == 'subirrango' and 255 or 0),0)



			                            jug_sms = (cmd == 'subirrango' and "Ascendiste a "..name) or (cmd == 'bajarrango' and "Bajaste de puesto a "..name)

			                            jug:outputChat(jug_sms,(cmd == 'subirrango' and 0 or 255),(cmd == 'subirrango' and 255 or 0),0)

			                        end

			                    end

			                end

			            end

			        else

			        	jug:outputChat("Syntax: /subirrango [ID]", 255, 255, 255)

			        	jug:outputChat("Syntax: /bajarrango [ID]", 255, 255, 255)

			        end

			    else

			        local who = getPlayerFromPartialName( name ) or false

			        if who then

			            local old_rank = who:getData("Roleplay:faccion_rango") or false

			            if old_rank then

			                local ID = table.find(_Rangos, old_rank)

			                if ID then

			                    if cmd == 'subirrango' then

			                        ID = ID + 1

			                    elseif cmd == 'bajarrango' then

			                        ID = ID - 1

			                    end

			                    if _Rangos[jug:getData("Roleplay:faccion")][ID] then

			                        if who then

			                        	update("UPDATE Facciones SET Rango = ?  WHERE Nombre = ?", _Rangos[jug:getData("Roleplay:faccion")][ID], AccountName(jug))

			                            who:setData("Roleplay:faccion_rango", _Rangos[jug:getData("Roleplay:faccion")][ID])



			                            who_sms = (cmd == 'subirrango' and jug.name..' te ascendió a '.._Rangos[jug:getData("Roleplay:faccion")][ID]) or (cmd == 'bajarrango' and jug.name..' te a bajado de puesto a '.._Rangos[jug:getData("Roleplay:faccion")][ID])

			                            who:outputChat(who_sms,(cmd == 'subirrango' and 0 or 255),(cmd == 'subirrango' and 255 or 0),0)



			                            jug_sms = (cmd == 'subirrango' and "Ascendiste a "..name) or (cmd == 'bajarrango' and "Bajaste de puesto a "..name)

			                            jug:outputChat(jug_sms,(cmd == 'subirrango' and 0 or 255),(cmd == 'subirrango' and 255 or 0),0)

			                        end

			                    end

			                end

			            end

			        else

			        	jug:outputChat("Syntax: /subirrango [ID]", 255, 255, 255)

			        	jug:outputChat("Syntax: /bajarrango [ID]", 255, 255, 255)

			        end

			    end

			end

		end

	end

end

addCommandHandler('subirrango',_Cmd_Rangos)

addCommandHandler('bajarrango',_Cmd_Rangos)



function table.find(t, value)

    for k,v in pairs(t) do

        if v == value then

            return k,v

        end

    end

    return false

end

----------------------------------------- despedir 

addCommandHandler("despedir", function(source, cmd, who)

	if not notIsGuest( source ) then

		if source:getData( "Roleplay:faccion" ) ~="" then

			if source:getData("Roleplay:faccion_rango") == "Comandante" or source:getData("Roleplay:faccion-rango") == "Teniente" or source:getData("Roleplay:faccion-rango") == "Director" or source:getData("Roleplay:faccion-rango") == "Sub Director" then

				if tonumber(who) then

					local player = getPlayerFromPartialNameID(who)

					if (player) then

						if not getPlayerLeader(player) then

							local s = query("SELECT * From `Facciones` where Nombre = ?", tostring(AccountName(player)))

							if ( type( s ) == "table" and #s == 0 ) or not s then

								source:outputChat("* El jugador: "..player:getName().." no se encuentra en la facción", 150, 50, 50, true)

							else

								source:outputChat("* El jugador: "..player:getName().." ha sido despedido", 50, 150, 50, true)

								delete("DELETE FROM Facciones WHERE Nombre=?", AccountName(player))

								player:setData("Roleplay:faccion", "")

								player:setData("Roleplay:faccion_lider", "No")

								player:setData("Roleplay:faccion_rango", "")

								player:setData("Roleplay:faccion_sueldo", 0)

								for i ,v in ipairs(Element.getAllByType("player")) do

									if v:getData("Roleplay:faccion") == source:getData("Roleplay:faccion") then

										v:outputChat("* El jugador: "..player:getName().." ha sido despedido por "..source:getName(), 50, 150, 50, true)

									end

								end

							end

						end

					else

						source:outputChat("Syntax: /despedir [ID]", 255, 255, 255, true)

					end

				else

					local player = getPlayerFromPartialName(who)

					if (player) then

						if not getPlayerLeader(player) then

							local s = query("SELECT * From `Facciones` where Nombre = ?", tostring(AccountName(player)))

							if ( type( s ) == "table" and #s == 0 ) or not s then

								source:outputChat("* El jugador: "..player:getName().." no se encuentra en la facción", 150, 50, 50, true)

							else

								source:outputChat("* El jugador: "..player:getName().." ha sido despedido", 50, 150, 50, true)

								delete("DELETE FROM Facciones WHERE Nombre=?", AccountName(player))

								player:setData("Roleplay:faccion", "")

								player:setData("Roleplay:faccion_lider", "No")

								player:setData("Roleplay:faccion_rango", "")

								player:setData("Roleplay:faccion_sueldo", 0)

								for i ,v in ipairs(Element.getAllByType("player")) do

									if v:getData("Roleplay:faccion") == source:getData("Roleplay:faccion") then

										v:outputChat("* El jugador: "..player:getName().." ha sido despedido por "..source:getName(), 50, 150, 50, true)

									end

								end

							end

						end

					else

						source:outputChat("Syntax: /despedir [Nombre]", 255, 255, 255, true)

					end

				end

			end

		end

	end

end)

----------------------------------------- Arrestar jugadores

function esposar_policia ( source, cmd, jugador )

	if not notIsGuest( source ) then

		if getPlayerFaction( source, "Policia" ) then

			if tonumber(jugador) then

				local player = getPlayerFromPartialNameID(jugador)

				if ( player ) then

					if (player:getName() ~= source:getName()) then

						-- source

						local posicion = Vector3(source:getPosition()) -- source

						local x2, y2, z2 = posicion.x, posicion.y, posicion.z

						-- jugador

						local pos = Vector3(player:getPosition())

						local x, y, z = pos.x, pos.y, pos.z

						if getDistanceBetweenPoints3D(x2, y2, z2, x, y, z) < 1.5 then -- 5

							if player:getData("Roleplay:arrestado") ~="arrestado" then

								if player:getOccupiedVehicle() then

									player:removeFromVehicle(player:getOccupiedVehicle())

								end

								player:setFrozen(false)

								toggleControl( player, "aim_weapon", false )

								toggleControl( player, "next_weapon", false )

								toggleControl( player, "previous_weapon", false )

								toggleControl( player, "jump", false )

								toggleControl( player, "fire", false )

								player:setData("Esposado", true)

								player:setWeaponSlot(0)

								--

								source:outputChat("* Acabas de Esposar al jugador: #FFFFFF"..player:getName().."", 0, 150, 0, true)

							end

						else

							source:outputChat("* Tienes que estar cerca al jugador.", 150, 0, 0)

						end

					else

						source:outputChat("* No te puedes Esposar tu mismo", 150, 0, 0)

					end

				end

			end

		end

	end

end

addCommandHandler("esposar", esposar_policia)

----------------------------------------- liberar arrestado

function liberar_policia ( source, cmd, jugador )

	if not notIsGuest( source ) then

		if getPlayerFaction( source, "Policia" ) then

			if tonumber(jugador) then

				local player = getPlayerFromPartialNameID(jugador)

				if ( player ) then

					-- source

					local posicion = Vector3(source:getPosition()) -- source

					local x2, y2, z2 = posicion.x, posicion.y, posicion.z

					-- jugador

					local pos = Vector3(player:getPosition())

					local x, y, z = pos.x, pos.y, pos.z

					if getDistanceBetweenPoints3D(x2, y2, z2, x, y, z) < 1.5 then -- 5

						player:outputChat("* Acabas ser liberado.", 50, 150, 50, true)

						source:outputChat("* Acabas de liberar al jugador: #FFFFFF"..player:getName().."", 0, 150, 0, true)

						player:setData("Esposado", false)

						toggleControl( player, "aim_weapon", true )

						toggleControl( player, "next_weapon", true )

						toggleControl( player, "previous_weapon", true )

						toggleControl( player, "jump", true )

						toggleControl( player, "fire", true )

					else

						source:outputChat("* Tienes que estar cerca al jugador.", 150, 0, 0)

					end

				end

			end

		end

	end

end

addCommandHandler("liberar", liberar_policia)

----------------------------------------- megafono