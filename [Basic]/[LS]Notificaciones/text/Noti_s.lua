function setTextNoti(players, text, r,g,b)

	if players and text then

		local color = '#'..string.format("%02X%02X%02X", (r or 255), (g or 255), (b or 255))

		if type(players) == 'table' then

			for k,p in pairs(players) do

				triggerClientEvent( p, 'addTextNoti', p, color..text)

			end

			return true

		end

		triggerClientEvent( players, 'addTextNoti', players, color..text)

		return true

	end

	return error('Un argumento de setTextNoti, es incorrecto', 2)

end
