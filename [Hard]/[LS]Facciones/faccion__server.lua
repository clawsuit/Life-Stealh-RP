loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

_addCommandHandler = addCommandHandler
function addCommandHandler(comando, func)
    if type(comando) == 'table' then
        for i,v in ipairs(comando) do
            _addCommandHandler(v, func)
        end
    else
        return _addCommandHandler(comando, func)
    end
end

-- save_facctions
addEventHandler("onPlayerJoin", getRootElement(), function()
	source:setData("Roleplay:faccion", "")
	source:setData("Roleplay:faccion_division", "")
	source:setData("Roleplay:faccion_lider", "No")
	source:setData("Roleplay:faccion_division_lider", "No")
	source:setData("Roleplay:faccion_rango", "")
	source:setData("Roleplay:faccion_sueldo", 0)
end)
addEventHandler("onPlayerLogin", getRootElement(), function()
	local cuenta = AccountName(source)
	local s = query("SELECT * From `Facciones` where Nombre =?", tostring(cuenta))
	if not ( type( s ) == "table" and #s == 0 ) or not s then
		local lider = s[1]["Lider"]
		if lider == "Si" then
			source:setData("Roleplay:faccion_lider", "Si")
		else
			source:setData("Roleplay:faccion_lider", "No")
		end
		local liderdivision = s[1]["Division_Lider"]
		if liderdivision == "Si" then
			source:setData("Roleplay:faccion_division_lider", "Si")
		else
			source:setData("Roleplay:faccion_division_lider", "No")
		end
		--
		source:setData("Roleplay:faccion", tostring(s[1]["Faccion"]))
		source:setData("Roleplay:faccion_rango", tostring(s[1]["Rango"]))
		source:setData("Roleplay:faccion_sueldo", tonumber(s[1]["Sueldo"]))
		source:setData("Roleplay:faccion_division", tostring(s[1]["Division"]))
	else
		source:setData("Roleplay:faccion", "")
		source:setData("Roleplay:faccion_lider", "No")
		source:setData("Roleplay:faccion_division_lider", "No")
		source:setData("Roleplay:faccion_rango", "")
		source:setData("Roleplay:faccion_division", "")
		source:setData("Roleplay:faccion_sueldo", 0)
	end
end)
---
permisos = {
["Administrador"]=true,
}

permisosTotal = {
["Administrador"]=true,
["SuperModerador"]=true,
["Moderador"]=true,
["Enc.Facciones"]=true,
}

local faccionesText = {
["Policia"] = "Policia",
["Medico"] = "Medico",
["Mecanico"] = "Mecanico",
["Gobierno"] = "Gobierno",
}

addCommandHandler("limpiarfaccion", function(player, cmd, faccion)
	if not notIsGuest( player ) then
		if permisos[getACLFromPlayer(player)] == true or getACLFromPlayer(player) == "Enc.Facciones" then
			local fac = table.concat({faccion}, "")
			if fac ~="" and fac ~=" " then
				local s = trunklateText(player, fac)
				if s:find(tostring(faccionesText[s])) then
					player:outputChat("Acabas de limpiar la facción: "..tostring(faccionesText[s]), 50, 150, 50, true)
					--
					delete("DELETE FROM Facciones WHERE Faccion=?", tostring(faccionesText[s]))
					--
					for _, player in ipairs(Element.getAllByType("player")) do
						if player:getData("Roleplay:faccion") == tostring(faccionesText[s]) then
							player:setData("Roleplay:faccion", "")
							player:setData("Roleplay:faccion_lider", "No")
							player:setData("Roleplay:faccion_division_lider", "No")
							player:setData("Roleplay:faccion_rango", "")
							player:setData("Roleplay:faccion_division", "")
							player:setData("Roleplay:faccion_sueldo", 0)
						end
					end
				else
					player:outputChat("* Solamente puedes limpiar estas facciones: ", 150, 50, 50, true)
					for i, v in pairs(faccionesText) do
						player:outputChat(faccionesText[i], 20, 50, 20, true)
					end
				end
			end
		end
	end
end)

function trunklateText(thePlayer, text, factor)
    local msg = (tostring(text):gsub("%u", string.lower))
	return (tostring(msg):gsub("^%l", string.upper))
end

addCommandHandler("data", function(player, cmd, who)
	if not notIsGuest( player ) then
		if permisos[getACLFromPlayer(player)] == true then
			if tonumber(who) then
				local thePlayer = getPlayerFromPartialNameID(who)
				if (thePlayer) then
					print("Faccion: "..thePlayer:getData("Roleplay:faccion"))
					print("Lider: "..thePlayer:getData("Roleplay:faccion_lider"))
					print("Rango: "..thePlayer:getData("Roleplay:faccion_rango"))
					print("Sueldo: "..thePlayer:getData("Roleplay:faccion_sueldo"))
					print("Division: "..thePlayer:getData("Roleplay:faccion_division"))
					print("Lider de Division: "..thePlayer:getData("Roleplay:faccion_division_lider"))
				end
			end
		end
	end
end)

addCommandHandler("dejarfaccion", function(player)
	if not notIsGuest( player ) then
		if player:getData("Roleplay:faccion") ~="" then
			if not getPlayerLeader(player) then
				player:outputChat("* Acabas de abandar tu facción: #FF0033"..player:getData("Roleplay:faccion"), 50, 150, 50, true)
				for i , v in ipairs(Element.getAllByType("player")) do
					if getPlayerFaction(v, player:getData("Roleplay:faccion")) then
						v:outputChat("* ".._getPlayerNameR(player).." abandono el trabajo", 150, 50, 50, true)
					end
				end
				delete("DELETE FROM Facciones WHERE Nombre=?", AccountName(player))
				player:setData("Roleplay:faccion", "")
				player:setData("Roleplay:faccion_lider", "No")
				player:setData("Roleplay:faccion_rango", "")
				player:setData("Roleplay:faccion_sueldo", 0)
				player:setData("Roleplay:faccion_division", "")
				player:setData("Roleplay:faccion_division_lider", "No")
			end
		end
	end
end)

local solicitud_contrato = {}
local tabla_contratos = {}
local datos_jugador = {}
local timerContrato = {}

addCommandHandler("contratar", function(player, cmd, who)
	if not notIsGuest( player ) then
		if player:getData("Roleplay:faccion") ~="" then
			if solicitud_contrato[player] == nil and solicitud_contrato[player] == false then
				player:outputChat("* Ya has enviado una solicitud de contrato a un jugador.", 150, 0, 0, true)
			else
				if getPlayerLeader(player) then
					if tonumber(who) then
						local thePlayer = getPlayerFromPartialNameID(who)
						if (thePlayer) then
							if thePlayer:getData("Roleplay:faccion") == "" then
								local posicion = Vector3(player:getPosition()) -- player
								local posicion2 = Vector3(thePlayer:getPosition()) -- jugador
								local x, y, z = posicion.x, posicion.y, posicion.z -- jugador
								local x2, y2, z2 = posicion2.x, posicion2.y, posicion2.z -- player
								if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) < 10 then -- 5
									if tabla_contratos[thePlayer] == true then
										player:outputChat("* Ya hay otra persona mandandole una solicitud.", 150, 50, 50, true)
									else
										solicitud_contrato[player] = true
										tabla_contratos[thePlayer] = true
										--
										datos_jugador[thePlayer] = player:getName()
										--
										timerContrato[player] = setTimer( function(player, thePlayer) if isElement(player) or isElement(thePlayer) then solicitud_contrato[player] = nil tabla_contratos[thePlayer] = nil datos_jugador[thePlayer] = {}  end end, 60000, 1, player, thePlayer)
										--
										player:outputChat("Le has mando una solicitud al jugador: "..thePlayer:getName().." ", 50, 255, 50)
										if getPlayerFaction(player, "Policia") then
											mensajeText = "#003F74LSPD (Policias)."
										elseif getPlayerFaction(player, "Medico") then
											mensajeText = "##004E50LSPD (Medicos)."
										elseif getPlayerFaction(player, "Mecanico") then
											mensajeText = "#9B9A00Mecanicos."
										elseif getPlayerFaction(player, "Gobierno") then
											mensajeText = "#9B9A9BGobiernos."
										end
										thePlayer:outputChat("#FFFF00"..player:getName().." #ffffffte invito a unirte a "..mensajeText, 50, 255, 50)
										thePlayer:outputChat("/aceptarcontrato", 50, 150, 50)
										thePlayer:outputChat("/cancelarcontrato", 150, 50, 50)
										--
									end
								end
							else
								player:outputChat("* Se encuentra en una facción ahora mismo.", 150, 50, 50, true)
							end
						else
							player:outputChat("Syntax: /contratar [ID]", 255, 255, 255, true)
						end
					else
						local thePlayer = getPlayerFromPartialName(who)
						if (thePlayer) then
							if thePlayer:getData("Roleplay:faccion") == "" then
								local posicion = Vector3(player:getPosition()) -- player
								local posicion2 = Vector3(thePlayer:getPosition()) -- jugador
								local x, y, z = posicion.x, posicion.y, posicion.z -- jugador
								local x2, y2, z2 = posicion2.x, posicion2.y, posicion2.z -- player
								if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) < 10 then -- 5
									if tabla_contratos[thePlayer] == true then
										player:outputChat("* Ya hay otra persona mandandole una solicitud.", 150, 50, 50, true)
									else
										solicitud_contrato[player] = true
										tabla_contratos[thePlayer] = true
										--
										datos_jugador[thePlayer] = player:getName()
										--
										timerContrato[player] = setTimer( function(player, thePlayer) if isElement(player) or isElement(thePlayer) then solicitud_contrato[player] = nil tabla_contratos[thePlayer] = nil datos_jugador[thePlayer] = {}  end end, 60000, 1, player, thePlayer)
										--
										player:outputChat("Le has mando una solicitud al jugador: "..thePlayer:getName().." ", 50, 255, 50)
										if getPlayerFaction(player, "Policia") then
											mensajeText = "#003F74LSPD (Policias)."
										elseif getPlayerFaction(player, "Medico") then
											mensajeText = "##004E50LSPD (Medicos)."
										elseif getPlayerFaction(player, "Mecanico") then
											mensajeText = "#9B9A00Mecanicos."
										elseif getPlayerFaction(player, "Gobierno") then
											mensajeText = "#9B9A9BGobiernos."
										end
										thePlayer:outputChat("#FFFF00"..player:getName().." #ffffffte invito a unirte a "..mensajeText, 50, 255, 50)
										thePlayer:outputChat("/aceptarcontrato", 50, 150, 50)
										thePlayer:outputChat("/cancelarcontrato", 150, 50, 50)
										--
									end
								end
							else
								player:outputChat("* Se encuentra en una facción ahora mismo.", 150, 50, 50, true)
							end
						else
							player:outputChat("Syntax: /contratar [Nombre]", 255, 255, 255, true)
						end
					end
				end
			end
		end
	end
