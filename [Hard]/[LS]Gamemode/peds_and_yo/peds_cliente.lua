local tablePeds = {}

local pedsCreates = {-- id, x, y, z, int, dim

					{280, 238.96864318848, 112.77579498291, 1003.21875, int = 10, dim = 0, -0, 0, 271.44259643555},

					{280, 253.80041503906, 117.39569091797, 1003.21875, int = 10, dim = 0, -0, 0, 88.408111572266},

					--

					{211, 356.29727172852, 168.23313903809, 1008.3762207031, int = 3, dim = 0, -0, 0, 268.37518310547},

					{217, 359.71392822266, 173.56509399414, 1008.3893432617, int = 3, dim = 0, -0, 0, 268.37518310547},

					{211, 356.29891967773, 178.18142700195, 1008.3762207031, int = 3, dim = 0, -0, 0, 268.37518310547},

					{179, 295.81677246094, -40.216106414795, 1001.515625, int = 1, dim = 0, -0, 0, 4.0784540176392},

					{185, -27.922945022583, -91.637268066406, 1003.546875, int = 18, dim = 0, -0, 0, 359.32171630859},

					{46, -27.922945022583, -91.637268066406, 1003.546875, int = 18, dim = 1, -0, 0, 359.32171630859},

					{47, -27.922945022583, -91.637268066406, 1003.546875, int = 18, dim = 3, -0, 0, 359.32171630859},

					--

					{41, -23.19552230835, -57.335540771484, 1003.546875, int = 6, dim = 0, -0, 0, 355.78100585938},

					{17, -23.19552230835, -57.335540771484, 1003.546875, int = 6, dim = 1, -0, 0, 355.78100585938},

					{11, -23.19552230835, -57.335540771484, 1003.546875, int = 6, dim = 2, -0, 0, 355.78100585938},

					--

					{21, -30.415962219238, -30.675119400024, 1003.5572509766, int = 4, dim = 0, -0, 0, 4.4918169975281},

					{59, -30.415962219238, -30.675119400024, 1003.5572509766, int = 4, dim = 1, -0, 1, 4.4918169975281},

					--

					{205, 377.30221557617, -65.828247070313, 1001.5078125, int = 10, dim = 0, -0, 0, 184.76190185547},

					{205, 377.30221557617, -65.828247070313, 1001.5078125, int = 10, dim = 1, -0, 0, 184.76190185547},

					--

					{155, 374.06842041016, -117.26854705811, 1001.4995117188, int = 5, dim = 0, -0, 0, 180.22494506836},

					--

					{167, 369.64468383789, -4.4848351478577, 1001.8588867188, int = 9, dim = 0, -0, 0, 179.63098144531},

					{167, 369.64468383789, -4.4848351478577, 1001.8588867188, int = 9, dim = 1, -0, 0, 179.63098144531},

					{167, 369.64468383789, -4.4848351478577, 1001.8588867188, int = 9, dim = 2, -0, 0, 179.63098144531},

					--

					{147, 380.68975830078, -188.67991638184, 1000.6328125, int = 17, dim = 0, -0, 0, 90.196853637695},

					{147, 380.68975830078, -188.67991638184, 1000.6328125, int = 17, dim = 1, -0, 0, 90.196853637695},

					-- disco

					{171, 501.73611450195, -20.512786865234, 1000.679687, int = 17, dim = 0, -0, 0, 91.097679138184},

					{172, 501.73611450195, -20.512786865234, 1000.6796875, int = 17, dim = 1, -0, 0, 91.097679138184},

					--

					{211, 161.33842468262, -81.165252685547, 1001.8046875, int = 18, dim = 0, -0, 0, 179.53688049316},

					{211, 204.07200622559, -41.665126800537, 1001.8046875, int = 1, dim = 0, -0, 0, 181.2211151123},

					{211, 207.53428649902, -98.697982788086, 1005.2578125, int = 15, dim = 0, -0, 0, 178.75358581543},

					{211, 204.44842529297, -157.80511474609, 1000.5234375, int = 14, dim = 0, -0, 0, 181.17260742188},

					{211, 204.8529510498, -8.1776332855225, 1001.2109375, int = 5, dim = 0, -0, 0, 267.37921142578},

					--

					{80, 766.60766601563, 14.482738494873, 1000.7000732422, int = 5, dim = 0, -0, 0, 267.21490478516},

					--

					{172, 497.71755981445, -77.461853027344, 998.76507568359, int = 11, dim = 0, -0, 0, 2.1234965324402},

					{172, 497.71755981445, -77.461853027344, 998.76507568359, int = 11, dim = 1, -0, 0, 2.1234965324402},

					--

					{172, -223.30517578125, 1403.4217529297, 27.7734375, int = 18, dim = 0, -0, 0, 93.176399230957},

					}

					

addEventHandler("onClientResourceStart", resourceRoot, function()

	for i, v in ipairs(pedsCreates) do

		Peds = Ped(v[1], v[2], v[3], v[4])

		Peds:setRotation(v[5], v[6], v[7])

		Peds:setInterior(v.int)

		tablePeds[Peds] = Peds

		Peds:setFrozen(true)

		Peds:setDimension(v.dim)

		addEventHandler("onClientPedDamage", Peds, function()

			cancelEvent()

		end)

	end

end)



