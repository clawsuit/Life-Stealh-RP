local antiSpam  = {} 
mysql = exports.MySQL
Animaciones = {"prtial_gngtlkA", "prtial_gngtlkB", "prtial_gngtlkC", "prtial_gngtlkD", "prtial_gngtlkE", "prtial_gngtlkF", "prtial_gngtlkG", "prtial_gngtlkG"}

addEventHandler("onPlayerChat", root, function( message, _type )
	cancelEvent()
	if not source:getAccount():isGuest () then
		if (source:isMuted()) then
			source:outputChat("No puedes escribir, estás muteado.. ", 150, 0, 0)
		return
		end
		local tick = getTickCount()
		if (antiSpam[source] and antiSpam[source][1] and tick - antiSpam[source][1] < 500) then
			--source:outputChat(" [ Argentina Roleplay ]: Espera 2 segundos para enviar un mensaje.. ", 150, 0, 0)
			return
		end
		if _type == 0 then
			if message ~= "" and message ~= " " and message:len() >= 1 then
				local pos = Vector3(source:getPosition())
				local x, y, z = pos.x, pos.y, pos.z
				local nick = _getPlayerNameR( source )
				local message2 = trunklateText( source, message )
				chatCol = ColShape.Sphere(x, y, z, 20)
				nearPlayers = chatCol:getElementsWithin("player") 
				--outputConsole("[Ingles] "..nick.." dice: "..message.."")
				outputDebugString("["..(source:getData("Roleplay:Idioma") or "Ingles").."] "..nick.." dice: "..message2.."", 0, 221, 250, 255)
				local preFind = message2:find("-")
				message3 = message2
				if preFind then
					local posFind = message2:find('-', preFind+1)
					if posFind ~= nil then 
						local color = string.format("#%.2X%.2X%.2X", 221, 250, 255)
						message3 = tostring(message2:sub(1,preFind).."#FF00D8"..message2:sub(preFind+1,posFind-1)..color..message2:sub(posFind,message2:len()))
					end
				end
				source:setData("TextInfo", {"dice: "..message3, 221, 250, 255})
				setTimer(function(p)
					if isElement(p) then
						p:setData("TextInfo", {"", 255, 0, 216})
					end
				end, 8000, 1, source)

				for _,v in ipairs(nearPlayers) do
					v:outputChat("#FCFFD8["..(source:getData("Roleplay:Idioma") or "Ingles").."] "..nick.." dice: #FFFFFF"..message3.."", 221, 250, 255, true)
				end
				if not source:isInVehicle() then 
					if not source:getData("NoDamageKill") == true then
						if exports["[LS]Facciones"]:getTaserCables(source) == false then
							if source:getData("animPlayer") == false then
								source:setAnimation ( "GANGS", Animaciones[math.random(1, #Animaciones)], 1, false,false)
							end
						end
					end
				end
				if (not antiSpam[source]) then
					antiSpam[source] = {}
				end
				antiSpam[source][1] = getTickCount()
				if isElement( chatCol ) then
					destroyElement( chatCol )
				end
			else
				source:outputChat("Debes escribir más de 1 carácteres.", 150, 0, 0)
			end
		end
		if _type == 1 then
			if message ~= "" and message ~= " " and message:len() >= 1 then
				local pos = Vector3(source:getPosition())
				local x, y, z = pos.x, pos.y, pos.z
				local nick = _getPlayerNameR( source )
				local message2 = trunklateText( source, message )
				chatCol = ColShape.Sphere(x, y, z, 20)
				nearPlayers = chatCol:getElementsWithin("player") 
				outputDebugString("* "..message2.." (("..nick.."))", 0, 215, 122, 8)
				for _,v in ipairs(nearPlayers) do
					v:outputChat("#FF00D8 *"..nick.." "..message2.."", 215, 122, 8, true)
				end
				if (not antiSpam[source]) then
					antiSpam[source] = {}
				end
				antiSpam[source][1] = getTickCount()
				if isElement( chatCol ) then
					destroyElement( chatCol )
				end
			else
				source:outputChat("Debes escribir más de 1 carácteres.", 150, 0, 0)
			end
		end
	end
end)

local antiSpamSusurro = {}

function chatSUSURRO( source, cmd, ... )
	if not source:getAccount():isGuest () then
		if (source:isMuted()) then
		return
		end
		local tick = getTickCount()
		if (antiSpamSusurro[source] and antiSpamSusurro[source][1] and tick - antiSpamSusurro[source][1] < 500) then
			--source:outputChat(" [ Argentina Roleplay ]: Espera 2 segundos para enviar un mensaje.. ", 150, 0, 0)
			return
		end
		local message = table.concat({...}, " ")
		if message ~= "" and message ~= " " and message:len() >= 3 then
			local pos = Vector3(source:getPosition())
			local x, y, z = pos.x, pos.y, pos.z
			local nick = _getPlayerNameR( source )
			local cuenta = source:getAccount():getName()
			local message2 = trunklateText( source, message )
			chatCol = ColShape.Sphere(x, y, z, 2)
			nearPlayers = chatCol:getElementsWithin("player") 
			outputDebugString(""..nick.." susurra: "..message2.."", 0, 165, 242, 255)
			for _,v in ipairs(nearPlayers) do
				v:outputChat("#EDEEE1["..(source:getData("Roleplay:Idioma") or "Ingles").."] "..nick.." susurra: "..message2.."", 165, 242, 255, true)
			end
			if (not antiSpamSusurro[source]) then
				antiSpamSusurro[source] = {}
			end
			antiSpamSusurro[source][1] = getTickCount()
			if isElement( chatCol ) then
				destroyElement( chatCol )
			end
		else
			source:outputChat("Debes escribir más de 1 carácteres.", 150, 0, 0)
		end
	end
end
addCommandHandler({"s", "susurro"}, chatSUSURRO)

local antiSpamAme = {}
function chatAme(source, cmd, ...)
	if not source:getAccount():isGuest () then
		if (source:isMuted()) then
		return
		end
		local tick = getTickCount()
		if (antiSpamAme[source] and antiSpamAme[source][1] and tick - antiSpamAme[source][1] < 500) then
			return
		end
		local message = table.concat({...}, " ")
		if message ~= "" and message ~= " " and message:len() >= 1 then
			local pos = Vector3(source:getPosition())
			local x, y, z = pos.x, pos.y, pos.z
			local nick = _getPlayerNameR( source )
			local cuenta = source:getAccount():getName()
			local message2 = trunklateText( source, message )
			chatCol = ColShape.Sphere(x, y, z, 2)
			nearPlayers = chatCol:getElementsWithin("player") 
			source:outputChat("#FF00D8> "..message2.."", 165, 242, 255, true)
			source:setData("TextInfo", {"> "..message2, 255, 0, 216})
			setTimer(function(source)
				if isElement(source) then
				source:setData("TextInfo", {"", 255, 0, 216})
			end
			end, 5000, 1, source)
			if (not antiSpamAme[source]) then
				antiSpamAme[source] = {}
			end
			antiSpamAme[source][1] = getTickCount()
			if isElement( chatCol ) then
				destroyElement( chatCol )
			end
		else
			source:outputChat("Debes escribir más de 1 carácteres.", 150, 0, 0)
		end
	end
end
addCommandHandler({"ame"}, chatAme)

function chatGlobal( source, cmd, ... )
	if not source:getAccount():isGuest () then
		local cuenta = source:getAccount():getName()
		if isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Admin" ) ) or isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "SuperModerador" ) ) or isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Moderador" ) ) then
			local tick = getTickCount()
			if (antiSpam[source] and antiSpam[source][1] and tick - antiSpam[source][1] < 500) then
				--source:outputChat(" [ Argentina Roleplay ]: Espera 2 segundos para enviar un mensaje.. ", 150, 0, 0)
				return
			end
			local message = table.concat({...}, " ")
			if message ~= "" and message ~= " " and message:len() >= 3 then
				local pos = Vector3(source:getPosition())
				local x, y, z = pos.x, pos.y, pos.z
				local nick = _getPlayerNameR( source )
				local cuenta = source:getAccount():getName()
				local message2 = trunklateText( source, message )
				outputDebugString(""..nick..": "..message2.."", 0, 165, 242, 255)
				if isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Admin" ) ) then
					tipo = " [#ee0000Admin#A5F2FF]"
				elseif isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "SuperModerador" ) ) then
					tipo = " [#ee0000SuperMod#A5F2FF]"
				elseif isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Moderador" ) ) then
					tipo = " [#ee0000Mod#A5F2FF]"
				else
					tipo = ""
				end
				for _,v in ipairs(Element.getAllByType("player")) do
					v:outputChat("((GLOBAL)) "..nick..": #A5F2FF"..message2.."", 165, 242, 255, true)
				end
				if (not antiSpam[source]) then
					antiSpam[source] = {}
				end
				antiSpam[source][1] = getTickCount()
			else
				source:outputChat("Debes escribir más de 1 carácteres.", 150, 0, 0)
			end
		end
	end
end
addCommandHandler({"o", "global"}, chatGlobal)

function trunklateText(thePlayer, text, factor)
    local msg = (tostring(text):gsub("%u", string.lower))
	return (tostring(msg):gsub("^%l", string.upper))
end
