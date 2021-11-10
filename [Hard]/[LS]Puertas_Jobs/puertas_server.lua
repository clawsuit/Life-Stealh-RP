local markerAssociates = {}
local antiSpamCom = {}
local faction = {}

function createDoors()
	for m1, m2 in ipairs(markerAssociates) do
		destroyElement(m2)
	end
	markerAssociates = {}
	for index, v in ipairs(getDoors()) do
		if (v[1] and v[2] and v[3]) then
			-- marcador
			local markerTbl = v[1]
			entryMarker = Marker(markerTbl.pos[1], markerTbl.pos[2], markerTbl.pos[3]-1, "cylinder", 1.2, 255, 255, 0, 0)
			if (markerTbl.int and markerTbl.int ~=0) then
				entryMarker:setInterior(markerTbl.int)
			end
			if (markerTbl.dim and markerTbl.dim ~=0) then
				entryMarker:setDimension(markerTbl.dim)
			end
			-- object
			local objectTbl = v[2]
			entryObject = Object(objectTbl.id, objectTbl.pos[1], objectTbl.pos[2], objectTbl.pos[3], objectTbl.rot[1], objectTbl.rot[2], objectTbl.rot[3], false)
			if (objectTbl.int and objectTbl.int ~=0) then
				entryObject:setInterior(objectTbl.int)
			end
			if (objectTbl.dim and objectTbl.dim ~=0) then
				entryObject:setDimension(objectTbl.dim)
			end
			-- salida
			local salidaTbl = v[3]
			exitMarker = Marker(salidaTbl.pos[1], salidaTbl.pos[2], salidaTbl.pos[3]-1, "cylinder", 1.2, 255, 0, 0, 0)
			if (salidaTbl.int and salidaTbl.int ~=0) then
				exitMarker:setInterior(salidaTbl.int)
			end
			if (salidaTbl.dim and salidaTbl.dim ~=0) then
				exitMarker:setDimension(salidaTbl.dim)
			end
			--
			markerAssociates[entryMarker] = entryObject
			markerAssociates[entryObject] = entryMarker
			entryMarker:setData("Object_Doors", entryObject)
			entryMarker:setData("Marker_Not", exitMarker)
			exitMarker:setData("Marker_Not", entryMarker)
			faction[entryMarker] = markerTbl.job
			faction[exitMarker] = salidaTbl.job
			entryObject:setData("Object_move", {objectTbl.pos[1], objectTbl.pos[2], objectTbl.pos[3], objectTbl.move[1], objectTbl.move[2], objectTbl.move[3]})
			--
			exitMarker:setData("Object_Doors", entryObject)
			--
			antiSpamCom[entryMarker] = true
			antiSpamCom[exitMarker] = true
			--
			addEventHandler("onMarkerHit", entryMarker, bindJugador)
			--
			addEventHandler("onMarkerHit", exitMarker, bindJugador)
			--
			addEventHandler("onMarkerLeave", entryMarker, unbindJugador)
		end
	end
end

addEventHandler("onResourceStart", resourceRoot, createDoors)

local Valors = {}
local ChatBoxSpam = {}
local antiSpamxD = {}

addEventHandler("onPlayerJoin", getRootElement(), function()
	antiSpamCom[source] = false
end)

function openDoors( p )
	local s = Valors[p][1]:getData("Object_move")
	local x, y, z = s[1], s[2], s[3]
	local x2, y2, z2 = s[4], s[5], s[6]
	Valors[p][1]:move(3000, x2, y2, z2, 0, 0, 0, "OutQuad")
	antiSpamCom[Valors[p][2]] = false
	antiSpamCom[Valors[p][3]] = false
	p:setAnimation("VENDING", "VEND_Use",false,false,false,true)
	setTimer(function(p)
		setPedAnimation(p, false)
	end, 1000, 1, p)
	setTimer(function(p)
		antiSpamCom[p] = false
	end, 5000, 1, p)
	local tick = getTickCount()
	if (ChatBoxSpam[p] and ChatBoxSpam[p][1] and tick - ChatBoxSpam[p][1] < 3000) then
		return
	end
	MensajeRoleplay(p, "abrio al puerta con su tarjeta de acceso", 215, 122, 8)
	if (not ChatBoxSpam[p]) then
		ChatBoxSpam[p] = {}
	end
	ChatBoxSpam[p][1] = getTickCount()
	setTimer(
		function(xd, x, y, z)
		xd[1]:move(3000, x, y, z, 0, 0, 0, "OutQuad")
		end, 2000, 1,
	Valors[p], x, y, z)

	setTimer(function(xd)
		antiSpamCom[xd[2]] = true
		antiSpamCom[xd[3]] = true
	end, 5000, 1, Valors[p])
	--
	unbindKey(p, "F", "down", openDoors)
end

function bindJugador( player, dim )
	if isElement(player) and player:getType() == "player" then
		if not player:isInVehicle() or player:doesHaveJetpack() then 
			if player:getData("Roleplay:faccion") == tostring(faction[source]) then
				if antiSpamCom[player] == true then else
					antiSpamCom[player] = true
					if antiSpamCom[source] == true then
						--
						Valors[player] = {source:getData("Object_Doors"), source, source:getData("Marker_Not")}
						--
						bindKey(player, "F", "down", openDoors)
					end
				end
			end
		end
	end
end

function MensajeRoleplay( player, texto, r, g, b )
	local pos = Vector3(player:getPosition())
	local x, y, z = pos.x, pos.y, pos.z
	local chatCol = ColShape.Sphere(x, y, z, 10)
	local nearPlayers = chatCol:getElementsWithin("player")
	for index, v in ipairs(nearPlayers) do
		v:outputChat("* "..player:getName().." "..(texto or ""), (r or 255), (g or 255), (b or 255))
	end
	if isElement(chatCol) then
		destroyElement(chatCol)
	end
end

function unbindJugador( player, dim )
	if isElement(player) and player:getType() == "player" then
		if not player:isInVehicle() or player:doesHaveJetpack() then 
			unbindKey(player, "F", "down", openDoors)
		end
	end
end