end)

addCommandHandler("aceptarcontrato", function(source, cmd)
	if not notIsGuest( source ) then
		if tabla_contratos[source] == true then
			local thePlayer = getPlayerFromPartialName(datos_jugador[source])
			if ( thePlayer ) then
				MensajeRoleplay( source, " firmo un contrato.", 215, 122, 8 )
				--
				if thePlayer:getData("Roleplay:faccion") == "Policia" then
					rank = "Cadete"
				elseif thePlayer:getData("Roleplay:faccion") == "Medico" then
					rank = "Aspirante"
				elseif thePlayer:getData("Roleplay:faccion") == "Gobierno" then
					rank = "Guarura"
				elseif thePlayer:getData("Roleplay:faccion") == "Mecanico" then
					rank = "Aprendiz"
				else
					rank ="N/A"
				end
				--
				insert("insert into `Facciones` VALUES (?,?,?,?,?,?,?)", tostring(thePlayer:getData("Roleplay:faccion")), AccountName(source), rank, '0', 'No', '', 'No')
				--
				source:setData("Roleplay:faccion", tostring(thePlayer:getData("Roleplay:faccion")))
				source:setData("Roleplay:faccion_lider", "No")
				source:setData("Roleplay:faccion_rango", rank)
				source:setData("Roleplay:faccion_sueldo", 0)
				source:setData("Roleplay:faccion_division", "")
				source:setData("Roleplay:faccion_division_lider", "No")
				--
				solicitud_contrato[thePlayer] = nil
				tabla_contratos[source] = nil
				datos_jugador[source] = nil
				if isTimer(timerContrato[source]) then
					killTimer(timerContrato[source])
					timerContrato[source] = nil
				end
				if isTimer(timerContrato[thePlayer]) then
					killTimer(timerContrato[thePlayer])
					timerContrato[thePlayer] = nil
				end
			end
		end
	end
end)

