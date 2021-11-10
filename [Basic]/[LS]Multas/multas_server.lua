loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

if getResourceFromName( '[LS]NewData' ):getState() ~= 'running' then 
	return outputDebugString( 'Activa el recurso [LS]NewData', 3, 255, 255, 255 )
end

loadstring(exports["[LS]NewData"]:getMyCode())()
import('*'):init('[LS]NewData')

local MarcadoresMulta = {}

addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(getMarkersMultas()) do 
		Pickup = Pickup(v[1], v[2], v[3], 3, 1274, 0)
		Pickup:setInterior(v.int)
		Pickup:setDimension(v.dim)
		MarcadoresMulta[i] = Marker(v[1], v[2], v[3]-1, "cylinder", 1.3, 100, 50, 50, 0)
		MarcadoresMulta[i]:setInterior(v.int)
		MarcadoresMulta[i]:setDimension(v.dim)
	end
end)
--
addCommandHandler("pagarmulta", function(player, cmd, id)
	if isElement( player ) then
		if not notIsGuest(player) then
			for i, marker in ipairs(MarcadoresMulta) do
				if player:isWithinMarker(marker) then
					if not player:isInVehicle() then
						if tonumber(id) then
							local s = query("SELECT * From Multas where ID = ? and Cuenta = ?", id, AccountName(player))
							if not ( type( s ) == "table" and #s == 0 ) or not s then
								if player:getMoney() >= tonumber(s[1]["Cantidad"]) then
									--
									player:outputChat("Acabas de pagar tu mulda de: #004500$"..convertNumber(tonumber(s[1]["Cantidad"])).." dólares. #FFFFFFNúmero expediente: #A44B00"..s[1]["ID"].."", 255, 255, 255, true)
									--
									delete("DELETE FROM Multas WHERE ID=? and Cuenta = ?", id, AccountName(player))
									--
									player:takeMoney(tonumber(s[1]["Cantidad"]))
									--
									--refreshIDPlayerMulta(player)
								else
									exports["[LS]Notificaciones"]:setTextNoti(player, "No tienes suficiente dinero.", 150, 50, 50, true)
								end
							end
						end
					end
				end
			end
		end
	end
end)

--[[
function refreshIDPlayerMulta( player )
	if isElement(player) then
		local account = player.account.name
		local datos = query("SELECT * From Multas WHERE Cuenta='"..account.."'")
		if #datos > 0 then
			for k,v in pairs(datos) do
				local id = tonumber(v.ID)
				local id = id > 1 and tostring(id-1) or tostring(1)
				update("UPDATE Multas SET ID='"..id.."' WHERE Cuenta='"..account.."'")
			end
		end
	end
end]]
--
addCommandHandler("multas", function(player, cmd)
	if isElement(player) then
		if not notIsGuest(player) then
			local s = query("SELECT * From Multas where Cuenta=?", AccountName(player))
			if not ( type( s ) == "table" and #s == 0 ) or not s then
				player:outputChat("=== #A44B00Multas #FFFFFF===", 255, 255, 255, true)
				for i, v in ipairs(s) do
					player:outputChat("Número expediente: #A44B00"..v.ID.." #FFFFFFMulta de: #004500$"..convertNumber(v.Cantidad).." dólares.", 255, 255, 255, true)
				end
			end
		end
	end
end)
--
addCommandHandler("multar", function(player, cmd, who, money)
	if isElement(player) then
		if not notIsGuest(player) then
			if getPlayerFaction(player, "Policia") then
				if tonumber(who) then
					if tonumber(money) then
						local thePlayer = getPlayerFromPartialNameID(who)
						if (thePlayer) then
							local posicion = Vector3(player:getPosition()) -- player
							local posicion2 = Vector3(thePlayer:getPosition()) -- jugador
							local x, y, z = posicion.x, posicion.y, posicion.z -- jugador
							local x2, y2, z2 = posicion2.x, posicion2.y, posicion2.z -- player
							if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) < 10 then -- 5
								local id = math.random(100000,999999)
								print(id)
								insert("INSERT INTO Multas VALUES(?,?,?)", id, tonumber(money), AccountName(player))
								--
								thePlayer:outputChat("Acabas de ser multado por: #FFFFFF"..player:getName().."", 150, 50, 50, true)
								--
								thePlayer:outputChat("Número expediente: #004500"..convertNumber(id), 50, 150, 50, true)
								thePlayer:outputChat("Multa de: #004500$"..convertNumber(money).." dólares.", 50, 150, 50, true)
								--
								player:outputChat("Acabas de multar a "..thePlayer:getName().."", 50, 150, 50, true)
							end
						else
							player:outputChat("Syntax: /multar [id] [cantidad]", 255, 255, 255, true)
						end
					end
				end
			end
		end
	end
end)