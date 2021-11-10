local pickups_infos = {

					  { info = "(( Importante: entrar al ayuntamiento si eres nuevo en la cuidad\nAsí conseguiras tu identificación.. ))", 1646.3414306641, -2324.810546875, 13.546875, r = 255, g = 255, b = 255, font = "arial" },

					  { info = "(( Eternal Roleplay v:1.0 ))", 1656.5501708984, -2324.7121582031, 13.546875, r = 255, g = 255, b = 255, font = "arial" },

					  { info = "#FFFF00Si eres nuevo utiliza\n#FFFFFF/empezar", 1656.3167724609, -2313.0981445313, 13.547305107117, r = 255, g = 255, b = 255, font = "default-bold"  },

					  { info = "#FFFF00Si aún no entiendes nada del servidor\n#FFFFFF/intro", 1646.2749023438, -2313.1123046875, 13.557571411133, r = 255, g= 255, b = 255, font= 'default-bold'},

					  { info = "#FFFFFFSi estas cerca a unos de estos vehículo usa estos 2 comandos\nDebes andar apegado a la puerta del vehículo/moto.\n#00FF00/infoveh\n#FF0033/comprarvehiculo", 1239.6877441406, -1661.9959716797, 11.80127620697, r = 255, g = 255, b= 255, font = "default-bold"},

					  { info = "#FFFFFFSi estas cerca a unos de estos vehículo usa estos 2 comandos\nDebes andar apegado a la puerta del vehículo/moto.\n#00FF00/infoveh\n#FF0033/comprarvehiculo", 553.03094482422, -1260.0257568359, 17.2421875, r = 255, g = 255, b= 255, font = "default-bold"},

					  { info = "#FFFFFFSi estas cerca a unos de estos vehículo usa estos 2 comandos\nDebes andar apegado a la puerta del vehículo/moto.\n#00FF00/infoveh\n#FF0033/comprarvehiculo", 1000.1524658203, -1296.6027832031, 13.546875, r = 255, g = 255, b= 255, font = "default-bold"},

					  }



addEventHandler("onClientResourceStart", resourceRoot, function()

	for i, v in pairs( pickups_infos ) do

		Pickup( v[1], v[2], v[3], 3, 1239, 0 )

	end

end)



addEventHandler("onClientRender", getRootElement(), function()

	local playerX2, playerY2, playerZ2 = getElementPosition ( localPlayer )

	for k, v in pairs(pickups_infos) do

		local playerX, playerY, playerZ = v[1], v[2], v[3]

		local sx, sy = getScreenFromWorldPosition(playerX, playerY, playerZ + 0.5)

		if sx and sy then

			local cx, cy, cz = getCameraMatrix()

			local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX, playerY, playerZ + 0.5)

			if distance < 20 then

				dxDrawBorderedText3 ( v.info, sx, sy, sx, sy , tocolor ( v.r, v.g, v.b, 255 ),1, v.font,"center", "center" ) 

			end

		end

	end

end)



function dxDrawBorderedText3( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )

	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)

	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)

end



local posxD = {

			  {359.03103637695, 168.09060668945, 1008.3828125, "#FFA600/obtenerdni\n#FFFFFFSaca un documento de identificación"},

			  {361.82989501953, 173.6374206543, 1008.3828125, "#FFA600/obtenertarjeta\n#FFFFFFSaca una tarjeta de crédito para guardar tu dinero"},

			  }



addEventHandler("onClientRender", getRootElement(), function()

	for k, v in ipairs(posxD) do

		tx, ty, tz = v[1], v[2], v[3]

		local px, py, pz = getElementPosition(localPlayer)

		dist = math.sqrt( ( px - tx ) ^ 2 + ( py - ty ) ^ 2 + ( pz - tz ) ^ 2 )

		if dist < 10 then

			if isLineOfSightClear( px, py, pz, tx, ty, tz, true, false, false, true, false, false, false,localPlayer ) then

				local sx, sy, sz = v[1], v[2], v[3]

				local x, y = getScreenFromWorldPosition( sx, sy, sz)

				if x and y then

					BorderedText ( tostring(v[4]), x-80, y-120, 200 + x-80, 40 + y-120, tocolor ( 253, 206, 97, 255 ),1, "default-bold","center", "center", false, false, false, true, false )

				end

			end

		end

	end

end)



function BorderedText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )

	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) - 1, (y) + 1, (w) - 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)

	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)

	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)

end