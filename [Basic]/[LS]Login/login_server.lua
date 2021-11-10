loadstring(exports.MySQL:getMyCode())()

import('*'):init('MySQL')



local text = textCreateDisplay()

--

local screentext = textCreateTextItem("¡Bienvenido a Life Steal Roleplay!\n\nEste es un servidor roleplay.\n...Por favor, espera mientras el servidor se carga...\nNo tardará mucho.\nUna vez terminado podrás disfrutar de\n cientos de horas de diversión.\nGracias por la espera,\n¡Esperamos que la pases genial!\nBy Sticmy y Claw Suit",0.5,0.2,"medium",255,255,255,255, 2.5, "center", "top", 255)

textDisplayAddText(text,screentext)



addEventHandler("onPlayerJoin", getRootElement(), function()

	textDisplayAddObserver(text, source)

end);



addEvent("removeTextP", true)

function removeTextP()

	textDisplayRemoveObserver(text,source)

end

addEventHandler("removeTextP", root, removeTextP)



local playerid = { }



function LoginPlayer( user, pass )

	local acc = Account(user, pass)

	if acc ~= false then

		source:setName(user)

		setTimer(logIn, 500, 1, source, acc, pass)

		exports["[LS]Gamemode"]:addhudPlayer(source)

		setTimer(function(source)

			if isElement(source) then

				clearChatBox(source)

				source:outputChat("#DDFFDD¡Bienvenido nuevamente a Life Steal Roleplay!", 255, 255, 255, true)

				source:outputChat("#DDFFDDSi eres nuevo en el servidor te recomendamos usar #00DD00/empezar", 255, 255, 255, true)

			end

		end, 1000, 1, source)

		--

		setTimer(function(source)

			if isElement(source) then

				clearChatBox(source)

				source:outputChat("#DDFFDD=== Life Steal Roleplay V:1.0 ===", 255, 255, 255, true)

				source:outputChat("#DDFFDDFacebook: #0116FCLife Steal Roleplay", 255, 255, 255, true)

				source:outputChat("#DDFFDDDiscord: #4756F9https://discord.gg/9dWrZ3D", 255, 255, 255, true)

				source:outputChat("#DDFFDDYoutube: #FF0033Life Steal Roleplay Oficial", 255, 255, 255, true)

			end

		end, 15000, 1, source)



		triggerClientEvent(source, "detenerTransicion", source)

		setTimer(triggerClientEvent, 500, 1, source, "Roleplay:DestroyLogin", source)

		showCursor( source, false)



		local s = query("SELECT * FROM datos_personajes where Cuenta = ?", user)

		if not ( type( s ) == "table" and #s == 0 ) or not s then

			local sexo = s[1]["Sexo"]

			if sexo == "Femenino" then

				source:setWalkingStyle(132)

			else

				source:setWalkingStyle(128)

			end

			local test = s[1]["TestRoleplay"]

			if test == "No" then

				setTimer(triggerClientEvent, 1000, 1, source, "setVisibleTestRol", source)

			end

		else

			source:setWalkingStyle(128)

		end



	else

		source:triggerEvent("Roleplay:ErrorLogin", source)

		source:triggerEvent("callNotification", source, "error", "Por favor, escriba bien sus datos.", true)

	end

end

addEvent("Roleplay:LoginPlayer", true)

addEventHandler("Roleplay:LoginPlayer", root, LoginPlayer)



function RegisterPlayer(user, pass)

	local maximo = query("SELECT * FROM save_system where Serial = ?", source:getSerial())

	local accc = Account.add (user, pass)

	if accc then

		if #maximo == 3 then

			source:triggerEvent("Roleplay:ErrorLogin", source)

		else

			local ip = source:getIP()

			local serial = source:getSerial()

			local f = getRealTime()

			insert("insert into `registros` VALUES (?,?,?,?,?)", user, pass, serial, ip, f.monthday.."/"..f.month+1 .."/"..f.year-100)

			source:triggerEvent("callNotification", source, "info", "Acabas de ser registrado, ahora logea.", true)

		end

	else

		source:triggerEvent("Roleplay:ErrorLogin", source)

		source:triggerEvent("callNotification", source, "error", "Por favor, escriba bien sus datos.", true)

	end

end

addEvent("Roleplay:RegisterPlayer", true)

addEventHandler("Roleplay:RegisterPlayer", root, RegisterPlayer)



addCommandHandler("fixcamera", function(source)

	source:fadeCamera(true, 0.5)

	source:setCameraTarget(source)

end)



addEventHandler("onPlayerJoin", getRootElement(), function()

	newPlayerID( source )

end)

function newPlayerID( player )

	for ID = 1,1000 do
		
		if not getPlayerByID(ID) then

			player:setData('ID',ID)
			break

		end

	end

end


function getPlayerByID(ID)
	for i,who in ipairs(Element.getAllByType('player')) do
		
		local reID = who:getData('ID') or 0

		if reID then

			if reID == ID then

				return who

			end
		end
	end
	return false
end

--[[function newPlayerID( player )

	for i = 1, getMaxPlayers( ) do

		if not ( playerid[ i ] ) then

			playerid[ i ] = player

			player:setData( "ID", i )

			break

		end

	end

end

function getPlayerByID( id )

	for i = 1, getMaxPlayers( ) do

		if ( playerid[ i ] ) then

			print( getPlayerName( playerid[ i ] ) )

			return playerid[ i ]

		end

	end

end



addEventHandler( "onPlayerQuit", root,

	function( )

		for i = 1, getMaxPlayers() do

			if ( playerid[ i ] == source ) then

				playerid[ i ] = nil

				break

			end

		end

	end

)]]