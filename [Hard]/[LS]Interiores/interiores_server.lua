local colAssociates = {}
local colRestrictions = {}

local intEntry = {}
local intSound = {}

addEvent("onInteriorEnter", true)
addEvent("onInteriorExit", true)

local antiSpamCommand = {}

function createInteriorMarkers(resource)
	for m1,m2 in pairs(colAssociates) do
		destroyElement(m2)
	end
	colAssociates = {}
	colRestrictions = {}
	for i,v in ipairs(getInteriors()) do
		if (v[1] and v[2]) then
			-- entrada
			local intTbl = v[1]
			if ( intTbl.blip) then
				Blip( intTbl.pos[1], intTbl.pos[2], intTbl.pos[3], intTbl.blip, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
			end
 			local entryPickup = Pickup(intTbl.pos[1], intTbl.pos[2], intTbl.pos[3], 3, 1318, 0)
			setElementData(entryPickup, "pickup.info", intTbl.refid)
			local entryCol = ColShape.Sphere(intTbl.pos[1], intTbl.pos[2], intTbl.pos[3], 1.5)
			-- set Interior
			if (intTbl.int and intTbl.int ~= 0) then
				setElementInterior(entryPickup, intTbl.int)
				setElementInterior(entryCol, intTbl.int)
			end
			-- Set Dimension
			if (intTbl.dim and intTbl.dim ~= 0) then
				setElementDimension(entryPickup, intTbl.dim)
				setElementDimension(entryCol, intTbl.dim)
			end
			setElementData(entryCol, "rot", intTbl.rot or 0, false)
			setElementData(entryPickup, "pickup.interior", true)
			if (intTbl.res) then
				colRestrictions[entryCol] = intTbl.res
			end
			-- salida
			local intTbl = v[2]
			local returnPickup = Pickup(intTbl.pos[1], intTbl.pos[2], intTbl.pos[3], 3, 1318, 0)
			local returnCol = ColShape.Sphere(intTbl.pos[1], intTbl.pos[2], intTbl.pos[3], 1.5)
			-- set Interior
			if (intTbl.int and intTbl.int ~= 0) then
				setElementInterior(returnPickup, intTbl.int)
				setElementInterior(returnCol, intTbl.int)
			end
			-- Set Dimension
			if (intTbl.dim and intTbl.dim ~= 0) then
				setElementDimension(returnPickup, intTbl.dim)
				setElementDimension(returnCol, intTbl.dim)
			end
			setElementData(returnPickup, "pickup.info", intTbl.id)
			setElementData(returnPickup, "pickup.interior", true)
			setElementData(returnCol, "rot", intTbl.rot or 0, false)
			if (intTbl.res) then
				colRestrictions[returnCol] = intTbl.res
			end
			-- Events
			addEventHandler("onColShapeHit", entryCol, bindPlayerF)
			addEventHandler("onColShapeLeave", entryCol, unbindPlayerF)
			addEventHandler("onColShapeHit", returnCol, bindPlayerF)
			addEventHandler("onColShapeLeave", returnCol, unbindPlayerF)
			-- Associations
			colAssociates[entryCol] = returnCol
			colAssociates[returnCol] = entryCol
			-- Entry v. Return
			intEntry[entryCol] = true
		end
	end
end
addEventHandler("onResourceStart", resourceRoot, createInteriorMarkers)

addEventHandler("onPlayerJoin", getRootElement(), function()
	antiSpamCommand[source] = false
end)

function bindPlayerF( player, dim )
	if (not isElement(player) or getElementType(player) ~= "player" or isPedInVehicle(player) or not dim or doesPedHaveJetPack(player)) then return end
	if antiSpamCommand[player] == true then
	else
		antiSpamCommand[player] = true
		setTimer( function() 
			if antiSpamCommand[player] == true then
				antiSpamCommand[player] = false
			end
		end, 5000, 1 )
		bindKey(player, "F", "down", warpBetweenInteriors)
		player:setData("ColDats", source)
	end
end

function unbindPlayerF( player, dim )
	if (not isElement(player) or getElementType(player) ~= "player" or isPedInVehicle(player) or not dim or doesPedHaveJetPack(player)) then return end
	unbindKey(player, "F", "down", warpBetweenInteriors)
end

function warpBetweenInteriors( source )
	local cols = source:getData("ColDats")
	local x,y,z = getElementPosition(colAssociates[cols])
	local rot = getElementData(colAssociates[cols], "rot")
	local int = getElementInterior(colAssociates[cols])
	local dim = getElementDimension(colAssociates[cols])
	
	unbindKey(source, "F", "down", warpBetweenInteriors)
	
	if (int ~= 0) then
		local x,y,z = getElementPosition(source)
		source:setData("lastPosition", table.concat({x,y,z}, ","), false)
	else
		removeElementData(source, "lastPosition")
	end
	source:setFrozen(true)
	source:fadeCamera(false, 1.0)
	setTimer( function(source)
	source:fadeCamera(true, 0.8)
	source:setInterior( int )
	source:setFrozen(false)
	source:setDimension( dim )
	source:setRotation( 0, 0, rot, "default", true)
	source:setPosition( x, y, z + 0.2 )
	end, 1500, 1, source )

	if (intEntry[cols]) then
		triggerEvent("onInteriorEnter", cols, source, colAssociates[cols])
		triggerClientEvent(source, "onClientInteriorEnter", cols, source, colAssociates[cols])
	else
		triggerEvent("onInteriorExit", cols, source, colAssociates[cols])
		triggerClientEvent(source, "onClientInteriorExit", cols, source, colAssociates[cols])
	end
end

function getPlayerLastPosition(player)
	if not player or not isElement(player) then return false end

	local position = getElementData(player, "lastPosition")
	if position then
		local x,y,z = unpack( split(position, ",") )
		return tonumber(x), tonumber(y), tonumber(z)
	end

	return false
end

addEventHandler("onPlayerSpawn", root, function()
	removeElementData(source, "lastPosition")
end
)

function isPlayerInTeam(player, team)
    assert(isElement(player) and getElementType(player) == "player", "Bad argument 1 @ isPlayerInTeam [player expected, got " .. tostring(player) .. "]")
    assert((not team) or type(team) == "string" or (isElement(team) and getElementType(team) == "team"), "Bad argument 2 @ isPlayerInTeam [nil/string/team expected, got " .. tostring(team) .. "]")
    return getPlayerTeam(player) == (type(team) == "string" and getTeamFromName(team) or (type(team) == "userdata" and team or (getPlayerTeam(player) or true)))
end