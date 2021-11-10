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



function blockPM(msg,r)

	cancelEvent()

end

addEventHandler("onPlayerPrivateMessage",getRootElement(),blockPM)



function changeNick()

	cancelEvent()

end

addEventHandler("onPlayerChangeNick", getRootElement(), changeNick)



function preventCommandSpam(command)

	if command == "register" then

		cancelEvent()

	elseif command == "login" then

		cancelEvent()

	elseif command == "logout" then

		cancelEvent()

	end

end

addEventHandler("onPlayerCommand", root, preventCommandSpam)



function onLogout ()

	cancelEvent()

end

addEventHandler ("onPlayerLogout", getRootElement(), onLogout)



addEventHandler("onPlayerJoin", getRootElement(), function ( )

	if isElement(source) then

		local nick = removeColorCoding(source:getName())

		source:setTeam(Team.getFromName("Sin logear"))

	end

end)



function removeColorCoding( name )

    return type(name)=='string' and string.gsub ( name, '#%x%x%x%x%x%x', '' ) or name

end



teams = {

{"Jail OOC", 150, 150, 150},

{"Sin logear", 50, 150, 50},

}



addEventHandler("onResourceStart", resourceRoot, function ( )

	for i, v in ipairs(teams) do

		Team.create(v[1], v[2], v[3], v[4])

	end

	setTime ( 5, 52 )

	setMinuteDuration(60000)

	-- time



	setMapName("Roleplay 2.0")

	setGameType("Roleplay 2.0")



	for i=0,49 do

		setGarageOpen( i, true )

	end

	for index, players in ipairs(Element.getAllByType("player")) do

		if not notIsGuest(players) then

			removeColorCoding(players:getName())

		end

	end

end)



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