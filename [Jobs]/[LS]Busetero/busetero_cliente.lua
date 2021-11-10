local sx_, sy_ = guiGetScreenSize()
local sx, sy = sx_/1360, sy_/768

local ValoresTrabajo = {}
local PosicionAuto = {}
local MarcadoresRuta = {}
local BlipsRuta = {}
local PedsRuta = {}
local TimerK = {}
local tableN = {}

function getSkinsRandom()
	local allSkins = getValidPedModels ( )
	local result = false
	local random = math.random(1, #allSkins)
	for key, skin in ipairs(allSkins) do
		if skin == tonumber(random) then
			result = skin
			break
		end
	end
	if (result) then
		return result
	else
		return 0
	end
end

function startRutaBusetero(tip, ruta)
	if localPlayer:getData("Roleplay:trabajo") == "Busetero" then
		if tip == "LS" then
			if ruta == 1 then
				ValoresTrabajo[localPlayer][1] = tonumber(#MarkerMissionBusetero)
				ValoresTrabajo[localPlayer][4] = tonumber(ruta)
				for i=1, #MarkerMissionBusetero do
					if i >= ValoresTrabajo[localPlayer][2] and i <= ValoresTrabajo[localPlayer][2] then
						local x, y, z = MarkerMissionBusetero[i][1], MarkerMissionBusetero[i][2], MarkerMissionBusetero[i][3]
						local x2, y2, z2 = MarkerMissionBusetero[i][4], MarkerMissionBusetero[i][5], MarkerMissionBusetero[i][6]
						MarcadoresRuta[i] = Marker(x, y, z - 1, "checkpoint", 3, 255, 255, 0, 100)
						BlipsRuta[i] = createBlipAttachedTo(MarcadoresRuta[i], 0, 2, 50, 150, 50, 255)
						--
						if i >= 2 and i <= 13 then
							for _, peds in ipairs(MarkerMissionBusetero[i].Peds) do
								--
								local skinID = getSkinsRandom()
								PedsRuta[i] = Ped(skinID, peds[2], peds[3], peds[4], peds[7])
								PedsRuta[i]:setFrozen(true)
								--
								if isElement(PedsRuta[i]) then
									addEventHandler("onClientPedDamage", PedsRuta[i], function()
										cancelEvent()
									end)
								end
							end
						end
						--
						if i <= 13 then
							setMarkerTarget(MarcadoresRuta[i], x2, y2, z2)
							setMarkerIcon ( MarcadoresRuta[i], "arrow" )
						else
							setMarkerIcon ( MarcadoresRuta[i], "finish" )
						end
						--
						addEventHandler("onClientMarkerHit", MarcadoresRuta[i], onBuseteroHitMarker)
					end
				end
			end
			if ruta == 2 then
				ValoresTrabajo[localPlayer][1] = tonumber(#MarkerMissionBusetero2)
				ValoresTrabajo[localPlayer][4] = 2
				for i=1, #MarkerMissionBusetero2 do
					if i >= ValoresTrabajo[localPlayer][2] and i <= ValoresTrabajo[localPlayer][2] then
						local x, y, z = MarkerMissionBusetero2[i][1], MarkerMissionBusetero2[i][2], MarkerMissionBusetero2[i][3]
						local x2, y2, z2 = MarkerMissionBusetero2[i][4], MarkerMissionBusetero2[i][5], MarkerMissionBusetero2[i][6]
						MarcadoresRuta[i] = Marker(x, y, z - 1, "checkpoint", 3, 255, 255, 0, 100)
						BlipsRuta[i] = createBlipAttachedTo(MarcadoresRuta[i], 0, 2, 50, 150, 50, 255)
						--
						if i >= 2 and i <= 16 then
							for _, peds in ipairs(MarkerMissionBusetero2[i].Peds) do
								local skinID = getSkinsRandom()
								--
								PedsRuta[i] = Ped(skinID, peds[2], peds[3], peds[4], peds[7])
								PedsRuta[i]:setFrozen(true)
								--
								if isElement(PedsRuta[i]) then
									addEventHandler("onClientPedDamage", PedsRuta[i], function()
										cancelEvent()
									end)
								end
							end
						end
						--
						if i <= 16 then
							setMarkerTarget(MarcadoresRuta[i], x2, y2, z2)
							setMarkerIcon ( MarcadoresRuta[i], "arrow" )
						else
							setMarkerIcon ( MarcadoresRuta[i], "finish" )
						end
						--
						addEventHandler("onClientMarkerHit", MarcadoresRuta[i], onBuseteroHitMarker)
					end
				end
			end
		end
	end
end

function onBuseteroHitMarker( hitElement )
	if isElement(hitElement) and hitElement:getType() == "player" and hitElement == localPlayer then
		if hitElement:isInVehicle() then
			if hitElement:getData("Roleplay:trabajo") == "Busetero" and ValoresTrabajo[hitElement][3] == true then
				local veh = hitElement:getOccupiedVehicle()
				local seat = hitElement:getOccupiedVehicleSeat()
				if veh:getModel() == 431 and seat == 0 and veh:getData("VehiculoPublico") == "Busetero" then
					if ValoresTrabajo[hitElement][1] ==ValoresTrabajo[hitElement][2] then
						destroyMarkersBusetero()
						--
						local x, y, z, x2, y2, z2 = unpack(PosicionAuto[1])
						veh:setPosition(x, y, z)
						veh:setRotation(x2, y2, z2)
						veh:setLocked(true)
						veh:setFrozen(true)
						veh:setData("Motor", "apagado")
						veh:setEngineState(false)
						table.remove(PosicionAuto, 1)
						outputChatBox("Si deseas trabajar, vuelve a subir al bus.", 50, 150, 50, true)
						--
						ValoresTrabajo[hitElement] = nil;
						TimerK[hitElement] = nil;
						tableN[hitElement] = nil;
						hitElement:setControlState("enter_exit", true)
						setTimer(function(hitElement)
							if isElement(hitElement) then
								hitElement:setControlState("enter_exit", false)
							end
						end, 1000, 1, hitElement)
					else
						if ValoresTrabajo[hitElement][2] >= 2 then
							veh:setFrozen(true)
							fadeCamera(false)
							local time = math.random(1,3)
							triggerEvent("callCinematic", hitElement, "Subiendo pasajeros..", time*1000, "No")
							setTimer(function(veh, hitElement)
								if isElement(veh) then
									veh:setFrozen(false)
									fadeCamera(true)
									--
									triggerServerEvent( "giveMoneyBusetero", hitElement )
								end
								--
							end, time*1000, 1, veh, hitElement)
						end
						ValoresTrabajo[hitElement][2] = ValoresTrabajo[hitElement][2] + 1
						setTimer(startRutaBusetero, 50, 1, "LS", ValoresTrabajo[hitElement][4])
						destroyMarkerRut(hitElement, ValoresTrabajo[hitElement][4])
					end
				end 
			end
		end
	end
end

function destroyMarkerRut(player, rut)
	if rut == 1 then
		for i=1, #MarkerMissionBusetero do
			if i <= ValoresTrabajo[player][2] then
				if isElement(MarcadoresRuta[i]) then
					destroyElement(MarcadoresRuta[i])
					MarcadoresRuta[i] = nil
				end
				if isElement(BlipsRuta[i]) then
					destroyElement(BlipsRuta[i])
					BlipsRuta[i] = nil
				end
				if isElement(PedsRuta[i]) then
					destroyElement(PedsRuta[i])
					PedsRuta[i] = nil
				end
			end
		end
	end
	if rut == 2 then
		for i=1, #MarkerMissionBusetero2 do
			if i <= ValoresTrabajo[player][2] then
				if isElement(MarcadoresRuta[i]) then
					destroyElement(MarcadoresRuta[i])
					MarcadoresRuta[i] = nil
				end
				if isElement(BlipsRuta[i]) then
					destroyElement(BlipsRuta[i])
					BlipsRuta[i] = nil
				end
				if isElement(PedsRuta[i]) then
					destroyElement(PedsRuta[i])
					PedsRuta[i] = nil
				end
			end
		end
	end
end

addEventHandler("onClientVehicleExit", getRootElement(),
	function(thePlayer, seat)
        if thePlayer == getLocalPlayer() then
        	if seat == 0 then
        		if source:getModel() == 431 and source:getData("VehiculoPublico") == "Busetero" then
        			if thePlayer:getData("Roleplay:trabajo") == "Busetero" then
        				if ValoresTrabajo[thePlayer] then
        					if ValoresTrabajo[thePlayer][3] == true then
        						outputChatBox("Tienes 30 segundos para subir al vehículo o se cancelara la misión.", 150, 50, 50, true)
        						failedMissionBusetero("LS", thePlayer, source, 30)
        					end
        				end
        			end
        		end
        	end
        end
	end
)

addEventHandler("onClientVehicleEnter", getRootElement(),
	function(thePlayer, seat)
		if thePlayer == getLocalPlayer() then
			if seat == 0 then
				if source:getModel() == 431 and source:getData("VehiculoPublico") == "Busetero" then
					if thePlayer:getData("Roleplay:trabajo") == "Busetero" then
						if tableN[thePlayer] == true then
        					if isTimer(TimerK[thePlayer]) then
        						killTimer(TimerK[thePlayer])
								TimerK[thePlayer] = nil;
								tableN[thePlayer] = nil;
        						outputChatBox("¡Perfecto sigue con la misión!", 50, 150, 50, true)
        					end
						end
						if ValoresTrabajo[thePlayer] then else
							local random = math.random(1, 2)
							ValoresTrabajo[thePlayer] = {nil, 1, true, random}
							startRutaBusetero("LS", random)
	        				local x, y, z = getElementPosition(source)
	        				local x2, y2, z2 = getElementRotation(source)
	        				table.insert(PosicionAuto, {x, y, z, x2, y2, z2})
	        				triggerEvent("callCinematic", thePlayer, "Conduce por los #FFFF00marcadores #ffffffintenta no ir tan rápido", 20000, "No")
						end
					end
				end
			end
		end
	end
)

addEvent("iniciarRutaBusetero", true)
function iniciarRutaBusetero()
	destroyMarkersBusetero()
end
addEventHandler("iniciarRutaBusetero", root, iniciarRutaBusetero)

addEventHandler("onClientPlayerQuit", getRootElement(), function()
	destroyMarkersBusetero()
	ValoresTrabajo[source] = {nil, 1, false, 1}
	--
	TimerK[source] = nil;
	tableN[source] = nil;
	--
	table.remove(PosicionAuto, 1)
end)

addEvent("failedMissionBus", true)
function failedMissionBus()
	destroyMarkersBusetero()
	--
	TimerK[localPlayer] = nil;
	tableN[localPlayer] = nil;
	--
	table.remove(PosicionAuto, 1)
end
addEventHandler("failedMissionBus", root, failedMissionBus)

function failedMissionBusetero(tip, thePlayer, vehiculo, timer)
	if tip == "LS" then
		tableN[thePlayer] = true
		TimerK[thePlayer] = setTimer(function(p, veh)
			if isElement(p) and isElement(veh) then
				p:setData("Roleplay:trabajo", "")
				destroyMarkersBusetero()
				ValoresTrabajo[p] = {nil, 1, false, 1}
				if veh and veh ~= nil then
					local x, y, z, x2, y2, z2 = unpack(PosicionAuto[1])
					veh:setPosition(x, y, z)
					veh:setRotation(x2, y2, z2)
					veh:setLocked(true)
					veh:setFrozen(true)
					veh:setEngineState(false)
				end
				--
				TimerK[p] = nil;
				tableN[p] = nil;
				--
				table.remove(PosicionAuto, 1)
			end
		end, timer*1000, 1, thePlayer, vehiculo)
	end
end

function destroyMarkersBusetero()
	for i=1, #MarkerMissionBusetero do
		if isElement(MarcadoresRuta[i]) then
			destroyElement(MarcadoresRuta[i])
			MarcadoresRuta[i] = nil
		end
		if isElement(BlipsRuta[i]) then
			destroyElement(BlipsRuta[i])
			BlipsRuta[i] = nil
		end
		if isElement(PedsRuta[i]) then
			destroyElement(PedsRuta[i])
			PedsRuta[i] = nil
		end
	end
	for i=1, #MarkerMissionBusetero2 do
		if isElement(MarcadoresRuta[i]) then
			destroyElement(MarcadoresRuta[i])
			MarcadoresRuta[i] = nil
		end
		if isElement(BlipsRuta[i]) then
			destroyElement(BlipsRuta[i])
			BlipsRuta[i] = nil
		end
		if isElement(PedsRuta[i]) then
			destroyElement(PedsRuta[i])
			PedsRuta[i] = nil
		end
	end
end

--
addEventHandler("onClientRender", getRootElement(), function()
	--
	local playerX2, playerY2, playerZ2 = getElementPosition ( localPlayer )
	for k, v in pairs(getJobsBusetero()) do
		local playerX, playerY, playerZ = v[1], v[2], v[3]
		local sx, sy = getScreenFromWorldPosition(playerX, playerY, playerZ + 0.5)
		if sx and sy then
			local cx, cy, cz = getCameraMatrix()
			local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX, playerY, playerZ + 0.5)
			if distance < 20 then
				dxDrawBorderedText3 ( v[4], sx, sy, sx, sy , tocolor (0, 255, 0, 255 ),1, "default-bold","center", "center" ) 
			end
		end
	end
end)

function dxDrawBorderedText3( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end