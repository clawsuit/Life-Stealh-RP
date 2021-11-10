addCommandHandler("asignardivision", function(player, cmd, who, ...)
	if not notIsGuest( player ) then
		if getPlayerFaction( player, "Policia" ) and getPlayerLeader(player) then
			if player:getData("Roleplay:faccion_rango") == "Comandante" then
				if tonumber(who) then
					local thePlayer = getPlayerFromPartialNameID(who)
					if (thePlayer) then
						local div = table.concat({...}, "")
						if div ~="" and div ~=" " then
							if div:find("S.W.A.T.") or div:find("DIC") or div:find("s.w.a.t.") or div:find("dic") then
								if getPlayerFaction(thePlayer, "Policia") then
									local s = query("SELECT * From `Facciones` where Division = ? and Division_Lider=?", div:upper(), 'Si')
									if ( type( s ) == "table" and #s == 0 ) or not s then
										player:outputChat("Le has entregado la division "..div:upper().." a ".._getPlayerNameR(thePlayer).."", 50, 150, 50, true)
										thePlayer:outputChat("".._getPlayerNameR(player).." te ah dado liderasgo de la división "..div:upper().."", 50, 150, 50, true)
										--
										thePlayer:setData("Roleplay:faccion_division", div:upper())
										thePlayer:setData("Roleplay:faccion_division_lider", "Si")
										--
										update("UPDATE Facciones SET Division_Lider = ?  WHERE Nombre = ?", 'Si', AccountName(thePlayer))
										update("UPDATE Facciones SET Division = ?  WHERE Nombre = ?", div:upper(), AccountName(thePlayer))
									else
										player:outputChat("* Ya se encuentra un lider en mando: #FF0033"..s[1]["Nombre"], 115, 115, 115, true)
									end
								end
							else
								player:outputChat("* Solo debes asignar las Divisiones: S.W.A.T.  y DIC", 150, 50, 50, true)
							end
						end
					else
						player:outputChat("Syntax: /asignardivision [ID] [Division]", 255, 255, 255, true)
					end
				else
					local thePlayer = getPlayerFromPartialName(who)
					if (thePlayer) then
						local div = table.concat({...}, "")
						if div ~="" and div ~=" " then
							if div:find("S.W.A.T.") or div:find("DIC") or div:find("s.w.a.t.") or div:find("dic") then
								if getPlayerFaction(thePlayer, "Policia") then
									local s = query("SELECT * From `Facciones` where Division = ? and Division_Lider=?", div:upper(), 'Si')
									if ( type( s ) == "table" and #s == 0 ) or not s then
										player:outputChat("Le has entregado la division "..div:upper().." a ".._getPlayerNameR(thePlayer).."", 50, 150, 50, true)
										thePlayer:outputChat("".._getPlayerNameR(player).." te ah dado liderasgo de la división "..div:upper().."", 50, 150, 50, true)
										--
										thePlayer:setData("Roleplay:faccion_division", div:upper())
										thePlayer:setData("Roleplay:faccion_division_lider", "Si")
										--
										update("UPDATE Facciones SET Division_Lider = ?  WHERE Nombre = ?", 'Si', AccountName(thePlayer))
										update("UPDATE Facciones SET Division = ?  WHERE Nombre = ?", div:upper(), AccountName(thePlayer))
									else
										player:outputChat("* Ya se encuentra un lider en mando: #FF0033"..s[1]["Nombre"], 115, 115, 115, true)
									end
								end
							else
								player:outputChat("* Solo debes asignar las Divisiones: S.W.A.T.  y DIC", 150, 50, 50, true)
							end
						end
					else
						player:outputChat("Syntax: /asignardivision [Nombre] [Division]", 255, 255, 255, true)
					end
				end
			end
		end
	end
end)

addCommandHandler("quitardivision", function(player, cmd, who, ...)
	if not notIsGuest( player ) then
		if getPlayerFaction( player, "Policia" ) and getPlayerLeader(player) then
			if player:getData("Roleplay:faccion_rango") == "Comandante" then
				if tonumber(who) then
					local thePlayer = getPlayerFromPartialNameID(who)
					if (thePlayer) then
						local div = table.concat({...}, "")
						if div ~="" and div ~=" " then
							if div:find("S.W.A.T.") or div:find("DIC") or div:find("s.w.a.t.") or div:find("dic") then
								if getPlayerFaction(thePlayer, "Policia") then
									local s = query("SELECT * From `Facciones` where Division = ? and Division_Lider=?", div:upper(), 'Si')
									if not ( type( s ) == "table" and #s == 0 ) or not s then
										player:outputChat("Le has quitado la faccion "..div:upper().." a ".._getPlayerNameR(thePlayer).."", 50, 150, 50, true)
										thePlayer:outputChat("".._getPlayerNameR(player).." te ah quitado la division "..div:upper().."", 150, 50, 50, true)

										thePlayer:setData("Roleplay:faccion_division", "")
										thePlayer:setData("Roleplay:faccion_division_lider", "No")

										update("UPDATE Facciones SET Division_Lider = ?  WHERE Nombre = ?", 'No', AccountName(thePlayer))
										update("UPDATE Facciones SET Division = ?  WHERE Nombre = ?", '', AccountName(thePlayer))
									end
								end
							else
								player:outputChat("* Solo debes asignar las Divisiones: S.W.A.T.  y DIC", 150, 50, 50, true)
							end
						end
					else
						player:outputChat("Syntax: /quitardivision [ID] [Division]", 255, 255, 255, true)
					end
				else
					local thePlayer = getPlayerFromPartialName(who)
					if (thePlayer) then
						local div = table.concat({...}, "")
						if div ~="" and div ~=" " then
							if div:find("S.W.A.T.") or div:find("DIC") or div:find("s.w.a.t.") or div:find("dic") then
								if getPlayerFaction(thePlayer, "Policia") then
									local s = query("SELECT * From `Facciones` where Division = ? and Division_Lider=?", div:upper(), 'Si')
									if not ( type( s ) == "table" and #s == 0 ) or not s then
										player:outputChat("Le has quitado la faccion "..div:upper().." a ".._getPlayerNameR(thePlayer).."", 50, 150, 50, true)
										thePlayer:outputChat("".._getPlayerNameR(player).." te ah quitado la division "..div:upper().."", 150, 50, 50, true)

										thePlayer:setData("Roleplay:faccion_division", "")
										thePlayer:setData("Roleplay:faccion_division_lider", "No")
										update("UPDATE Facciones SET Division_Lider = ?  WHERE Nombre = ?", 'No', AccountName(thePlayer))
										update("UPDATE Facciones SET Division = ?  WHERE Nombre = ?", '', AccountName(thePlayer))
									end
								end
							else
								player:outputChat("* Solo debes asignar las Divisiones: S.W.A.T.  y DIC", 150, 50, 50, true)
							end
						end
					else
						player:outputChat("Syntax: /quitardivision [Nombre] [Division]", 255, 255, 255, true)
					end
				end
			end
		end
	end
end)

--/sacardivision [ID] (Esto es para sacar a alguien de la division, el que ejecuta "Has sacado de la division a ..name" al afectado "Fuiste retirado de la division ..division por ..name.")

addCommandHandler("meterdivision", function(player, cmd, who)
	if not notIsGuest( player ) then
		if getPlayerFaction( player, "Policia" ) and getPlayerLeaderDivision(player) then
			if tonumber(who) then
				local thePlayer = getPlayerFromPartialNameID(who)
				if (thePlayer) then
					if thePlayer:getData("Roleplay:faccion_division") == "" then
						player:outputChat("Has metido a ".._getPlayerNameR(thePlayer).." a la division "..player:getData("Roleplay:faccion_division").."", 100, 100, 30, true)
						thePlayer:outputChat(_getPlayerNameR(player).." te metió a la división "..player:getData("Roleplay:faccion_division").."", 50, 100, 50, true)
						--
						thePlayer:setData("Roleplay:faccion_division", player:getData("Roleplay:faccion_division"))
						thePlayer:setData("Roleplay:faccion_division_lider", "No")
						--
						update("UPDATE Facciones SET Division_Lider = ?  WHERE Nombre = ?", 'No', AccountName(thePlayer))
						update("UPDATE Facciones SET Division = ?  WHERE Nombre = ?", player:getData("Roleplay:faccion_division"), AccountName(thePlayer))
					else
						player:outputChat("* El jugador: ".._getPlayerNameR(thePlayer).." ya se encuentra en una división.", 150, 50, 50, true)
					end
				else
					player:outputChat("Syntax: /meterdivision [ID]", 255, 255, 255, true)
				end
			else
				local thePlayer = getPlayerFromPartialName(who)
				if (thePlayer) then
					if thePlayer:getData("Roleplay:faccion_division") == "" then
						player:outputChat("Has metido a ".._getPlayerNameR(thePlayer).." a la division "..player:getData("Roleplay:faccion_division").."", 100, 100, 30, true)
						thePlayer:outputChat(_getPlayerNameR(player).." te metió a la división "..player:getData("Roleplay:faccion_division").."", 50, 100, 50, true)
						--
						thePlayer:setData("Roleplay:faccion_division", player:getData("Roleplay:faccion_division"))
						thePlayer:setData("Roleplay:faccion_division_lider", "No")
						--
						update("UPDATE Facciones SET Division_Lider = ?  WHERE Nombre = ?", 'No', AccountName(thePlayer))
						update("UPDATE Facciones SET Division = ?  WHERE Nombre = ?", player:getData("Roleplay:faccion_division"), AccountName(thePlayer))
					else
						player:outputChat("* El jugador: ".._getPlayerNameR(thePlayer).." ya se encuentra en una división.", 150, 50, 50, true)
					end
				else
					player:outputChat("Syntax: /meterdivision [Nombre]", 255, 255, 255, true)
				end
			end
		end
	end
end)

addCommandHandler("sacardivision", function(player, cmd, who)
	if not notIsGuest( player ) then
		if getPlayerFaction( player, "Policia" ) and getPlayerLeaderDivision(player) then
			if tonumber(who) then
				local thePlayer = getPlayerFromPartialNameID(who)
				if (thePlayer) then
					if thePlayer:getData("Roleplay:faccion_division") ~= "" then
						if thePlayer:getData("Roleplay:faccion_division") == player:getData("Roleplay:faccion_division") then
							player:outputChat("Has sacado de la division a ".._getPlayerNameR(thePlayer).."", 100, 100, 30, true)
							thePlayer:outputChat(" Fuiste retirado de la division "..player:getData("Roleplay:faccion_division").." por ".._getPlayerNameR(player).."", 50, 100, 50, true)
							--
							thePlayer:setData("Roleplay:faccion_division", "")
							thePlayer:setData("Roleplay:faccion_division_lider", "No")
							--
							update("UPDATE Facciones SET Division_Lider = ?  WHERE Nombre = ?", 'No', AccountName(thePlayer))
							update("UPDATE Facciones SET Division = ?  WHERE Nombre = ?", '', AccountName(thePlayer))
						else
							player:outputChat("* El jugador: ".._getPlayerNameR(thePlayer).." no se encuentra en tu división.", 150, 50, 50)
						end
					end
				else
					player:outputChat("Syntax: /sacardivision [ID]", 255, 255, 255, true)
				end
			else
				local thePlayer = getPlayerFromPartialName(who)
				if (thePlayer) then
					if thePlayer:getData("Roleplay:faccion_division") == "" then
						player:outputChat("Has metido a ".._getPlayerNameR(thePlayer).." a la division "..player:getData("Roleplay:faccion_division").."", 100, 100, 30, true)
						thePlayer:outputChat(_getPlayerNameR(player).." te metió a la división "..player:getData("Roleplay:faccion_division").."", 50, 100, 50, true)
						--
						thePlayer:setData("Roleplay:faccion_division", player:getData("Roleplay:faccion_division"))
						thePlayer:setData("Roleplay:faccion_division_lider", "No")
						--
						update("UPDATE Facciones SET Division_Lider = ?  WHERE Nombre = ?", 'No', AccountName(thePlayer))
						update("UPDATE Facciones SET Division = ?  WHERE Nombre = ?", player:getData("Roleplay:faccion_division"), AccountName(thePlayer))
					else
						player:outputChat("* El jugador: ".._getPlayerNameR(thePlayer).." ya se encuentra en una división.", 150, 50, 50, true)
					end
				else
					player:outputChat("Syntax: /meterdivision [Nombre]", 255, 255, 255, true)
				end
			end
		end
	end
end)