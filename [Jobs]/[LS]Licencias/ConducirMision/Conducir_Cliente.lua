local ValoresTrabajo = {}
local PosicionAuto = {}
local MarcadoresRuta = {}
local BlipsRuta = {}

local RutaConducir1 = {
[1]={1108.5035400391, -1740.6964111328, 13.407667160034, 1171.5179443359, -1740.4997558594, 13.411440849304},
[2]={1171.5179443359, -1740.4997558594, 13.411440849304, 1172.8159179688, -1834.8896484375, 13.405555725098},
[3]={1172.8159179688, -1834.8896484375, 13.405555725098, 1287.8439941406, -1854.8884277344, 13.3828125},
[4]={1287.8439941406, -1854.8884277344, 13.3828125, 1407.3887939453, -1874.8806152344, 13.3828125},
[5]={1407.3887939453, -1874.8806152344, 13.3828125, 1550.9327392578, -1874.7060546875, 13.3828125},
[6]={1550.9327392578, -1874.7060546875, 13.3828125, 1669.7264404297, -1872.8951416016, 13.3828125},
[7]={1669.7264404297, -1872.8951416016, 13.3828125, 1691.5083007813, -1749.9709472656, 13.391266822815},
[8]={1691.5083007813, -1749.9709472656, 13.391266822815, 1804.9528808594, -1734.9898681641, 13.390607833862},
[9]={1804.9528808594, -1734.9898681641, 13.390607833862, 1925.0284423828, -1754.5627441406, 13.3828125},
[10]={1925.0284423828, -1754.5627441406, 13.3828125, 2070.1467285156, -1754.607421875, 13.393966674805},
[11]={2070.1467285156, -1754.607421875, 13.393966674805, 2083.8391113281, -1628.2180175781, 13.3828125},
[12]={2083.8391113281, -1628.2180175781, 13.3828125, 2183.5725097656, -1642.0362548828, 15.13805103302},
[13]={2183.5725097656, -1642.0362548828, 15.13805103302, 2214.6547851563, -1398.8734130859, 23.820301055908},
[14]={2214.6547851563, -1398.8734130859, 23.820301055908, 2127.1345214844, -1381.8659667969, 23.835897445679},
[15]={2127.1345214844, -1381.8659667969, 23.835897445679, 2072.7497558594, -1358.3022460938, 23.828157424927},
[16]={2072.7497558594, -1358.3022460938, 23.828157424927, 2073.2590332031, -1234.6392822266, 23.808801651001},
[17]={2073.2590332031, -1234.6392822266, 23.808801651001, 2072.9428710938, -1149.7758789063, 23.724550247192},
[18]={2072.9428710938, -1149.7758789063, 23.724550247192, 1984.9768066406, -1133.7153320313, 25.7005443573},
[19]={1984.9768066406, -1133.7153320313, 25.7005443573, 1880.974609375, -1133.4760742188, 23.83599281311},
[20]={1880.974609375, -1133.4760742188, 23.83599281311, 1862.4810791016, -1177.5675048828, 23.65625},
[21]={1862.4810791016, -1177.5675048828, 23.65625, 1726.2293701172, -1158.5745849609, 23.643442153931},
[22]={1726.2293701172, -1158.5745849609, 23.643442153931, 1595.6571044922, -1158.7890625, 23.90625},
[23]={1595.6571044922, -1158.7890625, 23.90625, 1495.8928222656, -1158.1086425781, 23.914041519165},
[24]={1495.8928222656, -1158.1086425781, 23.914041519165, 1371.76171875, -1138.5570068359, 23.65625},
[25]={1371.76171875, -1138.5570068359, 23.65625, 1234.4909667969, -1140.1608886719, 23.579660415649},
[26]={1234.4909667969, -1140.1608886719, 23.579660415649, 1098.2569580078, -1140.2509765625, 23.65625},
[27]={1098.2569580078, -1140.2509765625, 23.65625, 1055.8154296875, -1223.1306152344, 16.934436798096},
[28]={1055.8154296875, -1223.1306152344, 16.934436798096, 1056.6147460938, -1305.0887451172, 13.465440750122},
[29]={1056.6147460938, -1305.0887451172, 13.465440750122, 1055.9154052734, -1380.1470947266, 13.474025726318},
[30]={1055.9154052734, -1380.1470947266, 13.474025726318, 933.75958251953, -1398.5170898438, 13.285018920898},
[31]={933.75958251953, -1398.5170898438, 13.285018920898, 915.19830322266, -1474.0841064453, 13.386205673218},
[32]={915.19830322266, -1474.0841064453, 13.386205673218, 915.66412353516, -1557.0681152344, 13.372329711914},
[33]={915.66412353516, -1557.0681152344, 13.372329711914, 1019.3056030273, -1574.8444824219, 13.3828125},
[34]={1019.3056030273, -1574.8444824219, 13.3828125, 1035.4028320313, -1699.4306640625, 13.3828125},
[35]={1035.4028320313, -1699.4306640625, 13.3828125, 1132.2351074219, -1714.4968261719, 13.534241676331},
[36]={1132.2351074219, -1714.4968261719, 13.534241676331, 1171.5179443359, -1740.4997558594, 13.411440849304},
[37]={1171.5179443359, -1740.4997558594, 13.411440849304, 1108.5035400391, -1740.6964111328, 13.407667160034},
[38]={1108.5035400391, -1740.6964111328, 13.407667160034},
}