addEventHandler("onClientRender", getRootElement(), function()

	local px, py, pz = getCameraMatrix( )

	for i, v in ipairs(Element.getAllByType("ped")) do

		if tablePeds[v] then

			tx, ty, tz = getElementPosition(v)

			dist = math.sqrt((px - tx)^2 + (py - ty)^2 + (pz-tz)^2)

			if dist < 15.0 then

				if isLineOfSightClear( px, py, pz, tx, ty, tz, true, false, false, true, false, false, false,localPlayer ) then

					local sx, sy, sz = getPedBonePosition(v, 8)

					local x, y = getScreenFromWorldPosition(sx, sy, sz)

					

					if x and y then

						dxDrawText("[NPC]", x+1, y-60+1, x+1, y-60+1, tocolor(0,0,0,255), 1, "default-bold","center",nil, false, false, false, true, false)

						dxDrawText("[NPC]", x, y-60, x, y-60, tocolor(150, 0, 0,255), 1, "default-bold","center",nil, false, false, false, true, false)

					end

				end

			end

		end

	end

end)



local VerYo = true

local AntiLag = false



addCommandHandler("lag", function()

	if AntiLag == true then

		AntiLag = false

		outputChatBox("Sistema antilag desactivado.", 150, 50, 50, true)

	else

		AntiLag = true

		outputChatBox("Sistema antilag activado.", 150, 50, 50, true)

	end

end)



addCommandHandler("veryo", function()

	if VerYo == true then

		VerYo = false

		outputChatBox("Descripciones de personajes de otros jugadores desactivados.", 150, 50, 50, true)

	else

		VerYo = true

		outputChatBox("Descripciones de personajes de otros jugadores activados.", 150, 50, 50, true)

	end

end)



addEventHandler("onClientRender", root,

	function()

		if VerYo == true then

			local px, py, pz = getCameraMatrix( )

			for k, thePlayer in ipairs(getElementsByType("player")) do

				--if thePlayer ~=localPlayer then

					tx, ty, tz = getElementPosition(thePlayer)

					dist = math.sqrt((px - tx)^2 + (py - ty)^2 + (pz-tz)^2)

					if dist < 15.0 then

						if isLineOfSightClear( px, py, pz, tx, ty, tz, true, false, false, true, false, false, false,localPlayer ) then

							local sx, sy, sz = getPedBonePosition(thePlayer, 8)

							local x, y = getScreenFromWorldPosition(sx, sy, sz)

							local yo = getElementData(thePlayer, "yo")

							local yOff = 0

							if yo then

								if yo[1]:find("#%x%x%x%x%x%x") then

									yo[1] = string.gsub(yo[1],"#%x%x%x%x%x%x","")

								end

							end

							local esposado = thePlayer:getData("Esposado") or false
							local chatText = thePlayer:getData("TextInfo") or {''}

							if yo then

								if x and y then

									dxDrawBourdeText(1, ""..yo[1].."", x, y-60, x, y-60, tocolor((yo[2] or 150),(yo[3] or 0),(yo[4] or 0),255),tocolor(0,0,0,255), 1.5-(dist/15), "default-bold","center",nil, false, false, false, true, false)

								end

							end

							if esposado then

								if x and y then

									dxDrawBourdeText(1, "[Esposado]", x, y-80, x, y-60, tocolor((150),(50),(0),255),tocolor(0,0,0,255), 1.5-(dist/15), "default-bold","center",nil, false, false, false, true, false)

								end

								yOff = 20
							end

							if chatText[1] ~= '' then

								if x and y then

									dxDrawBourdeText(1, chatText[1]..'', x, y-(80+yOff), x, y-60, tocolor((chatText[2] or 150),(chatText[3] or 255),(chatText[4] or 255),255),tocolor(0,0,0,255), 1.4-(dist/15), "default-bold","center",nil, false, false, false, true, false)

								end

							end

						end

					end

				--end

			end

		end

		--

--[[		for k, thePlayer in ipairs(getElementsByType("player")) do

			--if thePlayer ~=localPlayer then

				tx, ty, tz = getElementPosition(thePlayer)

				dist = math.sqrt((px - tx)^2 + (py - ty)^2 + (pz-tz)^2)

				if dist < 15.0 then

					if isLineOfSightClear( px, py, pz, tx, ty, tz, true, false, false, true, false, false, false,localPlayer ) then

						local sx, sy, sz = getPedBonePosition(thePlayer, 8)

						local x, y = getScreenFromWorldPosition(sx, sy, sz)

						local yo = getElementData(thePlayer, "TextInfo")

						if yo then

							if yo[1]:find("#%x%x%x%x%x%x") then

								yo[1] = string.gsub(yo[1],"#%x%x%x%x%x%x","")

							end

						end

						

						if yo and x and y then

							dxDrawText(""..yo[1].."", x+1, y-95+1, x+1, y-60+1, tocolor(0,0,0,255), 1, "default-bold","center",nil, false, false, false, true, false)

							dxDrawText(""..yo[1].."", x, y-95, x, y-60, tocolor((yo[2] or 150),(yo[3] or 0),(yo[4] or 0),255), 1, "default-bold","center",nil, false, false, false, true, false)

						end

					end

				end

			--end

		end]]

	end

)

function dxDrawBourdeText(lines, text, x, y, sx, sy, color, color2, size, font, alignX, alignY,clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
	local lines = lines or 2

	for i= -lines, lines, lines do
		for j= -lines, lines, lines do
			dxDrawText( text:gsub('#%x%x%x%x%x%x',''), x + i, y + j, sx + i, sy + j, color2, size, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
		
		end
	end
	dxDrawText( text, x, y, sx, sy, color, size, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
end