addCommandHandler("cancelarcontrato", function(source, cmd)
	if not notIsGuest( source ) then
		if tabla_contratos[source] == true then
			local thePlayer = getPlayerFromPartialName(datos_jugador[source])
			if ( thePlayer ) then
				MensajeRoleplay( source, " cancelo el contrato de ".._getPlayerNameR(thePlayer).."", 215, 122, 8 )
				solicitud_contrato[thePlayer] = nil
				tabla_contratos[source] = nil
				datos_jugador[source] = nil
				if isTimer(timerContrato[source]) then
					killTimer(timerContrato[source])
					timerContrato[source] = nil
				end
				if isTimer(timerContrato[thePlayer]) then
					killTimer(timerContrato[thePlayer])
					timerContrato[thePlayer] = nil
				end
			end
		end
	end
end)

facciones = {
["Policia"] = "Policia",
}

addCommandHandler("miembros", function(player, cmd, faccion)
--
	if not notIsGuest( player ) then
		local fac = table.concat({faccion}, "")
		if fac ~="" and fac ~=" " then
			local s = trunklateText(player, fac)
			if s:find(tostring(faccionesText[s])) then
				player:outputChat("* Miembros de la facción "..tostring(faccionesText[s]).."", 115, 115, 115, true)
				--
				for i, v in ipairs(Element.getAllByType("player")) do
					if getPlayerFaction(v, tostring(faccionesText[s])) then
						player:outputChat("* ".._getPlayerNameR(v).." | "..v:getData("Roleplay:faccion_rango").." | "..v:getData("Roleplay:faccion_division").." ", 50, 150, 50, true)
					end
				end
			else
				player:outputChat("* Solamente puedes ver miembros de estas facciones: ", 150, 50, 50, true)
				for i, v in pairs(faccionesText) do
					player:outputChat(faccionesText[i], 20, 50, 20, true)
				end
			end
		end
	end
end)

