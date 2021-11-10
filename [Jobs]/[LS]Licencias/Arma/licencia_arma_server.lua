local LicenciasArmas = {}

addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in pairs( getLicenciaArmas() ) do
		LicenciasArmas[i] = Marker( v[1], v[2], v[3]-1, "cylinder", 1.5, 100, 100, 100, 0 )
		LicenciasArmas[i]:setInterior(v.int)
		LicenciasArmas[i]:setDimension(v.dim)
	end
end)

addCommandHandler("portearma", function(player, cmd)
	if not notIsGuest(player) then
		if not player:isInVehicle() then
			for i, v in ipairs(LicenciasArmas) do
				if player:isWithinMarker(v) then
					if getPlayerYear(player) >= 18 then
						if player:getData("PlayerNivel") >= 3 then
							if player:getMoney() >= 2500 then
								player:setData("Roleplay:Licencia_Arma", player:getData("Roleplay:Licencia_Arma") + 1)
								player:outputChat("Acabas de obtener la licencia de armas por: #004500$2,500 dólares", 50, 150, 50, true)
								player:takeMoney(2500)
							else
								exports["[LS]Notificaciones"]:setTextNoti(player, "No tienes suficiente dinero.", 150, 50, 50, true)
							end
						else
							exports["[LS]Notificaciones"]:setTextNoti(player, "¡Necesitas ser nivel 3 para obtener esta licencia!", 150, 50, 50, true)
						end
					else
						exports["[LS]Notificaciones"]:setTextNoti(player, "Debes ser mayor de 18 años.", 150, 50, 50, true)
					end
				end
			end
		end
	end
end)

function getPlayerYear(player)
	if isElement(player) then
		local s = query("SELECT * From datos_personajes where Cuenta = ?", AccountName(player))
		if s then
			if not ( type( s ) == "table" and #s == 0 ) or not s then
				return tonumber(s[1]["Edad"]) or 0
			end
		end
	end
end