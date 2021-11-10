addEvent("PasoElRol", true)
addEventHandler("PasoElRol", root, function()
	mysql:update("UPDATE Datos_Personajes SET TestRoleplay = ?  WHERE Cuenta = ?", 'Si', AccountName(source))
end)

addEvent("kickedPlayer", true)
addEventHandler("kickedPlayer", root, function()
	source:outputChat("¡No has pasado el test de Rol!", 150, 50, 50, true)
	setTimer(kickPlayer, 3000, 1, source, "Console", "")
end)