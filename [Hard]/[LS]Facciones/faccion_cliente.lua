local blip = {}



addEvent("Police:create_blip", true)

function create_blip(p)

	local pos = Vector3(p:getPosition())

	local x, y, z = pos.x, pos.y, pos.z

	blip[p] = Blip.createAttachedTo(p, 0, 3, 20, 80, 100, 500)

end

addEventHandler("Police:create_blip", root, create_blip)



addEvent("Police:destroy_blip", true)

function destroy_blip(p)

	if isElement(blip[p]) then

		destroyElement(blip[p])

	end

end

addEventHandler("Police:destroy_blip", root, destroy_blip)



local conos = {}



addEvent("ConoCreate", true)

function ConoCreate(x, y, z, int, dim)

	maxConos = #conos

	--

	conos[maxConos + 1] = Object(1238, x, y, z-0.7, 0, 0, 0, false)

	--

	breakObject(conos[maxConos + 1])

	setObjectBreakable(conos[maxConos + 1], false)

	--

	conos[maxConos + 1]:setDimension(dim)

	conos[maxConos + 1]:setInterior(int)

end

addEventHandler("ConoCreate", root, ConoCreate)



addEvent("DestroyConos", true)

addEventHandler("DestroyConos", root, function()

	for cono1, cono2 in ipairs(conos) do

		if isElement(cono2) then

			destroyElement(cono2)

		end

	end

end)



addEvent("playSo", true)

addEventHandler("playSo", root, function()

	playSound("files/dee5cc340eb4d.mp3")

end)



addEventHandler("onClientResourceStart", resourceRoot, function()

	EngineTXD("files/taser.txd"):import(347)

	EngineDFF("files/taser.dff"):replace(347)

end)



--

function fireTaserSound(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement, startX, startY, startZ)

	if (weapon == 23) then

		Sound3D("files/Fire.wav", startX, startY, startZ)

		local s = Sound3D("files/Fire.wav", hitX, hitY, hitZ)

		s:setMaxDistance(50)

		for i=1, 5, 1 do

			Effect.addPunchImpact(hitX, hitY, hitZ, 0, 0, 0)

			Effect.addSparks(hitX, hitY, hitZ, 0, 0, 0, 8, 1, 0, 0, 0, true, 3, 1)

		end

		Effect.addPunchImpact(startX, startY, startZ, 0, 0, -3)

		if (source == localPlayer) then

			toggleControl("fire", false)

			setTimer(function()

				toggleControl("fire", true)

			end, 350, 1)

		end

	end

end

addEventHandler("onClientPlayerWeaponFire", getRootElement(), fireTaserSound)

--

function AnimacionTaser(attacker, weapon, bodypart, loss)

	if (weapon == 23) then

		--if (bodypart == 9) then

		triggerServerEvent("setAnimAndCable", attacker, source)

		cancelEvent()

		--end

	end

end

addEventHandler("onClientPlayerDamage", getRootElement(), AnimacionTaser)



addEventHandler ("onClientPlayerDamage", root, 

function (attacker, weapon)

	if source == localPlayer then

		if localPlayer:getData("NoDamageKill") == true then

			cancelEvent()

		end

	end

end

)



pickups_infos = {

	{ info = "Toca #FFFF00Click Izquierdo #FFFFFFpara salir", 1414.2526855469, -11.995247840881, 1000.9251708984-1, int = 1, dim = 0, r = 255, g = 255, b = 255, font = "default-bold"  },

	{ info = "Toca #FFFF00Click Izquierdo #FFFFFFpara entrar", 2035.0579833984, -1437.3642578125, 17.301803588867-1, int = 0, dim = 0, r = 255, g = 255, b = 255, font = "default-bold"  },

	{ info = "/emergencia\n#004500$100 dólares", 2042.1405029297, -1423.4041748047, 17.1640625, int = 0, dim = 0, r = 150, g = 50, b = 50, font = "default-bold"}

}



