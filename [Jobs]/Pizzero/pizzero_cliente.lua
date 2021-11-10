local sx_, sy_ = guiGetScreenSize()

local sx, sy = sx_/1360, sy_/768



local ValoresTrabajo = {}

local PosicionMoto = {}

local MarcadoresRuta = {}

local BlipsRuta = {}

local ColRuta = {}



local MarkerMissionPizzero = {

{2070.5051269531, -1732.1691894531, 13.554683685303},

{2070.7375488281, -1716.9516601563, 13.554683685303},

{2070.6921386719, -1703.3364257813, 13.546875},

{2070.4653320313, -1656.4428710938, 13.546875},

{2070.6513671875, -1644.3940429688, 13.546875},

{2070.8127441406, -1629.4532470703, 13.546875},

{2015.8454589844, -1629.5867919922, 13.546875},

{2012.7303466797, -1641.0537109375, 13.546875},

{2012.2222900391, -1655.212890625, 13.554683685303},

{2013.4427490234, -1703.314453125, 13.546875},

{2013.6428222656, -1716.9073486328, 13.554683685303},

{2013.4641113281, -1733.0849609375, 14.09019947052},

{2147.5231933594, -1733.1131591797, 13.544298171997},

{2159.11328125, -1706.5347900391, 15.078443527222},

{2153.0185546875, -1699.5858154297, 15.0859375},

{2138.4929199219, -1700.2108154297, 15.0859375},

{2165.5361328125, -1674.2106933594, 15.080913543701},

{2242.9438476563, -1639.3067626953, 15.90740776062},

{2256.7197265625, -1644.7537841797, 15.517436027527},

{2281.1516113281, -1642.8653564453, 15.252040863037},

{2306.9069824219, -1677.7452392578, 14.00115776062},

{2328.7866210938, -1681.0997314453, 14.783102035522},

{2325.1354980469, -1719.9178466797, 13.546875},

{2309.23046875, -1715.4739990234, 14.64959526062},

{2288.8842773438, -1773.4580078125, 13.5703125},

{2287.1743164063, -1796.9705810547, 14.40781211853},

{2263.775390625, -1820.4647216797, 13.546875},

{2251.9631347656, -1821.2983398438, 13.55456161499},

{2251.2216796875, -1806.4084472656, 13.546875},

{2234.3981933594, -1807.2009277344, 13.558800697327},

{2326.4992675781, -1770.0548095703, 14.104144096375},

{2364.6086425781, -1801.7863769531, 13.55456161499},

{2390.4853515625, -1802.9758300781, 13.546875},

{2383.7084960938, -1778.4938964844, 14.760021209717},

{2359.7897949219, -1775.2052001953, 15.504143714905},

{2386.3391113281, -1715.5455322266, 13.592032432556},

{2413.7250976563, -1649.12890625, 13.548420906067},

{2394.1364746094, -1649.3229980469, 13.546875},

{2362.955078125, -1645.1624755859, 13.534341812134},

{2367.9299316406, -1673.3028564453, 13.542609214783},

{2409.2160644531, -1673.0540771484, 13.595240592957},

{2430.9125976563, -1668.7237548828, 13.541338920593},

{2451.9638671875, -1644.8358154297, 13.460372924805},

{2469.4074707031, -1648.2596435547, 13.472213745117},

{2486.10546875, -1650.0450439453, 13.479197502136},

{2497.5405273438, -1645.13671875, 13.532939910889},

{2510.5727539063, -1652.3820800781, 13.788597106934},

{2522.4013671875, -1658.8114013672, 15.493547439575},

{2519.3842773438, -1678.6298828125, 14.70912361145},

{2513.1921386719, -1690.3139648438, 13.538021087646},

{2495.7487792969, -1686.3859863281, 13.515480995178},

{2460.0773925781, -1688.3400878906, 13.525228500366},

}



