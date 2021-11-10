loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

loadstring(exports["[LS]NewData"]:getMyCode())()
import('*'):init('[LS]NewData')

permisos = {
["Administrador"]=true,
["SuperModerador"]=true,
["Moderador"]=true,
}

addEventHandler("onPlayerLogin", getRootElement(), function()
	if permisos[getACLFromPlayer(source)] == true then
		source:setData("Admin:Disponible", true)
	end
end)

function staff_estado ( source )
	if permisos[getACLFromPlayer(source)] == true then
		local rango = getACLFromPlayer(source)
		local nick = source:getName()
		if (source:getData("Admin:Disponible") or false) == true then
			source:setData("Admin:Disponible", false)
			source:outputChat("ahora se encuentra #ee0000ocupado ", 255, 255, 255, true)
		else
			source:setData("Admin:Disponible", true)
			source:outputChat("ahora se encuentra #00EE19disponible", 255, 255, 255, true)
		end
	else
		source:outputChat("* No tienes permiso para este comando :p", 150, 0, 0)
	end
end
addCommandHandler("dutty", staff_estado)

function logPlayer(player, cmd, who, ...)
	if not notIsGuest( player ) then
		if permisos[getACLFromPlayer(player)] == true then
			local typ = table.concat({...}, " ")
			if typ ~="" and typ~=" " then
				if tonumber(who) then
					local thePlayer = getPlayerFromPartialNameID(who)
					if (thePlayer) then
						if typ:find("Banco") then
							local s = query("SELECT * From BancoLog where Cuenta='"..AccountName(thePlayer).."'")
							if not ( type( s ) == "table" and #s == 0 ) or not s then
								player:triggerEvent("setVisibl", player, typ, s, thePlayer)
							end
						end
					else
						player:outputChat("Syntax: /log [Tipo] [ID]", 255, 255, 255, true)
					end
				end
			end
		end
	end
end
addCommandHandler("log", logPlayer)

--- STAFFS
function anuncio_staff( source, cmd, ... )
	if not notIsGuest( source ) then
		if permisos[getACLFromPlayer(source)] == true then
			local msg = table.concat({...}, " ")
			if msg ~="" and msg ~=" " then
				local s = trunklateText( source, msg )
				for i, v in ipairs(Element.getAllByType("player")) do
					v:outputChat(_getPlayerNameR(source)..": #FFFFFF"..s, 20, 150, 20, true)
				end
			else
				source:outputChat("Syntax: /an [Mensaje]", 255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("an", anuncio_staff)

function skinPlayer ( player, cmd, who, id )
	if not notIsGuest( player ) then
		if permisos[getACLFromPlayer(player)] == true then
			if tonumber(who) then
				if tonumber(id) then
					local thePlayer = getPlayerFromPartialNameID(who)
					if (thePlayer) then
						if (id) then
							local allSkins = getValidPedModels( )
							local result = false
							for key, skin in ipairs(allSkins) do
								if skin == tonumber(id) then
									thePlayer:setModel(skin)
									outputDebugString(player:getName().." le ha dado la skin "..skin.." a "..thePlayer:getName().."", 0, 50, 150, 50)
									player:outputChat("Le has dado la skin "..skin.." a "..thePlayer:getName().."", 50, 150, 50, true)
									thePlayer:outputChat("* El administrador "..player:getName().." te ha dado la skin "..skin.."", 50, 150, 50, true)
								end
							end
						end
					else
						player:outputChat("Syntax: /skin [ID] [ID]", 255, 255, 255, true)
					end
				end
			else
				if tonumber(id) then
					local thePlayer = getPlayerFromPartialName(who)
					if (thePlayer) then
						if (id) then
							local allSkins = getValidPedModels( )
							local result = false
							for key, skin in ipairs(allSkins) do
								if skin == tonumber(id) then
									thePlayer:setModel(skin)
									outputDebugString(player:getName().." le ha dado la skin "..skin.." a "..thePlayer:getName().."", 0, 50, 150, 50)
									player:outputChat("Le has dado la skin "..skin.." a "..thePlayer:getName().."", 50, 150, 50, true)
									thePlayer:outputChat("* El administrador "..player:getName().." te ha dado la skin "..skin.."", 50, 150, 50, true)
								end
							end
						end
					else
						player:outputChat("Syntax: /skin [Nombre] [ID]", 255, 255, 255, true)
					end
				end
			end
		end
	end
end
addCommandHandler("skin", skinPlayer)

function cuentas_player(source, cmd, who)
	if not notIsGuest( source ) then
		if permisos[getACLFromPlayer(source)] == true then
			if tonumber(who) then
				local player = getPlayerFromPartialNameID(who)
				if (player) then
					if player ~= source then
						local serial = player:getSerial()
						local accs = query("SELECT * FROM `Registros` where Serial=?", tostring(serial))
						if not ( type( accs ) == "table" and #accs == 0 ) or not accs then
							source:outputChat("¡ Todas las cuentas registradas de: "..player:getName().." !", 150, 50, 50, true)
							for _, v in ipairs(accs) do
								source:outputChat("Nombre de cuenta: #00FF00"..v.Cuenta, 80, 150, 80, true)
								source:outputChat("Fecha de la creación: #00FF00"..v.Fecha, 80, 150, 80, true)
								source:outputChat("---------------------", 80, 150, 80, true)
							end
						end
					end
				else
					source:outputChat("Syntax: /cuentas [ID]", 255, 255, 255, true)
				end
			else
				local player = getPlayerFromPartialName(who)
				if (player) then
					if player ~= source then
						local serial = player:getSerial()
						local accs = query("SELECT * FROM `Registros` where Serial=?", tostring(serial))
						if not ( type( accs ) == "table" and #accs == 0 ) or not accs then
							source:outputChat("¡ Todas las cuentas registradas de: "..player:getName().." !", 150, 50, 50, true)
							for _, v in ipairs(accs) do
								source:outputChat("Nombre de cuenta: #00FF00"..v.Cuenta, 80, 150, 80, true)
								source:outputChat("Fecha de la creación: #00FF00"..v.Fecha, 80, 150, 80, true)
								source:outputChat("---------------------", 80, 150, 80, true)
							end
						end
					end
				else
					source:outputChat("Syntax: /cuentas [Nombre]", 255, 255, 255, true)
				end
			end
		end
	end
end
addCommandHandler("cuentas", cuentas_player)

function kickPlayerStaff(player, cmd, who, reason)
	if not notIsGuest(player) then
		if permisos[getACLFromPlayer(player)] == true then
			if tonumber(who) then
				local thePlayer = getPlayerFromPartialNameID(who)
				if (thePlayer) then
					local rs = table.concat({reason}, " ")
					if rs ~="" and rs~=" " then
						outputDebugString(player:getName().. " kickeo a "..thePlayer:getName().." | Razón: "..rs, 0, 0, 150, 0)
						for i, v in ipairs(Element.getAllByType("player")) do
							v:outputChat("Un miembro de staff ha kickeado al jugador: #FF0033"..thePlayer:getName().."", 255, 255, 255, true)
							v:outputChat("Razón: #FF0033"..rs, 255, 255, 255, true)
						end
						exports["[LS]Gamemode"]:message_admins("Fue: #00FF00"..player:getName(), 255, 255, 255, true)
						thePlayer:kick(player, rs)
					else
						player:outputChat("Escribe una razón para kickear.", 150, 50, 50, true)
					end
				else
					player:outputChat("Syntax: /kickear [ID] [Razón]", 255, 255, 255, true)
				end
			else
				local thePlayer = getPlayerFromPartialName(who)
				if (thePlayer) then
					local rs = table.concat({reason}, " ")
					if rs ~="" and rs~=" " then
						outputDebugString(player:getName().. " kickeo a "..thePlayer:getName().." | Razón: "..rs, 0, 0, 150, 0)
						for i, v in ipairs(Element.getAllByType("player")) do
							v:outputChat("Un miembro de staff ha kickeado al jugador: #FF0033"..thePlayer:getName().."", 255, 255, 255, true)
							v:outputChat("Razón: #FF0033"..rs, 255, 255, 255, true)
						end
						exports["[LS]Gamemode"]:message_admins("Fue: #00FF00"..player:getName(), 255, 255, 255, true)
						thePlayer:kick(player, rs)
					else
						player:outputChat("Escribe una razón para kickear.", 150, 50, 50, true)
					end
				else
					player:outputChat("Syntax: /kickear [ID] [Razón]", 255, 255, 255, true)
				end
			end
		end
	end
end
addCommandHandler("kickear", kickPlayerStaff)

function QuitarArmasP(player, cmd, who)
	if not notIsGuest(player) then
		if getACLFromPlayer(player) == "Administrador" or getACLFromPlayer(player) == "SuperModerador" then
			if tonumber(who) then
				local thePlayer = getPlayerFromPartialNameID(who)
				if (thePlayer) then
					outputDebugString(player:getName().. " le quito sus armas al jugador "..thePlayer:getName(), 0, 0, 150, 0)
					player:outputChat("Le acabas de quitar las armas al jugador: #00FF00"..thePlayer:getName(), 255, 255, 255, true)
					thePlayer:outputChat("El administrador "..player:getName().." te ha quitado todas tus armas", 150, 50, 50, true)
					takeAllWeapons(thePlayer)
				else
					player:outputChat("Syntax: /quitararmas [ID]", 255, 255, 255, true)
				end
			else
				local thePlayer = getPlayerFromPartialName(who)
				if (thePlayer) then
					outputDebugString(player:getName().. " le quito sus armas al jugador "..thePlayer:getName(), 0, 0, 150, 0)
					player:outputChat("Le acabas de quitar las armas al jugador: #00FF00 ", 255, 255, 255, true)
					thePlayer:outputChat("El administrador "..player:getName().." te ha quitado todas tus armas", 150, 50, 50, true)
					takeAllWeapons(thePlayer)
				else
					player:outputChat("Syntax: /quitararmas [ID]", 255, 255, 255, true)
				end
			end
		end
	end
end
addCommandHandler("quitararmas", QuitarArmasP)

function llevar_jugador(source, cmd, who, jugador)
	if not notIsGuest( source ) then
		if permisos[getACLFromPlayer(source)] == true then
			if tonumber(who) then
				local player = getPlayerFromPartialNameID(who)
				local thePlayer = getPlayerFromPartialNameID(jugador)
				if ( player ) and ( thePlayer ) then
					--if player ~= source and thePlayer ~= source then
						local posicion = Vector3(thePlayer:getPosition())
						local x, y, z = posicion.x, posicion.y, posicion.z
						local dim = thePlayer:getDimension()
						local int = thePlayer:getInterior()
						outputDebugString("* "..source:getName().." llevo al jugador: "..player:getName().." hacia: "..thePlayer:getName().."", 0, 0, 150, 0)
						player:outputChat("Un "..getACLFromPlayer(source).." te llevo al jugador "..thePlayer:getName().."", 20, 150, 20)
						fadeCamera(player, false)
						if player:isInVehicle() then
							player:removeFromVehicle(player:getOccupiedVehicle())
						end
						setTimer(fadeCamera, 1000, 1, player, true)
						setTimer(function(player, x, y, z, int, dim, thePlayer)
							if isElement(player) then
								player:setInterior(int)
								player:setPosition(x, y, z)
								player:setDimension(dim)
							end
						end, 1000, 1, player, x, y, z+2, int, dim, thePlayer)
					--end
				else
					source:outputChat("Syntax: /llevar [ID] [Nombre]", 255, 255, 255, true)
				end
			else
				local player = getPlayerFromPartialName(who)
				local thePlayer = getPlayerFromPartialName(jugador)
				if ( player ) and ( thePlayer ) then
					--if player ~= source and thePlayer ~= source then
						local posicion = Vector3(thePlayer:getPosition())
						local x, y, z = posicion.x, posicion.y, posicion.z
						local dim = thePlayer:getDimension()
						local int = thePlayer:getInterior()
						outputDebugString("* "..source:getName().." llevo al jugador: "..player:getName().." hacia: "..thePlayer:getName().."", 0, 0, 150, 0)
						player:outputChat("Un "..getACLFromPlayer(source).." te llevo al jugador "..thePlayer:getName().."", 20, 150, 20)
						fadeCamera(player, false)
						if player:isInVehicle() then
							player:removeFromVehicle(player:getOccupiedVehicle())
						end
						setTimer(fadeCamera, 1000, 1, player, true)
						setTimer(function(player, x, y, z, int, dim, thePlayer)
							if isElement(player) then
								player:setInterior(int)
								player:setPosition(x, y, z)
								player:setDimension(dim)
							end
						end, 1000, 1, player, x, y, z+2, int, dim, thePlayer)
					--end
				else
					source:outputChat("Syntax: /llevar [Nombre] [Nombre]", 255, 255, 255, true)
				end
			end
		end
	end
end
addCommandHandler("llevar", llevar_jugador)

function get_position( source )
	if permisos[getACLFromPlayer(source)] == true then
		local posicion = Vector3(source:getPosition())
		local x, y, z = posicion.x, posicion.y, posicion.z
		local posicion2 = Vector3(source:getRotation())
		local rx, ry, rz = posicion2.x, posicion2.y, posicion2.z
		local dim = source:getDimension()
		local int = source:getInterior()
		source:outputChat("Posicion: "..x..", "..y..", "..z.."", 150, 0, 0)
		source:outputChat("Rotacion: "..rx..", "..ry..", "..rz.."", 150, 0, 0)
		source:outputChat("Interior: "..int.."", 150, 0, 0)
		source:outputChat("Dimension: "..dim.."", 150, 0, 0)
	end
end
addCommandHandler("pos", get_position)

function warpearse_jugador( source, cmd, jugador )
	if permisos[getACLFromPlayer(source)] == true then
		if tonumber( jugador ) then
			local player = getPlayerFromPartialNameID(jugador)
			if ( player ) then
				if player ~= source then
					local posicion = Vector3(player:getPosition())
					local x, y, z = posicion.x, posicion.y, posicion.z
					local dim = player:getDimension()
					local int = player:getInterior()
					outputDebugString("* "..source:getName().." se dio warp al jugador: "..player:getName().."", 0, 0, 150, 0)
					fadeCamera(source, false)
					if source:isInVehicle() then
						source:removeFromVehicle(source:getOccupiedVehicle())
					end
					setTimer(fadeCamera, 1000, 1, source, true)
					setTimer(function(source, x, y, z, int, dim, player)
						if isElement(source) or isElement(player) then
						source:outputChat("* Te acabas de dar warp al jugador: #00FF00"..player:getName().."", 255, 255, 255, true)
						player:outputChat("* "..source:getName().." se dio warp a ti", 0, 150, 0)
						source:setInterior(int)
						source:setPosition(x, y, z)
						source:setDimension(dim)
					end
					end, 1000, 1, source, x, y, z+2, int, dim, player)
				end
			else
				source:outputChat("Syntax: /ir [ID]", 255, 255, 255, true)
			end
		else
			local player = getPlayerFromPartialName(jugador)
			if ( player ) then
				if player ~= source then
					local posicion = Vector3(player:getPosition())
					local x, y, z = posicion.x, posicion.y, posicion.z
					local dim = player:getDimension()
					local int = player:getInterior()
					outputDebugString("* "..source:getName().." se dio warp al jugador: "..player:getName().."", 0, 0, 150, 0)
					fadeCamera(source, false)
					if source:isInVehicle() then
						source:removeFromVehicle(source:getOccupiedVehicle())
					end
					setTimer(fadeCamera, 1000, 1, source, true)
					setTimer(function(source, x, y, z, int, dim, player)
						if isElement(source) or isElement(player) then
						source:outputChat("* Te acabas de dar warp al jugador: #00FF00"..player:getName().."", 255, 255, 255, true)
						player:outputChat("* "..source:getName().." se dio warp a ti", 0, 150, 0)
						source:setInterior(int)
						source:setPosition(x, y, z)
						source:setDimension(dim)
					end
					end, 1000, 1, source, x, y, z+2, int, dim, player)
				end
			else
				source:outputChat("Syntax: /ir [Nombre]", 255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("ir", warpearse_jugador)

function warp_jugador( source, cmd, jugador )
	if permisos[getACLFromPlayer(source)] == true then
		if tonumber( jugador ) then
			local player = getPlayerFromPartialNameID(jugador)
			if ( player ) then
				if player ~= source then
					local posicion = Vector3(source:getPosition())
					local x, y, z = posicion.x, posicion.y, posicion.z
					local dim = source:getDimension()
					local int = source:getInterior()
					outputDebugString("* "..source:getName().." le dio warp al jugador: #00FF00"..player:getName().."", 0, 0, 150, 0)
					fadeCamera(player, false)
					if player:isInVehicle() then
						player:removeFromVehicle(player:getOccupiedVehicle())
					end
					setTimer(fadeCamera, 1000, 1, player, true)
					setTimer(function(source, x, y, z, int, dim, player)
						if isElement(source) or isElement(player) then
						source:outputChat("* Le acabas de dar warp al jugador: #00FF00"..player:getName().."", 255, 255, 255, true)
						player:outputChat("* "..source:getName().." te dio warp hacia el", 0, 150, 0)
						player:setInterior(int)
						player:setPosition(x, y, z+2)
						player:setDimension(dim)
					end
					end, 1000, 1, source, x, y, z, int, dim, player)
				end
			else
				source:outputChat("Syntax: /traer [ID]", 255, 255, 255, true)
			end
		else
			local player = getPlayerFromPartialName(jugador)
			if ( player ) then
				if player ~= source then
					local posicion = Vector3(source:getPosition())
					local x, y, z = posicion.x, posicion.y, posicion.z
					local dim = source:getDimension()
					local int = source:getInterior()
					if player:isInVehicle() then
						player:removeFromVehicle(player:getOccupiedVehicle())
					end
					outputDebugString("* "..source:getName().." le dio warp al jugador: "..player:getName().."", 0, 0, 150, 0)
					fadeCamera(player, false)
					setTimer(fadeCamera, 1000, 1, player, true)
					setTimer(function(source, x, y, z, int, dim, player)
						if isElement(source) or isElement(player) then
						source:outputChat("* Le acabas de dar warp al jugador: #00FF00"..player:getName().."", 255, 255, 255, true)
						player:outputChat("* "..source:getName().." te dio warp hacia el", 0, 150, 0)
						player:setInterior(int)
						player:setPosition(x, y, z+2)
						player:setDimension(dim)
					end
					end, 1000, 1, source, x, y, z, int, dim, player)
				end
			else
				source:outputChat("Syntax: /traer [Nombre]", 255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("traer", warp_jugador)

local valoresJugador = {}

function espiar_jugadores(player, cmd, who)
	if not notIsGuest( player ) then
		if permisos[getACLFromPlayer(player)] == true then
			if tonumber(who) then
				local jugador = getPlayerFromPartialNameID(who)
				if (jugador) then
					local target = getCameraTarget(player)
					if (target == player) then
						local pos = Vector3(player:getPosition())
						local int = player:getInterior()
						local dim = player:getDimension()
						valoresJugador[player] = {x, y, z, int, dim}
						setCameraTarget(player, jugador)
						local intJugador = jugador:getInterior()
						local dimJugador = jugador:getDimension()
						player:setInterior(intJugador)
						player:setDimension(dimJugador)
						outputDebugString("* "..player:getName().." esta espiando al jugador: "..jugador:getName().."", 0, 50, 150, 50)
						player:outputChat("* Espiando al jugador: #00FF00"..jugador:getName().."", 50, 150, 50, true)
						player:outputChat("* Para quitar el espiar, espiate tu mismo..", 150, 50, 50)
					elseif (not target == player) then
						setCameraTarget(player)
						player:setPosition(valoresJugador[player][1], valoresJugador[player][2], valoresJugador[player][3])
						player:setInterior(valoresJugador[player][4])
						player:setDimension(valoresJugador[player][5])
						valoresJugador[player] = nil
					end
				else
					player:outputChat("Syntax: /espiar [ID]", 255, 255, 255, true)
				end
			else
				local jugador = getPlayerFromPartialName(who)
				if (jugador) then
					local target = getCameraTarget(player)
					if (target == player) then
						local pos = Vector3(player:getPosition())
						local int = player:getInterior()
						local dim = player:getDimension()
						valoresJugador[player] = {x, y, z, int, dim}
						setCameraTarget(player, jugador)
						local intJugador = jugador:getInterior()
						local dimJugador = jugador:getDimension()
						player:setInterior(intJugador)
						player:setDimension(dimJugador)
						outputDebugString("* "..player:getName().." esta espiando al jugador: "..jugador:getName().."", 0, 50, 150, 50)
						player:outputChat("* Espiando al jugador: #00FF00"..jugador:getName().."", 50, 150, 50, true)
						player:outputChat("* Para quitar el espiar, espiate tu mismo..", 150, 50, 50)
					elseif (not target == player) then
						setCameraTarget(player)
						player:setPosition(valoresJugador[player][1], valoresJugador[player][2], valoresJugador[player][3])
						player:setInterior(valoresJugador[player][4])
						player:setDimension(valoresJugador[player][5])
						valoresJugador[player] = nil
					end
				else
					player:outputChat("Syntax: /espiar [Nombre]", 255, 255, 255, true)
				end
			end
		end
	end
end
addCommandHandler("espiar", espiar_jugadores)

function give_health(player, cmd, who, tp, valor)
	if not notIsGuest( player ) then
		if permisos[getACLFromPlayer(player)] == true then
			if tonumber(who) then
				local jugador = getPlayerFromPartialNameID(who)
				if (jugador) then
					if tonumber(valor) then
						if tonumber(valor) >= 0 and tonumber(valor) <= 100 then
							if tp == "-" then
								outputDebugString("* "..player:getName().." le quito -"..valor.." vida a "..jugador:getName().."", 0, 50, 150, 50)
								player:outputChat("* Le quitaste -"..valor.." de vida al jugador: "..jugador:getName().."", 50, 150, 50, true)
								jugador:outputChat("¡El ("..getACLFromPlayer(player)..") "..player:getName().." te quito -"..valor.." de vida !", 150, 20, 20)
								--
								jugador:setHealth(jugador:getHealth()-tonumber(valor))
							elseif tp == "+" then
								outputDebugString("* "..player:getName().." le dio vida a "..jugador:getName().."", 0, 50, 150, 50)
								player:outputChat("* Le aumentaste +"..valor.." de vida al jugador: "..jugador:getName().."", 50, 255, 50, true)
								jugador:outputChat("¡El ("..getACLFromPlayer(player)..") "..player:getName().." te aumento +"..valor.." de vida !", 150, 255, 150)
								--
								jugador:setHealth(jugador:getHealth()+tonumber(valor))
							else
								player:outputChat("Syntax: /vida [Nombre o ID] [-/+] [valor]", 150, 50, 50, true)
							end
						else
							player:outputChat("* El valor debe ser entre 1-100", 150, 0, 0, true)
						end
					end
				else
					player:outputChat("Recuerda que + es para aumentar y - para bajar.", 150, 50, 50, true)
					player:outputChat("Syntax: /vida [ID] + [Valor]", 255, 255, 255, true)
				end
			else
				local jugador = getPlayerFromPartialName(who)
				if (jugador) then
					if tonumber(valor) then
						if tonumber(valor) >= 0 and tonumber(valor) <= 100 then
							if tp == "-" then
								outputDebugString("* "..player:getName().." le quito -"..valor.." vida a "..jugador:getName().."", 0, 50, 150, 50)
								player:outputChat("* Le quitaste -"..valor.." de vida al jugador: "..jugador:getName().."", 50, 150, 50, true)
								jugador:outputChat("¡El ("..getACLFromPlayer(player)..") "..player:getName().." te quito -"..valor.." de vida !", 150, 20, 20)
								--
								jugador:setHealth(jugador:getHealth()-tonumber(valor))
							elseif tp == "+" then
								outputDebugString("* "..player:getName().." le dio vida a "..jugador:getName().."", 0, 50, 150, 50)
								player:outputChat("* Le aumentaste +"..valor.." de vida al jugador: "..jugador:getName().."", 50, 255, 50, true)
								jugador:outputChat("¡El ("..getACLFromPlayer(player)..") "..player:getName().." te aumento +"..valor.." de vida !", 150, 255, 150)
								--
								jugador:setHealth(jugador:getHealth()+tonumber(valor))
							else
								player:outputChat("Syntax: /vida [Nombre o ID] [-/+] [valor]", 150, 50, 50, true)
							end
						else
							player:outputChat("* El valor debe ser entre 1-100", 150, 0, 0, true)
						end
					end
				else
					player:outputChat("Recuerda que + es para aumentar y - para bajar.", 150, 50, 50, true)
					player:outputChat("Syntax: /vida [ID] + [Valor]", 255, 255, 255, true)
				end
			end
		end
	end
end
addCommandHandler("vida", give_health)

function give_armor(player, cmd, who, tp, valor)
	if not notIsGuest( player ) then
		if permisos[getACLFromPlayer(player)] == true then
			if tonumber(who) then
				local jugador = getPlayerFromPartialNameID(who)
				if (jugador) then
					if tonumber(valor) then
						if tonumber(valor) >= 0 and tonumber(valor) <= 100 then
							if tp == "-" then
								outputDebugString("* "..player:getName().." le quito -"..valor.." de chaleco a "..jugador:getName().."", 0, 50, 150, 50)
								player:outputChat("* Le quito -"..valor.." de chaleco al jugador: "..jugador:getName().." ", 150, 150, 150, true)
								jugador:outputChat("¡El ("..getACLFromPlayer(player)..") "..player:getName().." te quito -"..valor.." de chaleco", 150, 20, 20)
								--
								jugador:setArmor(jugador:getArmor()-tonumber(valor))
							elseif tp == "+" then
								outputDebugString("* "..player:getName().." le dio +"..valor.." chaleco a "..jugador:getName().." ", 0, 50, 150, 50)
								player:outputChat("* Le dio +"..valor.." de chaleco al jugador: "..jugador:getName().."", 150, 150, 150, true)
								jugador:outputChat("¡El ("..getACLFromPlayer(player)..") "..player:getName().." te dio +"..valor.." de chaleco", 150, 255, 150)
								--
								jugador:setArmor(jugador:getArmor()+tonumber(valor))
							else
								player:outputChat("Syntax: /chaleco [Nombre o ID] [-] o [+] [valor]", 150, 50, 50, true)
							end
						else
							player:outputChat("* El valor debe ser entre 1-100", 150, 0, 0, true)
						end
					end
				else
					player:outputChat("Recuerda que + es para aumentar y - para bajar.", 150, 50, 50, true)
					player:outputChat("Syntax: /chaleco [ID] + [Valor]", 255, 255, 255, true)
				end
			else
				local jugador = getPlayerFromPartialName(who)
				if (jugador) then
					if tonumber(valor) then
						if tonumber(valor) >= 0 and tonumber(valor) <= 100 then
							if tp == "-" then
								outputDebugString("* "..player:getName().." le quito -"..valor.." de chaleco a "..jugador:getName().."", 0, 50, 150, 50)
								player:outputChat("* Le quito -"..valor.." de chaleco al jugador: "..jugador:getName().." ", 150, 150, 150, true)
								jugador:outputChat("¡El ("..getACLFromPlayer(player)..") "..player:getName().." te quito -"..valor.." de chaleco", 150, 20, 20)
								--
								jugador:setArmor(jugador:getArmor()-tonumber(valor))
							elseif tp == "+" then
								outputDebugString("* "..player:getName().." le dio +"..valor.." de chaleco a "..jugador:getName().." ", 0, 50, 150, 50)
								player:outputChat("* Le dio +"..valor.." de chaleco al jugador: "..jugador:getName().."", 150, 150, 150, true)
								jugador:outputChat("¡El ("..getACLFromPlayer(player)..") "..player:getName().." te dio +"..valor.." de chaleco", 150, 255, 150)
								--
								jugador:setArmor(jugador:getArmor()+tonumber(valor))
							else
								player:outputChat("Syntax: /chaleco [Nombre o ID] [-] o [+] [valor]", 150, 50, 50, true)
							end
						else
							player:outputChat("* El valor debe ser entre 1-100", 150, 0, 0, true)
						end
					end
				else
					player:outputChat("Recuerda que + es para aumentar y - para bajar.", 150, 50, 50, true)
					player:outputChat("Syntax: /chaleco [ID] + [Valor]", 255, 255, 255, true)
				end
			end
		end
	end
end
addCommandHandler("chaleco", give_armor)

function trunklateText(thePlayer, text, factor)
    local msg = (tostring(text):gsub("%u", string.lower))
	return (tostring(msg):gsub("^%l", string.upper))
end