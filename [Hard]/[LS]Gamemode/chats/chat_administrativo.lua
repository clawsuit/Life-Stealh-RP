local antiSpamAdmin = {}
local Administradores ={
["Administrador"]=true,
["SuperModerador"]=true,
["Moderador"]=true,
}
function chatAdministrativo(player, cmd, ...)
	if not notIsGuest(player) then
		if Administradores[getACLFromPlayer(player)] == true then
			local tick = getTickCount()
			if (Administradores[player] and Administradores[player][1] and tick - Administradores[player][1] < 500) then
				return
			end
			local msg = table.concat({...}, " ")
			if msg ~="" and msg ~=" " then
				local nick = _getPlayerNameR(player)
				for i, v in ipairs(Element.getAllByType("player")) do
					if Administradores[getACLFromPlayer(v)] == true then
						v:outputChat("#1A6200((Chat-STAFF)) #4E54D8"..nick..": #FFFFFF"..msg, 255, 255, 255, true)
					end
				end
				if (not Administradores[player]) then
					Administradores[player] = {}
				end
				Administradores[player][1] = getTickCount()
			end
		end
	end
end
addCommandHandler("sa", chatAdministrativo)