--
local TaserCables = {}

addEvent("setAnimAndCable", true)
function setAnimAndCable( p )
	TaserCables[p] = true
	p:setAnimation("ped", "FLOOR_hit_f", -1,true, false, false)
	p:setFrozen(true)
end
addEventHandler("setAnimAndCable", root, setAnimAndCable)

addCommandHandler("quitarcables", function(player, cmd, who)
	if not notIsGuest(player) then
		if player:getData("Roleplay:faccion") ~="" then
			if getPlayerFaction(player, "Policia") or getPlayerDivision(player, "S.W.A.T.") or getPlayerDivision(player, "DIC") then
				if tonumber(who) then
					local thePlayer = getPlayerFromPartialNameID(who)
					if (thePlayer) then
						local posicion = Vector3(player:getPosition()) -- player
						local posicion2 = Vector3(thePlayer:getPosition()) -- jugador
						local x, y, z = posicion.x, posicion.y, posicion.z -- jugador
						local x2, y2, z2 = posicion2.x, posicion2.y, posicion2.z -- player
						if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) < 2 then -- 5
							if TaserCables[thePlayer] == true then
								player:setAnimation("BOMBER", "BOM_Plant", -1,true, false, false)
								--
								setTimer(function(player, p)
									if isElement(player) or isElement(p) then
									setPedAnimation(p)
									setPedAnimation(player)
									p:setFrozen(false)
									player:setFrozen(false)
									TaserCables[p] = nil
									MensajeRoleplay(player, "le quito los cables a ".._getPlayerNameR(p), 215, 122, 8)
								end
								end, 1000, 1, player, thePlayer)
							else
								player:outputChat("El ".._getPlayerNameR(thePlayer).." no esta paralizado.", 150, 50, 50, true)
							end
						else
							player:outputChat("* Te encuentras muy alejado del jugador ".._getPlayerNameR(thePlayer).."", 150, 50, 50, true)
						end
					else
						player:outputChat("Syntax: /quitarcables [ID]", 255, 255, 255, true)
					end
				else
					local thePlayer = getPlayerFromPartialName(who)
					if (thePlayer) then
						local posicion = Vector3(player:getPosition()) -- player
						local posicion2 = Vector3(thePlayer:getPosition()) -- jugador
						local x, y, z = posicion.x, posicion.y, posicion.z -- jugador
						local x2, y2, z2 = posicion2.x, posicion2.y, posicion2.z -- player
						if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) < 2 then -- 5
							if TaserCables[thePlayer] == true then
								player:setAnimation("BOMBER", "BOM_Plant", -1,true, false, false)
								--player:setFrozen(true)
								--
								setTimer(function(player, p)
									if isElement(player) or isElement(p) then
									setPedAnimation(p)
									setPedAnimation(player)
									p:setFrozen(false)
									player:setFrozen(false)
									TaserCables[p] = nil
									MensajeRoleplay(player, "le quito los cables a ".._getPlayerNameR(p), 215, 122, 8)
								end
								end, 1000, 1, player, thePlayer)
							else
								player:outputChat("El ".._getPlayerNameR(thePlayer).." no esta paralizado.", 150, 50, 50, true)
							end
						else
							player:outputChat("* Te encuentras muy alejado del jugador ".._getPlayerNameR(thePlayer).."", 150, 50, 50, true)
						end
					else
						player:outputChat("Syntax: /quitarcables [Nombre]", 255, 255, 255, true)
					end
				end
			end
		end
	end
