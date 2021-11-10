local licenciasPermitidos = {
["Conducir"] = "Conducir",
["Navegar"] = "Navegar",
["Piloto"] = "Piloto",
["Pesca"] = "Pesca",
}

addCommandHandler("darlicencia", function(player, cmd, who, tip)
	if not notIsGuest(player) then
		if tonumber(who) then
			local thePlayer = getPlayerFromPartialNameID(who)
			if (thePlayer) then
				local lin = table.concat({tip}, " ")
				if lin ~="" and lin ~=" " then
					local s = trunklateText(player, lin)
					if s:find(tostring(licenciasPermitidos[s])) then
						if player:getData("Roleplay:Licencia_"..licenciasPermitidos[s].."") == 1 then
							MensajeRol(player, " le muestra la licencia de "..tostring(licenciasPermitidos[s]:lower()).." a ".._getPlayerNameR(thePlayer).."", 0)
							--
							thePlayer:outputChat("=== #A44B00Licencia de "..licenciasPermitidos[s]:lower().." #FFFFFF===", 255, 255, 255, true)
							local s = query("SELECT * From datos_personajes where Cuenta = ?", AccountName(player))
							if not ( type( s ) == "table" and #s == 0 ) or not s then
								thePlayer:outputChat("Nombre: #2E2E82".. _getPlayerNameR(player), 255, 255, 255, true)
								thePlayer:outputChat("Edad: #2E2E82"..s[1]["Edad"], 255, 255, 255, true)
								thePlayer:outputChat("Sexo: #2E2E82"..s[1]["Sexo"], 255, 255, 255, true)
							end
						else
							player:outputChat("¡No tienes esa licencia!", 150, 50, 50, true)
						end
					else
						player:outputChat("* Solamente puedes poner estas licencias: ", 150, 50, 50, true)
						for i, v in pairs(licenciasPermitidos) do
							player:outputChat(licenciasPermitidos[i], 20, 50, 20, true)
						end
					end
				end
			else
				player:outputChat("Syntax: /darlicencia [ID] [licencia]", 255, 255, 255, true)
			end
		else
			local thePlayer = getPlayerFromPartialName(who)
			if (thePlayer) then
				local lin = table.concat({tip}, " ")
				if lin ~="" and lin ~=" " then
					local s = trunklateText(player, lin)
					if s:find(tostring(licenciasPermitidos[s])) then
						if player:getData("Roleplay:Licencia_"..licenciasPermitidos[s].."") == 1 then
							MensajeRol(player, " le muestra la licencia de "..tostring(licenciasPermitidos[s]:lower()).." a ".._getPlayerNameR(thePlayer).."", 0)
							--
							thePlayer:outputChat("=== #A44B00Licencia de "..licenciasPermitidos[s]:lower().." #FFFFFF===", 255, 255, 255, true)
							local s = query("SELECT * From datos_personajes where Cuenta = ?", AccountName(player))
							if not ( type( s ) == "table" and #s == 0 ) or not s then
								thePlayer:outputChat("Nombre: #2E2E82".. _getPlayerNameR(player), 255, 255, 255, true)
								thePlayer:outputChat("Edad: #2E2E82"..s[1]["Edad"], 255, 255, 255, true)
								thePlayer:outputChat("Sexo: #2E2E82"..s[1]["Sexo"], 255, 255, 255, true)
							end
						else
							player:outputChat("¡No tienes esa licencia!", 150, 50, 50, true)
						end
					else
						player:outputChat("* Solamente puedes poner estas licencias: ", 150, 50, 50, true)
						for i, v in pairs(licenciasPermitidos) do
							player:outputChat(licenciasPermitidos[i], 20, 50, 20, true)
						end
					end
				end
			else
				player:outputChat("Syntax: /darlicencia [Nombre] [licencia]", 255, 255, 255, true)
			end
		end
	end
end)