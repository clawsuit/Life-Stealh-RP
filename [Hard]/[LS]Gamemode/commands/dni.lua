addCommandHandler("dardni", function(player, cmd, who)
	if not notIsGuest(player) then
		if tonumber(who) then
			local thePlayer = getPlayerFromPartialNameID(who)
			if (thePlayer) then
				MensajeRol(player, " le muestra su dni a ".._getPlayerNameR(thePlayer).."", 0)
				--
				thePlayer:outputChat("=== #A44B00D.N.I de ".._getPlayerNameR(thePlayer).." #FFFFFF===", 255, 255, 255, true)
				local s = query("SELECT * From datos_personajes where Cuenta = ?", AccountName(player))
				if not ( type( s ) == "table" and #s == 0 ) or not s then
					thePlayer:outputChat("Nombre: #2E2E82".. player:getName(), 255, 255, 255, true)
					thePlayer:outputChat("Edad: #2E2E82"..s[1]["Edad"], 255, 255, 255, true)
					thePlayer:outputChat("Sexo: #2E2E82"..s[1]["Sexo"], 255, 255, 255, true)
					thePlayer:outputChat("D.N.I: #2E2E82"..s[1]["DNI"], 255, 255, 255, true)
				end
			else
				player:outputChat("Syntax: /dardni [ID] [licencia]", 255, 255, 255, true)
			end
		else
			local thePlayer = getPlayerFromPartialName(who)
			if (thePlayer) then
				MensajeRol(player, " le muestra su dni a ".._getPlayerNameR(thePlayer).."", 0)
				--
				thePlayer:outputChat("=== #A44B00D.N.I de ".._getPlayerNameR(thePlayer).." #FFFFFF===", 255, 255, 255, true)
				local s = query("SELECT * From datos_personajes where Cuenta = ?", AccountName(player))
				if not ( type( s ) == "table" and #s == 0 ) or not s then
					thePlayer:outputChat("Nombre: #2E2E82".. player:getName(), 255, 255, 255, true)
					thePlayer:outputChat("Edad: #2E2E82"..s[1]["Edad"], 255, 255, 255, true)
					thePlayer:outputChat("Sexo: #2E2E82"..s[1]["Sexo"], 255, 255, 255, true)
					thePlayer:outputChat("D.N.I: #2E2E82"..s[1]["DNI"], 255, 255, 255, true)
				end
			else
				player:outputChat("Syntax: /dardni [Nombre] [licencia]", 255, 255, 255, true)
			end
		end
	end
end)