end)

local GuardarPistola = {}
addCommandHandler('taser',
	function(p)
		if getPlayerFaction( p, 'Policia' ) then
			local cuenta = p.account.name;
			local oldWep = p:getWeapon(2) or false
			if oldWep ~= 23 or not oldWep then
				if oldWep == 22 or oldWep == 24 then
					GuardarPistola[cuenta] = {oldWep, p:getTotalAmmo(2)}
				end
				giveWeapon(p, 23, 5, true)
				setWeaponAmmo(p,23,5)
			else
				if GuardarPistola[cuenta] then
					local id,ammo = unpack(GuardarPistola[cuenta])
					giveWeapon(p, id,ammo, true )
				else
					takeWeapon( p, 23 )
				end
			end
		end
	end
)

function getTaserCables( player )
	if isElement(player) and player:getType() == "player" then
		if TaserCables[player] == true then
			return true
		else
			return false
		end
	end
	return false
end

function MensajeRoleplay( player, texto, r, g, b )
	local pos = Vector3(player:getPosition())
	local x, y, z = pos.x, pos.y, pos.z
	local chatCol = ColShape.Sphere(x, y, z, 10)
	local nearPlayers = chatCol:getElementsWithin("player")
	for index, v in ipairs(nearPlayers) do
		v:outputChat("#FF00D8* ".._getPlayerNameR(player).." "..(texto or ""), 255, 255, 255, true)
	end
	if isElement(chatCol) then
		destroyElement(chatCol)
	end
end

-- taser function
setWeaponProperty("silenced", "pro", "weapon_range", 45.0)
setWeaponProperty("silenced", "pro", "maximum_clip_ammo", 1)
setWeaponProperty("silenced", "pro", "damage", 100)

setWeaponProperty("silenced", "std", "weapon_range", 45.0)
setWeaponProperty("silenced", "std", "maximum_clip_ammo", 1)
setWeaponProperty("silenced", "std", "damage", 100)

setWeaponProperty("silenced", "poor", "weapon_range", 45.0)
setWeaponProperty("silenced", "poor", "maximum_clip_ammo", 1)
setWeaponProperty("silenced", "poor", "damage", 100)