function startMisionPizzero(ruta)

	if localPlayer:getData("Roleplay:trabajo") == "Pizzero" then

		if ruta == 1 then

			if ValoresTrabajo[localPlayer][4] >= 1 then

				local i = MarkerMissionPizzero[math.random(1, #MarkerMissionPizzero)]

				local x, y, z = i[1], i[2], i[3]

				MarcadoresRuta[localPlayer] = Marker(x, y, z-1, "cylinder", 1.3, 200, 200, 0, 80)

				ColRuta[localPlayer] = createColCircle( x, y, 7 )

				BlipsRuta[localPlayer] = createBlipAttachedTo(MarcadoresRuta[localPlayer], 0, 2, 200, 200, 0, 255)

				addEventHandler("onClientColShapeHit", ColRuta[localPlayer], onHitPizzeroCol)

				--

				addEventHandler("onClientMarkerHit", MarcadoresRuta[localPlayer], onHitPizzeroMarker)

			else

				triggerEvent("callCinematic", localPlayer, "¡Ya no tienes suficiente pedidos, ve por mas!", 5000, "No")

				localPlayer:setData("PizzeroPedidos", false)

				local exp = math.random(1,5)

				if exp == 3 then

					triggerServerEvent("givePizzeroExp", localPlayer)

				end

			end

		end

	end

end



function onHitPizzeroMarker(hitElement)

	if isElement(hitElement) and hitElement:getType() == "player" and hitElement == localPlayer then

		if hitElement:getData("Roleplay:trabajo") == "Pizzero" and ValoresTrabajo[hitElement][3] == true then

			if hitElement:isInVehicle() then

				triggerEvent("callCinematic", hitElement, "Baja de la moto y entrega la pizza.", 5000, "No")

			else

				destroyMarkersPizzero()

				if ValoresTrabajo[localPlayer][4] >= 1 then

					setTimer(startMisionPizzero, 50, 1, 1)

					ValoresTrabajo[localPlayer][4] = ValoresTrabajo[localPlayer][4] - 1

					localPlayer:setFrozen(true)

					fadeCamera(false)

					--

					setTimer(function()

						if isElement(localPlayer) then

							localPlayer:setFrozen(false)

							fadeCamera(true)

							--

							triggerServerEvent( "giveMoneyPizzero", localPlayer )

						end

						--

					end, math.random(1,3)*1000, 1, localPlayer)

				else

					triggerEvent("callCinematic", hitElement, "¡Ya no tienes suficiente pedidos, ve por mas!", 5000, "No")

					localPlayer:setData("PizzeroPedidos", false)

				end

			end

		end

	end

end



function onHitPizzeroCol(hitElement)

	if isElement(hitElement) and hitElement:getType() == "player" and hitElement == localPlayer then

		if hitElement:isInVehicle() then

			if hitElement:getData("Roleplay:trabajo") == "Pizzero" and ValoresTrabajo[hitElement][3] == true then

				triggerEvent("callCinematic", hitElement, "Baja de la moto y entrega la pizza.", 5000, "No")

			end

		end

	end

end

--

local mark = Marker(2125.8747558594, -1807.7248535156, 13.554527282715-1, "cylinder", 1.3, 100, 100, 100, 0)

Pickup(2125.8747558594, -1807.7248535156, 13.554527282715, 3, 1582, 0)

--

addCommandHandler("obtenerpedidos", function()

	if localPlayer:isInVehicle() then

		local veh = localPlayer:getOccupiedVehicle( )

		if localPlayer:isWithinMarker(mark) then

			if localPlayer:getData("Roleplay:trabajo") == "Pizzero" and veh:getData("VehiculoPublico") == "Pizzero" then

				if localPlayer:getData("PizzeroPedidos") == true then

					outputChatBox("¡Ya tienes los pedidos, ve a entregarlos!", 150, 50, 50, true)

				else

					triggerEvent("callCinematic", localPlayer, "Ve a entregar los #FFFF005#FFFFFF pedidos..", 5000, "No")

					--

					ValoresTrabajo[localPlayer][4] = 5

					--

					localPlayer:setData("PizzeroPedidos", true)

					--

					startMisionPizzero(1)

				end

			end

		end

	end

end)

--



addEvent( "IniciarPizzero", true )

function IniciarPizzero()

	destroyMarkersPizzero()

end

addEventHandler("IniciarPizzero", root, IniciarPizzero)



local timerCount = {}

local TableSegundos = {}

local PosicionAuto = {}



addEventHandler("onClientVehicleEnter", getRootElement(),

    function(thePlayer, seat)

        if thePlayer == getLocalPlayer() then

        	if seat == 0 then

        		if source:getModel() == 448 then

        			if thePlayer:getData("Roleplay:trabajo") == "Pizzero" then

        				if ValoresTrabajo[localPlayer] then else

	        				local x, y, z = getElementPosition(thePlayer)

	        				local x2, y2, z2 = getElementRotation(thePlayer)

							ValoresTrabajo[localPlayer] = {nil, 1, true, 0}

							table.insert(PosicionAuto, {x, y, z, x2, y2, z2})

        				end

        				if timerCount[localPlayer] then

        					if isTimer(timerCount[localPlayer]) then

        						killTimer( timerCount[localPlayer] )

        						TableSegundos[localPlayer] = nil

								timerCount[localPlayer] = nil

        					end

        				end

        			end

        		end

        	end

        end

    end

)



addEventHandler("onClientVehicleExit", getRootElement(),

	function(thePlayer, seat)

        if thePlayer == getLocalPlayer() then

        	if seat == 0 then

        		if source:getModel() == 448 then

        			if thePlayer:getData("Roleplay:trabajo") == "Pizzero" then

        				if ValoresTrabajo[thePlayer] then

        					if ValoresTrabajo[thePlayer][3] == true then

		        				if not timerCount[localPlayer] then

		        					TableSegundos[localPlayer] = 60

		        					timerCount[localPlayer] = setTimer(function(veh)

		        						if isElement(localPlayer) then

		        							if isElement(veh) then

				        						if TableSegundos[localPlayer] >= 1 then

				        							TableSegundos[localPlayer] = TableSegundos[localPlayer] - 1

				        						else

				        							--

				        							destroyMarkersPizzero()

													if veh and veh ~= nil then

														triggerServerEvent('Roleplay:respawnVehPub',getResourceRootElement( getResourceFromName( '[LS]VehiculosFaccionesJobs' ) ), veh)

													end

				        							ValoresTrabajo[localPlayer] = nil

				        							table.remove(PosicionAuto, 1)

				        							triggerServerEvent("FailedMissionPizzero", localPlayer)

				        							--

							        				if timerCount[localPlayer] then

							        					if isTimer(timerCount[localPlayer]) then

							        						killTimer( timerCount[localPlayer] )

							        						timerCount[localPlayer] = nil

		        											TableSegundos[localPlayer] = nil

							        					end

							        				end

				        						end

				        					end

				        				end

		        					end, 1000, 0, source)

		        				end

		        			end

		        		end

        			end

        		end

        	end

        end

	end

)



function failedMission()

	destroyMarkersPizzero()

	table.remove(PosicionAuto, 1)

	ValoresTrabajo[localPlayer] = nil

	if timerCount[localPlayer] then

		if isTimer(timerCount[localPlayer]) then

			killTimer( timerCount[localPlayer] )

			timerCount[localPlayer] = nil

			TableSegundos[localPlayer] = nil

		end

	end

end

addEvent("failedMission", true)

addEventHandler("failedMission", root, failedMission)



function destroyMarkersPizzero()

	if isElement(MarcadoresRuta[localPlayer]) then

		destroyElement(MarcadoresRuta[localPlayer])

		MarcadoresRuta[localPlayer] = nil

	end

	if isElement(ColRuta[localPlayer]) then

		destroyElement(ColRuta[localPlayer])

		ColRuta[localPlayer] = nil

	end

	if isElement(BlipsRuta[localPlayer]) then

		destroyElement(BlipsRuta[localPlayer])

		BlipsRuta[localPlayer] = nil

	end

end

				

--e

addEventHandler("onClientRender", getRootElement(), function()

	--

	if localPlayer:getData("Roleplay:trabajo") == "Pizzero" then

		if TableSegundos[localPlayer] then

			local segundos = TableSegundos[localPlayer] or 0

			local sW = sx_/1280
			dxDrawBorderedText3("#FF0033"..segundos.."#FFFFFF segundos\npara volver a subir a tu moto.", 96*sW, 502*sy, 251*sW, 532*sy, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center")

		end

	end
 
	--

	local playerX2, playerY2, playerZ2 = getElementPosition ( localPlayer )

	for k, v in pairs(getJobsPizzero()) do

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

	local playerX, playerY, playerZ = 2125.8747558594, -1807.7248535156, 13.554527282715

	local sx, sy = getScreenFromWorldPosition(playerX, playerY, playerZ + 0.5)

	if sx and sy then

		local cx, cy, cz = getCameraMatrix()

		local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX, playerY, playerZ + 0.5)

		if distance < 20 then

			dxDrawBorderedText3 ( "/obtenerpedidos", sx, sy, sx, sy , tocolor (0, 255, 0, 255 ),1, "default-bold","center", "center" ) 

		end

	end

end)



function dxDrawBorderedText3( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )

	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)

	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)

end