addEventHandler("onClientRender", getRootElement(), function()

	local playerX2, playerY2, playerZ2 = getElementPosition ( localPlayer )

	for k, v in pairs(pickups_infos) do

		local playerX, playerY, playerZ = v[1], v[2], v[3]

		local sx, sy = getScreenFromWorldPosition(playerX, playerY, playerZ + 0.5)

		if sx and sy then

			local cx, cy, cz = getCameraMatrix()

			local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX, playerY, playerZ + 0.5)

			if distance < 30 then

				dxDrawBorderedText3 ( v.info, sx, sy, sx, sy , tocolor ( v.r, v.g, v.b, 255 ),1, v.font,"center", "center" ) 

			end

		end

	end

end)







function dxDrawBorderedText3( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )

	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)

	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)

end




--[[

loadstring(exports["[LS]NewData"]:getMyCode())()

import('*'):init('[LS]NewData')





addEventHandler("onClientRender", root, 

	function()

		for i,Text in ipairs(Element.getAllByType('dxDrawTextWorldStatic',getResourceDynamicElementRoot(resource))) do

			local v = getDato(Text, 'TextWorldStatic Datos')
			
			if v then

				if getElementDimension( localPlayer ) == v.Dim and getElementInterior( localPlayer ) == v.Int then

					dxSetRenderTarget(v.Render, true)

						if v.Rec then

							dxDrawRectangle( 1, 1, v.Width + 1, (v.Height*v.SH) , v.Rec, false )

						end

						dxSetBlendMode("modulate_add")

							dxDrawText(v.Text, 1, 1, v.Width + 1, (v.Height*v.SH), v.Color, v.Size, v.Font, "center", "center", false, false, false, true)

						dxSetBlendMode( 'blend' )



					dxSetRenderTarget()



					--dxSetBlendMode("modulate_add")

				    	dxDrawMaterialLine3D(v.X, v.Y, v.Z+0.1, v.X, v.Y, v.Z-0.1, v.Render, v.vSize,tocolor(255, 255, 255, 255))

				   -- dxSetBlendMode("blend")

				end

			end

		end

	end

)







function dxDrawTextWorldStatic(text, x, y, z, font, size, vsize, color, int, dim, bool)

	local count = select ( 2, text:gsub ( '\n', "" ) ) 
	local sH = count == 0 and 1 or count*1.5

	local W,H = dxGetTextWidth((text):gsub('#%x%x%x%x%x%x', ''), (size or 1), (font or 'default-bold') ), dxGetFontHeight( (size or 1), (font or 'default-bold') )
	local render = dxCreateRenderTarget( W,(H*sH), true )
	local textoElement = createElement( 'dxDrawTextWorldStatic' )
	

	if textoElement then

		local Statics = {

			Render = render,

			Text = text,

			Width = W,

			Height = H,

			X = x,

			Y = y,

			Z = z,

			SH = sH,

			Dim = dim or 0,

			Rec = bool or false,

			Int = int or 0,

			Font = (font or 'default-bold'),

			Size = (size or 1),

			vSize = (vsize or 1),

			Color = (color or tocolor(255, 255, 255, 255)), 

		}
		
		setElementDimension(textoElement, (dim or 0))

		setElementInterior(textoElement, (int or 0))

		setElementPosition( textoElement, x, y, z )

		setDato(textoElement, 'TextWorldStatic Datos', Statics, false)

		return textoElement

	end

	return false

end


--

addEvent('dxDrawTextWorld', true)

addEventHandler('dxDrawTextWorld', root,

	function(text, x, y, z, font, size, vsize, color, int, dim)

		dxDrawTextWorldStatic(text, x, y, z, font, size, vsize, color, int, dim)

	end

)



for k, v in pairs(pickups_infos) do

	dxDrawTextWorldStatic(v.info, v[1], v[2], v[3]+1, v.font, 2, 2, tocolor ( v.r, v.g, v.b, 255), v.int, v.dim)	

end]]


