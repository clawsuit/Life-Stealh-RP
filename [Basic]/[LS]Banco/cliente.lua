--[[function check()
	local resource = getResourceFromName( '[LS]Facciones' )
	if resource then
		for i, v in ipairs(getTableATM()) do
			exports['[LS]Facciones']:dxDrawTextWorldStatic("Banco Life Steal\n/fondo\n/retirar -cantidad-\n/depositar -cantidad-",v[1], v[2], v[3]+0.4, "default-bold",1,1,tocolor (0, 255, 0, 255 ),0,0,tocolor(0,0,0,0))
		end
	else
		setTimer(check, 1000,1)		
	end
end
addEventHandler("onClientResourceStart", resourceRoot, check)

]]
addEventHandler("onClientResourceStart", resourceRoot, function()
	for i, v in ipairs(getTableATM()) do
		atmobject = Object( 2942, v[1], v[2], v[3]-0.9 )
		setObjectBreakable(atmobject, false)
		atmobject:setRotation( 0, 0, (360-v.rot) )
		--exports['[LS]Facciones']:dxDrawTextWorldStatic('Banco',v[1], v[2], v[3]+0.4, "default-bold",2,1,tocolor (0, 255, 0, 255 ),0,0)
	end
end)

addEventHandler("onClientRender", getRootElement(), function()
	local playerX2, playerY2, playerZ2 = getElementPosition ( localPlayer )
	for k, v in pairs(getTableATM()) do
		local playerX, playerY, playerZ = v[1], v[2], v[3]
		local sx, sy = getScreenFromWorldPosition(playerX, playerY, playerZ + 0.5)
		if sx and sy then
			local cx, cy, cz = getCameraMatrix()
			local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX, playerY, playerZ + 0.5)
			if distance < 20 then
				dxDrawBorderedText3 ( "Cajero Automatico\n/fondo\n/retirar -cantidad-\n/depositar -cantidad-", sx, sy, sx, sy , tocolor (0, 255, 0, 255/distance ),1/distance*1.4, "default-bold","center", "center" ) 
			end
		end
	end
end)

function dxDrawBorderedText3( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end