--[[for i, v in ipairs(RutaConducir1) do
	local x, y, z = RutaConducir1[i][1], RutaConducir1[i][2], RutaConducir1[i][3]
	local x2, y2, z2 = RutaConducir1[i][4], RutaConducir1[i][5], RutaConducir1[i][6]
	mark = Marker(x, y, z - 1, "checkpoint", 3, 255, 255, 0, 100)
	createBlipAttachedTo(mark, 0, 2, 200, 200, 0, 255)
	if i <= 37 then
		setMarkerTarget(mark, x2, y2, z2)
		setMarkerIcon ( mark, "arrow" )
	else
		setMarkerIcon ( mark, "finish" )
	end
end]]

function startMision(tip, ruta)
	if localPlayer:getData("Roleplay:Mision") == "Licencia" then
		if tip == "Conducir" then
			if ruta == 1 then
				ValoresTrabajo[localPlayer][1] = tonumber(#RutaConducir1)
				--
				for i=1, #RutaConducir1 do
					if i >= ValoresTrabajo[localPlayer][2] and i <= ValoresTrabajo[localPlayer][2] then
						local x, y, z = RutaConducir1[i][1], RutaConducir1[i][2], RutaConducir1[i][3]
						local x2, y2, z2 = RutaConducir1[i][4], RutaConducir1[i][5], RutaConducir1[i][6]
						MarcadoresRuta[i] = Marker(x, y, z - 1, "checkpoint", 3, 255, 255, 0, 100)
						BlipsRuta[i] = createBlipAttachedTo(MarcadoresRuta[i], 0, 2, 200, 200, 0, 255)
						--
						if i <= 37 then
							setMarkerTarget(MarcadoresRuta[i], x2, y2, z2)
							setMarkerIcon ( MarcadoresRuta[i], "arrow" )
						else
							setMarkerIcon ( MarcadoresRuta[i], "finish" )
						end
						--
						addEventHandler("onClientMarkerHit", MarcadoresRuta[i], onMarkerRutHit)
					end
				end
			end
		end
	end
end

function onMarkerRutHit( hitElement )
	if isElement(hitElement) and hitElement:getType() == "player" and hitElement == localPlayer then
		if hitElement:isInVehicle() then
			if hitElement:getData("Roleplay:Mision") == "Licencia" and ValoresTrabajo[hitElement][3] == true then
				local veh = hitElement:getOccupiedVehicle()
				local seat = hitElement:getOccupiedVehicleSeat()
				if veh:getModel() == 410 and seat == 0 then
					if ValoresTrabajo[hitElement][1] ==ValoresTrabajo[hitElement][2] then
						local x, y, z, x2, y2, z2 = unpack(PosicionAuto[1])
						veh:setPosition(x, y, z)
						veh:setRotation(x2, y2, z2)
						veh:setLocked(true)
						veh:setFrozen(true)
						veh:setEngineState(false)
						setTimer(function(hit)
							ValoresTrabajo[hit] = nil
						end, 1000, 1, hitElement)
						triggerServerEvent("ObtenerLicencia", hitElement)
						table.remove(PosicionAuto, 1)
						hitElement:setControlState("enter_exit", true)
						setTimer(function(hitElement)
							if isElement(hitElement) then
								hitElement:setControlState("enter_exit", false)
							end
						end, 1000, 1, hitElement)
					else
						ValoresTrabajo[hitElement][2] = ValoresTrabajo[hitElement][2] + 1
						setTimer(startMision, 50, 1, "Conducir", 1)
					end
					for i=1, #RutaConducir1 do
						if i <= ValoresTrabajo[hitElement][2] then
							if isElement(MarcadoresRuta[i]) then
								destroyElement(MarcadoresRuta[i])
							end
								if isElement(BlipsRuta[i]) then
								destroyElement(BlipsRuta[i])
							end
						end
					end
				end
			end
		end
	end
end

addEvent("IniciarRutaLicencia", true)
function IniciarRutaLicencia(tip)
	if tip == "Conducir" then
		for i=1, #RutaConducir1 do
			if isElement(MarcadoresRuta[i]) then
				destroyElement(MarcadoresRuta[i])
			end
			if isElement(BlipsRuta[i]) then
				destroyElement(BlipsRuta[i])
			end
		end
		ValoresTrabajo[localPlayer] = {nil, 1, true}
		startMision("Conducir", 1)
		failedMision("Conducir", localPlayer, nil, 20)
	end
end
addEventHandler("IniciarRutaLicencia", root, IniciarRutaLicencia)

local TableFailed = {}
local TimerK = {}
local tableN = {}

addEventHandler("onClientPlayerQuit", getRootElement(), function()
	source:setData("Roleplay:Mision", "")
	for i=1, #RutaConducir1 do
		if isElement(MarcadoresRuta[i]) then
			destroyElement(MarcadoresRuta[i])
		end
		if isElement(BlipsRuta[i]) then
			destroyElement(BlipsRuta[i])
		end
	end
	ValoresTrabajo[source] = {nil, 1, false}
	--
	TableFailed[source] = nil;
	TimerK[source] = nil;
	tableN[source] = nil;
	--
	table.remove(PosicionAuto, 1)
end)

addEventHandler("onClientVehicleExit", getRootElement(),
	function(thePlayer, seat)
        if thePlayer == getLocalPlayer() then
        	if seat == 0 then
        		if source:getModel() == 410 then
        			if thePlayer:getData("Roleplay:Mision") == "Licencia" and ValoresTrabajo[thePlayer][3] == true then
        				outputChatBox("Tienes 30 segundos para subir al vehículo o se cancelara la misión.", 150, 50, 50, true)
        				failedMision("Conducir", thePlayer, source, 30)
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
        		if source:getModel() == 410 then
        			if thePlayer:getData("Roleplay:Mision") == "Licencia" and ValoresTrabajo[thePlayer][3] == true then
        				if tableN[thePlayer] == true then
        					if isTimer(TimerK[thePlayer]) then
        						killTimer(TimerK[thePlayer])
								TimerK[thePlayer] = nil;
								tableN[thePlayer] = nil;
        						outputChatBox("¡Perfecto sigue con la misión!", 50, 150, 50, true)
        					end
        				end
        				if not TableFailed[thePlayer] then
        					TableFailed[thePlayer] = not TableFailed[thePlayer]
	        				local x, y, z = getElementPosition(thePlayer)
	        				local x2, y2, z2 = getElementRotation(thePlayer)
	        				table.insert(PosicionAuto, {x, y, z, x2, y2, z2})
	        				triggerEvent("callCinematic", localPlayer, "Conduce por los #FFFF00marcadores #ffffffintenta no ir tan rapido ni chocarte", 20000, "No")
	        			end
        			end
        		end
        	end
        end
    end
)

function failedMision(tip, thePlayer, vehiculo, timer)
	if tip == "Conducir" then
		tableN[thePlayer] = true
		TimerK[thePlayer] = setTimer(function(p, veh)
			if isElement(p) and isElement(veh) then
				p:setData("Roleplay:Mision", "")
				for i=1, #RutaConducir1 do
					if isElement(MarcadoresRuta[i]) then
						destroyElement(MarcadoresRuta[i])
					end
					if isElement(BlipsRuta[i]) then
						destroyElement(BlipsRuta[i])
					end
				end
				ValoresTrabajo[p] = {nil, 1, false}
				if veh and veh ~= nil then
					local x, y, z, x2, y2, z2 = unpack(PosicionAuto[1])
					veh:setPosition(x, y, z)
					veh:setRotation(x2, y2, z2)
					veh:setLocked(true)
					veh:setFrozen(true)
					veh:setEngineState(false)
				end
				--
				TableFailed[p] = nil;
				TimerK[p] = nil;
				tableN[p] = nil;
				--
				table.remove(PosicionAuto, 1)
			end
		end, timer*1000, 1, thePlayer, vehiculo)
	end
end