addEventHandler("onClientResourceStart", resourceRoot, function()
	for i, v in pairs( getLicenciaArmas() ) do
		p = Pickup( v[1], v[2], v[3], 3, 1239, 0 )
		p:setInterior(v.int)
		p:setDimension(v.dim)
	end
end)

addEventHandler("onClientRender", getRootElement(), function()
	local playerX2, playerY2, playerZ2 = getElementPosition ( localPlayer )
	for k, v in pairs(getLicenciaArmas()) do
		local playerX, playerY, playerZ = v[1], v[2], v[3]
		local sx, sy = getScreenFromWorldPosition(playerX, playerY, playerZ + 0.5)
		if sx and sy then
			local cx, cy, cz = getCameraMatrix()
			local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX, playerY, playerZ + 0.5)
			if distance < 20 then
				dxDrawBorderedText3 ( "Aquí puedes comprar una licencia para porte de armas\nUsa #00FF00/portearma", sx, sy, sx, sy , tocolor ( 255, 255, 255, 255 ),1, "default-bold","center", "center" ) 
			end
		end
	end
end)